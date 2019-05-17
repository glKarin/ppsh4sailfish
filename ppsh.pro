# Add more folders to ship with the application, here
folder_01.source = qml/ppsh
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

js.source = qml/js
js.target = qml
DEPLOYMENTFOLDERS += js

QT += network sql xml widgets multimedia
CONFIG += mobility
MOBILITY += multimedia
INCLUDEPATH += . src src/qtm
DEFINES += _KARIN_MM_EXTENSIONS
MOC_DIR = .moc
OBJECTS_DIR = .obj

DEFINES += _HARMATTAN
DEFINES += _SAILFISH
DEFINES += _DBG
DEFINES += _MAEMO_MEEGOTOUCH_INTERFACES_DEV
CONFIG += videosuiteinterface-maemo-meegotouch
#PKGCONFIG += zlib
LIBS += -lz

contains(DEFINES, _KARIN_MM_EXTENSIONS) {
HEADERS += \
src/qtm/qdeclarativeaudio_p.h \
src/qtm/qdeclarativeplaylist_p.h \
src/qtm/qdeclarativemediametadata_p.h \
src/qtm/private/qmediaserviceprovider_p.h

SOURCES += \
src/qtm/qdeclarativeaudio.cpp \
src/qtm/qdeclarativeplaylist.cpp
}


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    src/utility.cpp \
    src/networkmanager.cpp \
    src/networkconnector.cpp \
		src/id_std.cpp \
		src/player.cpp

splash.files = res/ppsh_splash_natasha.jpg
splash.path = /opt/ppsh/res

i18n.source = i18n
i18n.target = .
DEPLOYMENTFOLDERS += i18n

INSTALLS += splash

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

HEADERS += \
    src/utility.h \
    src/networkmanager.h \
    src/networkconnector.h \
    src/id_std.h \
		src/player.h
