import QtQuick 2.0
import Sailfish.Silica 1.0
import "itemlist.js" as L

Item{
	id: root;
	objectName: "idSelectWidget";
	width: parent.width;
	height: mainlayout.height;
	clip: true;

	property alias sText: mainlayout.label;
	property variant aOptions: [];
	property variant vCurrentValue: null;
	property alias iCurrentIndex: mainlayout.currentIndex;
	property int iMargins: 0;
	signal selected(int index, variant value);
	signal clicked;

	ComboBox{
		id: mainlayout;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.leftMargin: root.iMargins;
		anchors.rightMargin: root.iMargins;
		currentIndex: iCurrentIndex;

		menu: ContextMenu{
			id: col;
		}
	}

	Component{
		id: checkbox;
		MenuItem{
			property int index;
			property variant value;
			property bool enabled: true;

			width: parent.width;
			onClicked: {
				iCurrentIndex = index;
				vCurrentValue = value;
				root.selected(index, value);
			}
			MouseArea{
				anchors.fill: parent;
				enabled: !parent.enabled;
			}
		}
	}

	onAOptionsChanged: {
		L.Clear();
		col._contentColumn.children = [];

		for(var k in aOptions)
		{
			var s = aOptions[k];
			var item = checkbox.createObject(col._contentColumn);
			L.Push(item);
			item.index = k;
			item.text = s.name;
			item.value = s.value;
			if(s.enabled !== undefined)
				item.enabled = s.enabled;
			//console.log(s.text, s.value);
			/*
			item.clicked.connect(function(){
				root.selected(value);
			});
			*/
		}
		if(vCurrentValue !== null && vCurrentValue !== undefined) __SetCurrentChecked(vCurrentValue);
	}

	onVCurrentValueChanged: {
		__SetCurrentChecked(vCurrentValue);
	}

	function __SetCurrentChecked(v)
	{
		var items = col.children;
		for(var i = 0; i < items.length; i++)
		{
			if(items[i].value == v)
			{
				mainlayout.currentIndex = i;
				break;
			}
		}
	}

}
