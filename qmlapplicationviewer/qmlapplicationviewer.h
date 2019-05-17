#ifndef QMLAPPLICATIONVIEWER_H
#define QMLAPPLICATIONVIEWER_H

#include <QString>

class QQuickView;
class QGuiApplication;
class QQmlEngine;

struct QmlApplicationViewer
{
	QmlApplicationViewer();
	enum ScreenOrientation {
		ScreenOrientationLockPortrait,
		ScreenOrientationLockLandscape,
		ScreenOrientationAuto
	};
	static QmlApplicationViewer *create();
	void setMainQmlFile(const QString &file);
	void addImportPath(const QString &path);
	void setOrientation(ScreenOrientation orientation);
	void showExpanded();
	QQmlEngine * engine();

	QQuickView *viewer;
};

QGuiApplication *createApplication(int &argc, char **argv);

#endif // QMLAPPLICATIONVIEWER_H
