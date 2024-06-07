#!/usr/bin/env python

import os
import xml.etree.ElementTree as ET

xml_file = os.environ.get('HIVE_HOME') + '/conf/metastore-site.xml'

print("[ADD-CONFIG] {} ===================================".format(xml_file))
tree = ET.parse(xml_file)
root = tree.getroot()

for env_var in os.environ:
    if env_var.startswith('METASTORE__'):
        property_name = env_var.split('__')[1]
        env_value = os.getenv(env_var)
        
        property_name = property_name.replace("_", ".")

        # Check if the property is already present in the XML
        property_exists = any(property_element.find('name').text == property_name for property_element in root.findall('.//property'))
        if env_value and not property_exists:
            property_element = ET.Element('property')
            name_element = ET.SubElement(property_element, 'name')
            name_element.text = property_name
            value_element = ET.SubElement(property_element, 'value')
            value_element.text = env_value
            root.append(property_element)
            print("Adding property: {}={}".format(property_name, "**********"))

tree.write(xml_file)
print("Updated {} with environment variable properties.".format(xml_file))
