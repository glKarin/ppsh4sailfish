import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
	id: root;
	property alias title: webview.title;
	property real progress: webview.loadProgress / 100;
	property string sUserAgent: webview.experimental.userAgent;
	property alias url: webview.url;
	property alias bCanGoBack: webview.canGoBack;
	property alias bCanGoForward: webview.canGoForward;
	property alias settings: webview.experimental;
	property bool bBrowserHelper: false;
	property bool bAllowDblZoom: false;
	property bool bLoadImage: false;
	signal linkClicked(url link);
	signal alert(string message);

	objectName: "idWebPageWidget";
	function forward()
	{
		webview.goForward();
	}

	function back()
	{
		webview.goBack();
	}

	function reload()
	{
		webview.reload();
	}

	function stop()
	{
		webview.stop();
	}

	SilicaWebView{
		id: webview;
		anchors.fill: parent;
		clip: true;
		experimental.userAgent: "Mozilla/5.0 (Mobile Linux; U; like Android 4.4.3; Sailfish OS/2.0) AppleWebkit/535.19 (KHTML, like Gecko) Version/4.0 Mobile Safari/535.19";
	}
}
