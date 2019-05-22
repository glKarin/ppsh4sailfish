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
	signal footerClicked(string link);
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
				onClicked: root.__LinkClicked(undefined, 1);
				iPixelSize: constants._iFontXL;
				cColor: Theme.primaryColor;
				onLinkClicked: root.__LinkClicked(link);
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
			color: Theme.primaryColor;
			font.bold: true;
			font.pixelSize: constants._iFontXXL;
			wrapMode: Text.WordWrap;
			elide: Text.ElideRight;
			maximumLineCount: 2;
			onLinkActivated: root.__LinkClicked(link, 2);

		}
	]

	function __LinkClicked(link, where)
	{
		//root.accept();
		if(where == 2) root.footerClicked(link);
		else if(where == 1) root.clicked();
		else root.linkClicked(link);
	}

	function _Set(title, subtitle, content, bottom)
	{
		root.titleText = title;
		root.sTitle = subtitle;
		root.aTexts = content;
		root.sBottomTitle = bottom || "";
	}
}
