import QtQuick 2.0
import Sailfish.Silica 1.0
import "itemlist.js" as L

Row{
	id: root;
	objectName: "idToolBarLayout";
	width: parent ? parent.width : 0;
	height: parent ? parent.height : 0;
	clip: true;
	spacing: Theme.paddingMedium;
	//layoutDirection: Qt.RightToLeft;

	onChildrenChanged: {
		__Relayout();
	}

	Component.onCompleted: {
		__Relayout();
	}

	onWidthChanged: {
		__Relayout();
	}

	onHeightChanged: {
		__Relayout();
	}

	function __Relayout()
	{
	return;
		L.Init();
		var items = root.children;
		for(var i in items)
		{
			if(items[i].visible) L.Push(items[i]);
		}
		if(L.Count() === 0) return;
		var lw = 0;
		var rw = 0;
		var l = 1;
		L.Foreach(function(e, i){
			var y = root.height / 2 - e.height / 2;
			var x = 0;

			if(l)
			{
				x = lw;
				lw += e.width;
			}
			else
			{
				x = root.width - rw - e.width;
				rw += e.width;
			}
			e.x = x;
			e.y = y;
		});
	}

}
