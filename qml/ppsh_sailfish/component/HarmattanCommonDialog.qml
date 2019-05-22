import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
	id: genericDialog

	objectName: "idHarmattanCommonDialog";
	property string titleText: "";
	property bool bAutoDestroy: true;
	property bool bAutoOpen: true;
	property alias tools: btns.children;
	default property alias contents: contentField.children;
	property alias acceptText: header.acceptText;
	property alias rejectText: header.cancelText;

	property int __compUsed: separator.height + header.height + footer.height + Theme.paddingSmall * 2;
	property int __contentHeight: Math.max(genericDialog.height - __compUsed, 360);

	property bool __isClosing: false;
	onStatusChanged: {
		if(bAutoDestroy)
		{
			if (status == DialogStatus.Closing)
			{
				__isClosing = true;
			}
			else if (status == DialogStatus.Closed && __isClosing)
			{
				root.destroy(250);
			}
		}
	}

	DialogHeader{
		id: header
		title: genericDialog.titleText;
	}

	Separator{
		id: separator;
		anchors.top: header.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		width: parent.width - Theme.horizontalPageMargin * 2;
		color: Theme.secondaryColor;
	}

	Item {
		id: contentField;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.top: separator.bottom;
		anchors.topMargin: Theme.paddingSmall;
		height: childrenRect.height;
	}

	Item {
		id: footer
		anchors.left: parent.left;
		anchors.right: parent.right;
		//anchors.bottom: parent.bottom;
		anchors.top: contentField.bottom;
		anchors.topMargin: Theme.paddingSmall;
		height: childrenRect.height;
		clip: true;

		Item {
			id: lineWrapper
			width: parent.width
			height: Theme.itemSizeExtraSmall;

			Rectangle {
				id: footerLine
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter;
				height: btns.children.length > 0 ? 1 : 0;
				visible: height > 0;
				color: "#4D4D4D"
			}
		}

		Item {
			id: btns;
			anchors.top: lineWrapper.bottom;
			anchors.horizontalCenter: parent.horizontalCenter;
			width: childrenRect.width;
			height: childrenRect.height;
			clip: true;
		}
	}

	Component.onCompleted: {
		if(bAutoOpen) open();
	}
}

