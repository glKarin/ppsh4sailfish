import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
	id: root;
	width: parent.width;
	height: constants._iSizeXXL;
	clip: true;
	objectName: "idButtonWidget";

	property alias sText: title.sText;
	property alias sButtonText: btn.text;
	property alias bEnabled: btn.enabled;
	property int iMargins: 0;
	signal clicked;

	Row{
		anchors.fill: parent;
		anchors.leftMargin: root.iMargins;
		anchors.rightMargin: root.iMargins;
		SectionWidget{
			id: title;
			anchors.verticalCenter: parent.verticalCenter;
			width: parent.width - btn.width;
			onClicked: root.clicked();
		}
		Button{
			id: btn;
			anchors.verticalCenter: parent.verticalCenter;
			width: constants._iSizeBig;
			onClicked: {
				root.clicked();
			}
		}
	}
}
