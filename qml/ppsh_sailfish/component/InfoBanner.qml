import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
	id: root;
	property int topMargin;
	property int leftMargin;
	property alias text: label.text;
	property bool timerEnabled: true;
	property int timerShowTime: 3000;

	anchors.top: parent.top;
	anchors.topMargin: topMargin;
	anchors.horizontalCenter: parent.horizontalCenter;
	width: parent.width - leftMargin / 2;
	height: docked.height;
	visible: docked.expanded;
	z: 500;

	function show()
	{
		if(root.timerEnabled && docked.open && timer.running) timer.restart();
		else docked.show();
	}

	function hide()
	{
		timer.stop();
		docked.hide();
	}

	DockedPanel{
		id: docked;
		dock: Dock.Top;
		clip: true;
		height: label.height;
		width: parent.width;

		Label{
			id: label;
			width: parent.width;
			wrapMode: Text.WrapAnywhere;
		}

		onOpenChanged: {
			if(root.timerEnabled && open) timer.restart();
		}
	}

	MouseArea{
		anchors.fill: parent;
		onClicked: {
			root.hide();
		}
	}

	Timer{
		id: timer;
		interval: root.timerShowTime;
		repeat: false;
		onTriggered: {
			docked.hide();
		}
	}
}
