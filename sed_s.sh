#!/bin/bash

SRC=ScrollDecorator
DST=VerticalScrollDecorator
sed -i -e s/$SRC/$DST/g qml/ppsh/*.qml qml/ppsh/component/*.qml qml/ppsh/test/*.qml
