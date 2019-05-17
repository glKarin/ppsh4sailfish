import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/util.js" as Util

Item{
	id: root;
	property alias model: view.model;
	property alias count: view.count;
	signal refresh;
	objectName: "idVideoRowWidget";

	Text{
		anchors.fill: parent;
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		font.bold: true;
		font.pixelSize: constants._iFontSuper;
		elide: Text.ElideRight;
		clip: true;
		color: constants._cLightColor;
		text: qsTr("No content");
		visible: view.count === 0;
		MouseArea{
			anchors.centerIn: parent;
			width: parent.paintedWidth;
			height: parent.paintedHeight;
			onClicked: root.refresh();
		}
	}

	ListView{
		id: view;
		anchors.fill: parent;
		clip: true;
		z: 1;
		orientation: ListView.Horizontal;
		visible: count > 0;
		model: ListModel{}
		delegate: Component{
			VideoGridDelegate{
				width: constants._iSizeTooBig;
				height: ListView.view.height;
				onClicked: {
					controller._OpenDetailPage(aid);
				}
				onImageClicked: {
					controller._OpenPlayerPage(aid);
				}
			}
		}
	}

	HorizontalScrollDecorator{
		flickable: view;
	}
}
