import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: root;

	property bool bBusy: false;
	property bool bFull: false;
	property bool bLock: false;
	property string sTitle;

	allowedOrientations: bLock ? (app.inPortrait ? Orientation.Portrait : Orientation.Landscape) : (settings.iOrientation === 1 ? Orientation.Portrait : (settings.iOrientation === 2 ? Orientation.Landscape : Orientation.Portrait | Orientation.Landscape));
	objectName: "idBasePage";
	showNavigationIndicator: false;

	BusyIndicator{
		id: indicator;
		anchors.centerIn: parent;
		z: constants._iMaxZ;
		running: root.bBusy;
		visible: running;
		/*
		platformStyle: BusyIndicatorStyle{
			inverted: constants._bInverted;
		}
		*/
	 size: BusyIndicatorSize.Large;
	}

	function _Init()
	{
	}

	function _DeInit()
	{
	}
}
