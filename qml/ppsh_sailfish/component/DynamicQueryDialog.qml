import QtQuick 2.0
import Sailfish.Silica 1.0

HarmattanCommonDialog{
	id: root;
	objectName: "idQueryDialog";

	property alias message: content.text;

	Label{
		id: content;
		width: parent.width;
		wrapMode: Text.WordWrap;
		horizontalAlignment: Text.AlignHCenter;
	}
}
