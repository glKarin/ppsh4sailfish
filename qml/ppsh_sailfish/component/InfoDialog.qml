import QtQuick 2.0
import Sailfish.Silica 1.0

HarmattanCommonDialog {
	id: root;

	objectName: "idInfoDialog";

	property alias sTitle: layout.sTitle;
	property alias aTexts: layout.aTexts;
	property alias vNu: layout.vNu;
	property variant sBottomTitle: "";
	signal linkClicked(string link);
	signal clicked;

	Item{
		id: contentField;
		width: parent.width;
		height: root.__contentHeight;
		Flickable{
			id: flickable;
			anchors.fill: parent;
			clip: true;
			contentWidth: width;
			contentHeight: layout.height;
			TextListWidget{
				id: layout;
				width: parent.width;
				onClicked: root.clicked();
				iPixelSize: constants._iFontXL;
				cColor: "#ffffff";
				onLinkClicked: root.linkClicked(link);
			}
		}

		VerticalScrollDecorator{
			flickable: flickable;
		}
	}

	tools: [
		Text{
			width: root.width;
			height: constants._iSizeLarge;
			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment: Text.AlignVCenter;
			text: root.sBottomTitle;
			color: constants._cLightestColor;
			font.bold: true;
			font.pixelSize: constants._iFontXL;
			wrapMode: Text.WordWrap;
			elide: Text.ElideRight;
			maximumLineCount: 2;
			onLinkActivated: {
				if(link !== "") eval(link);
			}
		}
	]

}
