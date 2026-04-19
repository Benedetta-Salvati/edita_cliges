from lxml import etree

tree = etree.parse("num.xml")
root = tree.getroot()

ns = {"tei": "http://www.tei-c.org/ns/1.0"}

start_n = 926
counter = start_n

for l in root.xpath(".//tei:l", namespaces=ns):
    if "{http://www.w3.org/XML/1998/namespace}id" not in l.attrib:
        l.set("{http://www.w3.org/XML/1998/namespace}id", f"l-{counter}")
        counter += 1

tree.write(
    "output.xml",
    encoding="utf-8",
    xml_declaration=True,
    pretty_print=True
)

print(f"{counter - start_n} vers modifiés")
