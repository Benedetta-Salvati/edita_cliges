<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    
    <xsl:template match="l">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:number format="1" level="any"/>
            </xsl:attribute>
            
            <xsl:attribute name="id">
                <xsl:number format="1" level="any"/>
            </xsl:attribute>
           
            
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
