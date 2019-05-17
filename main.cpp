#include <QApplication>
#include <QtQuick>
#include <QLocale>
#include <QTranslator>
#include <QTextCodec>
#include <QDebug>
#include "qmlapplicationviewer.h"

#include "id_std.h"
#include "utility.h"
#include "player.h"
#include "networkconnector.h"
#include "networkmanager.h"

#ifdef _KARIN_MM_EXTENSIONS
#include "qtm/qdeclarativeaudio_p.h"
#include "qtm/qdeclarativeplaylist_p.h"
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
{
	QQmlEngine *engine;
	QQmlContext *context;
	idUtility *ut;
	idPlayer *player;
	idNetworkConnector *connector;
	QGuiApplication *a;
	QTranslator translator;
	QString qm, qmdir;
	const QString RegisterUncreatableTypeMsg(QString("[ERROR]: %1 -> %2").arg("Can not create a single-instance object"));

	a = createApplication(argc, argv);
	QScopedPointer<QGuiApplication> app(a);
	a->setApplicationName(ID_PKG);
	a->setApplicationVersion(ID_VER);
	a->setOrganizationName(ID_DEV);
	//QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));

	QString locale = QLocale::system().name();
#ifdef _HARMATTAN
#ifdef _DBG
	qm = ID_PKG ".zh_CN.qm";
	qmdir = "i18n/";
#else
	qm = QString(ID_PKG ".") + locale;
	qmdir = "/opt/" ID_PKG "/i18n/";
#endif
#else
#ifdef _DBG
	Q_INIT_RESOURCE(ID_PKG);
	qm = QString(":/i18n/" ID_PKG ".") + locale;
#else
	qm = QString("qt_") + locale;
	qmdir = QLibraryInfo::location(QLibraryInfo::TranslationsPath);
#endif
#endif
	if(translator.load(qm, qmdir))
	{
		qDebug() << QString("[INFO]: Load i18n -> %1: %2 [%3]").arg(locale).arg(qm).arg(qmdir);
		a->installTranslator(&translator);
	}
	else
		qWarning() << QString("[DEBUG]: Not found i18n -> %1: %2 [%3]").arg(locale).arg(qm).arg(qmdir);

	QmlApplicationViewer viewer;
	idDeclarativeNetworkAccessManagerFactory factory;
	engine = viewer.engine();
	context = engine->rootContext();

#ifdef _KARIN_MM_EXTENSIONS
	qmlRegisterType<QDeclarativeAudio, 1>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "Audio");
	qmlRegisterType<QDeclarativeAudio, 1>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "MediaPlayer");
	qmlRegisterType<QDeclarativeAudio>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "Audio");
	qmlRegisterType<QDeclarativeAudio>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "MediaPlayer");
	qmlRegisterType<QDeclarativePlaylist>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "Playlist");
	qmlRegisterType<QDeclarativePlaylistItem>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "PlaylistItem");
	//qmlRegisterType<QDeclarativeMediaMetaData>();
#endif
	qmlRegisterUncreatableType<idNetworkConnector>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "NetworkConnector", RegisterUncreatableTypeMsg.arg("idNetworkConnector"));
	qmlRegisterUncreatableType<idPlayer>(ID_QML_URI, ID_QML_MAJOR_VER, ID_QML_MINOR_VER, ID_APP "Player", RegisterUncreatableTypeMsg.arg("idPlayer"));

	ut = idUtility::Instance();
	connector = idNetworkConnector::Instance();
	player = idPlayer::Instance();

	ut->SetEngine(engine);
	engine->setNetworkAccessManagerFactory(&factory);
	connector->SetEngine(engine);

	context->setContextProperty("_UT", ut);
	context->setContextProperty("_CONNECTOR", connector);
	context->setContextProperty("_PLAYER", player);

	viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
	viewer.setMainQmlFile(QLatin1String("qml/ppsh_sailfish/main.qml"));
	viewer.showExpanded();

	return app->exec();
}
