# pythonでxml操作
## xml package
```py3
import xml.etree.ElementTree as ET

# http://docs.python.jp/3.3/library/xml.etree.elementtree.html

# from string
root = ET.fromstring("""<?xml version="1.0" encoding="UTF-8" ?>
<outer><inner>inner text</inner></outer>
""")

print(type(root))
# <class 'xml.etree.ElementTree.Element'>

print(ET.tostring(root))
# b'<outer><inner>inner text</inner></outer>'

# create element
data = ET.Element("tag")
ET.dump(data)
# <tag />

# append a element to a element
data.append(ET.Element("append"))
ET.dump(data)
# <tag><append /></tag>

# append elements to a element
data.extend([
        ET.Element("extend"),
        ET.Element("extend"),
    ])
ET.dump(data)
# <tag><append /><extend /><extend /></tag>

import inspect
print(inspect.getmro(ET.Element))
# (<class 'xml.etree.ElementTree.Element'>, <class 'object'>)

import io
import random

document = ET.Element('outer')
node = ET.SubElement(document, 'inner')
node.text = "inner text"
et = ET.ElementTree(document)

f = random.choice(["element_tree.xml", io.BytesIO()])
et.write(f, encoding='utf-8', xml_declaration=True)
if not type(f) == str:
    print(f.getvalue().decode())

# if BytesIO
# <?xml version='1.0' encoding='utf-8'?>
# <outer><inner>inner text</inner></outer>
```
