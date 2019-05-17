import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/util.js" as Util

HarmattanCommonDialog{
	id: root;
	objectName: "idSelectionDialog";
	property string sField: "";
	property alias model: view.model;
	property int selectedIndex: view.currentIndex;
	signal select(int index, string field, variant data);

	SilicaListView{
		id: view;
		width: parent.width;
		height: root.__contentHeight;
		clip: true;
		visible: count > 0;
		model: []
		delegate: Component{
			Rectangle{
				id: delegateroot;
				color: ListView.isCurrentItem ? Theme.highlightBackgroundColor : constants._cTransparent;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: Theme.itemSizeSmall;
				width: ListView.view.width;
				clip: true;
				Label{
					text: modelData !== undefined ? (modelData.name !== undefined ? modelData.name : (modelData.value !== undefined ? modelData.value : modelData)) : (model !== undefined ? (model.name !== undefined ? model.name : (model.value !== undefined ? model.value : model.toString())) : index);
					anchors.fill: parent;
					anchors.leftMargin: Theme.paddingMedium;
					anchors.rightMargin: Theme.paddingMedium;
					verticalAlignment: Text.AlignVCenter;
					elide: Text.ElideRight;
					color: delegateroot.ListView.isCurrentItem ? Theme.primaryColor : Theme.highlightColor;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: {
						root.selectedIndex = view.currentIndex = index;
						root.accept();
					}
				}
			}
		}
	}

	onAccepted: {
		if(selectedIndex !== -1) root.select(selectedIndex, sField, Util.ModelGet(model, selectedIndex));
	}
}
