import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
	id: root;
	width: parent.width;
	height: constants._iSizeXL;
	clip: true;
	objectName: "idSwitchWidget";

	property alias sText: switcher.text;
	property alias checked: switcher.checked;
	property bool enabled: true;
	property int iMargins: 0;
	signal clicked;

	TextSwitch{
		id: switcher;
		anchors.fill: parent;
		leftMargin: root.iMargins;
		rightMargin: root.iMargins;
		// checked: 
		// onCheckedChanged:{ }
		MouseArea{
			anchors.fill: parent;
			enabled: !root.enabled;
		}
	}
}
