import QtQuick 2.0
import Sailfish.Silica 1.0

Button{
	id: root;
	objectName: "idTabButton";
	property Item tab;
	signal pressed;

	Connections{
		target: tab !== null && tab.parent !== null ? tab.parent : null;
		onCurrentTabChanged: {
			if(tab)
			{
				var group = tab.parent;
				if(group && group.objectName === "idTabGroup")
				{
					if(group.currentTab === tab)
					{
						var row = root.parent;
						if(row && row.objectName === "idButtonRow") row.__Checked(root);
					}
				}
			}
		}
	}

	onClicked: {
		if(tab)
		{
			var group = tab.parent;
			if(group && group.objectName === "idTabGroup") group.currentTab = tab;
		}
	}

	Component.onCompleted: {
	}
}
