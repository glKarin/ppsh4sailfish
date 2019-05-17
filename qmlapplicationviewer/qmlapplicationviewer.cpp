#include "qmlapplicationviewer.h"

#include <QtCore/QDir>
#include <QtCore/QFileInfo>
#include <sailfishapp.h>
#include <QtWidgets/QApplication>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickView>

static QString adjustPath(const QString &path)
{
	const QString pathInInstallDir =
		QString::fromLatin1("%1/%2").arg("/usr/share/ppsh/", path);
	if (QFileInfo(pathInInstallDir).exists())
		return pathInInstallDir;
	return path;
}

QmlApplicationViewer::QmlApplicationViewer()
	: viewer(SailfishApp::createView())
{
}

QmlApplicationViewer * QmlApplicationViewer::create()
{
	return new QmlApplicationViewer;
}

void QmlApplicationViewer::setMainQmlFile(const QString &file)
{
	QString mainQmlFile = adjustPath(file);
	viewer->setSource(QUrl::fromLocalFile(mainQmlFile));
}

void QmlApplicationViewer::addImportPath(const QString &path)
{
	viewer->engine()->addImportPath(adjustPath(path));
}

void QmlApplicationViewer::setOrientation(QmlApplicationViewer::ScreenOrientation orientation)
{
	Q_UNUSED(orientation);
}

void QmlApplicationViewer::showExpanded()
{
	viewer->show();
}

QQmlEngine * QmlApplicationViewer::engine()
{
	return viewer->engine();
}

QGuiApplication * createApplication(int &argc, char **argv)
{
	return SailfishApp::application(argc, argv);
}
