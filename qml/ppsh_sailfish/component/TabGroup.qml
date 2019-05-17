import QtQuick 2.0

Item{
	id: root;

	objectName: "idTabGroup";
	property Item currentTab;

	onCurrentTabChanged: {
		var items = root.children;
		for(var i in items)
		{
			if(items[i] === currentTab)
			{
				items[i].visible = true;
			}
			else
			{
				items[i].visible = false;
			}
		}
	}
}
