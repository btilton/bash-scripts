#!/bin/bash
# Author: Brian Tilton
# Date  : 06/07/2015
# Title : jsonblob2csv.sh
# Desc  : Quick and dirty script to reformat a terrible json file into something usable
#       :   and then use json2csv to convert to csv

echo -n '{"user": {"name":' > agorablob.fixed &&

sed "s/: {/, /g" agorablob.json | sed $'s/}, /}}\\\n{"user": {"name": /g' >> agorablob.fixed &&

sed -i '' 's/:{/: /g' agorablob.fixed &&

json2csv -k user.name -i agorablob.fixed -o agoranames.txt
