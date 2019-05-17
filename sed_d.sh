#!/bin/bash

DST=flickable
sed -i -e /$DST/d qml/ppsh/*.qml qml/ppsh/component/*.qml
