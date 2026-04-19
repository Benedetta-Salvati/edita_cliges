<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0"
    
    >
    <!-- xslt pour grouper les leçons communes -->
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">   
        <xsl:element name="TEI">
            <xsl:apply-templates/>
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template match="tei:teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <xsl:element name="text">
            <xsl:element name="body">
                <xsl:element name="p">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <xsl:element name="l">
         <xsl:attribute name="n">
             <xsl:value-of select="@n"/>
         </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:app">
        <xsl:element name="app">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:rdg|tei:lem">
        
        <!-- variable du noeud courant -->
        <xsl:variable name="valRdg">           
            <xsl:value-of select="."/>            
        </xsl:variable>
        
        <!-- variable du nom d'élément -->
        <xsl:variable name="nomElem">
            <xsl:value-of select="name()"/>
        </xsl:variable>
        
        <xsl:choose>
            
            <!-- lorsque la valeur du noeud connaît des noeuds avec la même valeur (ie leçon commune), et qu'il n'y a pas de noeud précédent ayant cette valeur (ie déjà traité) -->
            <xsl:when test="following-sibling::node()[.=$valRdg] and not(preceding-sibling::node()[.=$valRdg])">
                
                <!-- variable qui enregistre la valeur de tous les témoins -->
                <xsl:variable name="witSameVal">
                    <xsl:value-of select="following-sibling::node()[.=$valRdg]/@wit"/>
                </xsl:variable>     
                
                <!-- création de l'élément (rdg ou lem) -->
                <xsl:element name="{$nomElem}">    
                    
                    <!-- wit avec la valeur du @wit en cours + les wit qui connaissent la même leçon -->
                    <xsl:attribute name="wit">
                        <xsl:value-of select="concat(@wit,' ',$witSameVal)"/>                   
                    </xsl:attribute>  
                    <xsl:value-of select="."/>
                    
                </xsl:element>
                
            </xsl:when>
            
            <!-- quand le noeud précédent est la valeur déjà traitée -->
            <xsl:when test="preceding-sibling::node()[node()=$valRdg]"/>   
            
            
            <!-- dans les autres cas (ie leçon isolée ou, ici, des variantes graphiques), on affiche la leçon -->
            <xsl:otherwise>
                <xsl:element name="{$nomElem}">
                    <xsl:attribute name="wit">
                        <xsl:value-of select="@wit"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
</xsl:stylesheet>