import QtQuick 2.0
import "itemlist.js" as L

Row{
	id: root;
	objectName: "idButtonRow";
	height: Theme.horizontalPageMargin;
	clip: true;

	property bool exclusive: true;
	property variant checkedButtons: [];

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
		L.Init();
		checkedButtons = [];
		var items = root.children;
		for(var i in items)
		{
			L.Push(items[i]);
		}
		if(L.Count() === 0) return;
		var w = width / L.Count();
		L.Foreach(function(e, i){
			/*
			e.clicked.connect(function(){
				__Checked(e);
			});
			*/
			e.width = w;
			e.down = false;
			if(e.objectName === "idTabButton") e.height = root.height;
		});
		if(exclusive) 
		{
			var first = L.Get(0);
			__Checked(first);
		}
	}

	function __Checked(e)
	{
		if(exclusive)
		{
			for(var i in checkedButtons) checkedButtons[i].down = false;
			e.down = true;
			if(checkedButtons.length === 0) checkedButtons.push(e);
			else checkedButtons[0] = e;
		}
	}
}
