#!/bin/sh

PRO=ppsh
PLATFORM=_sailfish

lupdate -no-obsolete -recursive src/ main.cpp qml/js/*.js qml/${PRO}${PLATFORM} qml/${PRO}${PLATFORM}/component -ts i18n/${PRO}.zh_CN.ts
