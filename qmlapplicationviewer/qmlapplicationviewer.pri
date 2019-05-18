#pkgconfig(sailfishapp)
CONFIG += sailfishapp

QT += quick qml 

SOURCES += $$PWD/qmlapplicationviewer.cpp
HEADERS += $$PWD/qmlapplicationviewer.h
INCLUDEPATH += $$PWD

defineTest(qtcAddDeployment) {
	for(deploymentfolder, DEPLOYMENTFOLDERS) {
		item = item$${deploymentfolder}
		itemsources = $${item}.sources
			$$itemsources = $$eval($${deploymentfolder}.source)
			itempath = $${item}.path
			$$itempath= $$eval($${deploymentfolder}.target)
			export($$itemsources)
			export($$itempath)
			DEPLOYMENT += $$item
	}

	MAINPROFILEPWD = $$PWD

		desktopfile.files = $${TARGET}.desktop
		desktopfile.path = /usr/share/applications
		icon80.files = $${TARGET}80.png
		icon80.path = /usr/share/icons/hicolor/80x80/apps

		installPrefix = /usr/share/$${TARGET}
	for(deploymentfolder, DEPLOYMENTFOLDERS) {
		item = item$${deploymentfolder}
		itemfiles = $${item}.files
			$$itemfiles = $$eval($${deploymentfolder}.source)
			itempath = $${item}.path
			$$itempath = $${installPrefix}/$$eval($${deploymentfolder}.target)
			export($$itemfiles)
			export($$itempath)
			INSTALLS += $$item
	}

		export(icon80.files)
			export(icon80.path)
			export(desktopfile.files)
			export(desktopfile.path)
			INSTALLS += icon80 desktopfile

	target.path = /usr/bin
		export(target.path)
		INSTALLS += target

		export (ICON)
		export (INSTALLS)
		export (DEPLOYMENT)
		export (TARGET.EPOCHEAPSIZE)
		export (TARGET.CAPABILITY)
		export (LIBS)
		export (QMAKE_EXTRA_TARGETS)
}
