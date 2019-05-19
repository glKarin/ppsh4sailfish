import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "component"
import "../js/main.js" as Script
import "../js/main.js" as Util

ApplicationWindow {
	id: app;

	property int __noneDevMenuCount: 4;
	property bool inPortrait: orientation === Orientation.Portrait || orientation === Orientation.PortraitInverted;

	objectName: "idMainWindow";
	initialPage: 
	MainPage
	//PlayerPage
	{
		id: mainpage
	}

	cover: CoverBackground{
		CoverPlaceholder{
			text: _UT.Get("NAME") + "\n" + qsTr("Bilibili") + (pageStack.currentPage ? "\n" + pageStack.currentPage.objectName + "\n" + pageStack.currentPage.sTitle : "");
			icon.source: _UT.Get("ICON_PATH");
		}
	}

	Rectangle{
		anchors.fill: parent;
		color: constants._bInverted ? "#000000" : "#E1E2E3";
		visible: settings.bFullscreen;
		z: -1;
	}

	Connections{
		target: _UT;
		onHasUpdate: {
			var texts = [];
			var updates = _UT.Changelog().CHANGES;
			for(var i in updates)
			{
				texts.push({
					text: updates[i],
				});
			}
			controller._Info(
				qsTr("Info"),
				qsTr("Version") + ": " + version,
				texts,
				undefined,
				function(link){
					eval(link);
				}
			);
		}
	}

	/*
	 Binding{
		 target: Theme;
		 property: "style";
		 value: constants._bInverted;
	 }
	 */

	Constants{
		id: constants;
	}

	SettingsObject{
		id: settings;
	}

	Controller{
		id: controller;
	}

	MenuWidget{
		id: menu;
		anchors.fill: parent;
		sTitle: _UT.Get("NAME") + "\n" + qsTr("Bilibili");
		sIcon: _UT.Get("ICON_PATH");
		tools: [
			ToolIcon{
				iconId: "toolbar-close";
				onClicked: Qt.quit();
			},
			ToolIcon{
				iconId: "toolbar-back";
				visible: pageStack.depth > 1;
				onClicked: {
					menu._Toggle(false);
					if(pageStack.depth > 1)
					{
						var p = pageStack.currentPage;
						if(typeof(p._DeInit() === "function")) p._DeInit();
						pageStack.pop();
					}
				}
			}
		]
		onClicked: {
			if(mouse.x < constants._iSizeXXL)
			{
				_UT.dev ^= 1;
				app.__Dev();
				controller._ShowMessage("Dev " + (_UT.dev !== 0 ? "open" : "close"));
			}
			else controller._ShowMessage(_UT.Get("EGG"));
		}
	}
	Rectangle{
		anchors.horizontalCenter: settings.bTouchIconDrag ? undefined : parent.left;
		anchors.verticalCenter: settings.bTouchIconDrag ? undefined : parent.bottom;
		x: 0 - width / 2;
		y: app.width - height / 2; // do not drag
		width: constants._iSizeXL;
		height: width;
		z: 998;
		color: constants._cGlobalColor;
		opacity: 0.6;
		radius: width / 2;
		visible: !menu.visible && (pageStack.currentPage && !pageStack.currentPage.bFull);
		smooth: true;
		clip: true;
		Rectangle{
			anchors.centerIn: parent;
			width: parent.width * 0.6;
			height: width;
			color: constants._cGlobalColor;
			//opacity: 0.8;
			smooth: true;
			radius: width / 2;
		}
		MouseArea{
			anchors.fill: parent;
			drag.target: parent;
			drag.axis: Drag.XandYAxis;
			drag.minimumY: - parent.height / 2;
			drag.maximumY: app.height - parent.height / 2;
			drag.minimumX: 0 - parent.width / 2;
			drag.maximumX: app.width - parent.width / 2;
			onClicked: {
				menu._Toggle(true);
			}
		}
	}

	InfoBanner{
		id: infobanner;
		topMargin: constants._iSpacingLarge;
		leftMargin: constants._iSpacingMedium;
		z: constants._iMaxZ;
		function _ShowMessage(text)
		{
			infobanner.text = text;
			infobanner.show();
		}
	}

	function __Dev()
	{
		if(_UT.dev !== 0)
		{
			Util.ModelPush(menu.model, {
				label: "TEST",
				name: "Test",
				icon: "transfer",
				func: "controller.__Test();",
			});
			Util.ModelPush(menu.model, {
				label: "Test request",
				name: "TestRequest",
				icon: "share",
				func: "controller._OpenTestRequestPage();",
			});
			Util.ModelPush(menu.model, {
				label: "Test video",
				name: "TestVideo",
				icon: "play",
				func: "controller._OpenTestVideoPage();",
			});
		}
		else
		{
			while(Util.ModelSize(menu.model) > app.__noneDevMenuCount) Util.ModelRemove(menu.model, app.__noneDevMenuCount);
		}
	}

	Component.onCompleted: {
		Util.ModelPush(menu.model, {
			label: qsTr("Browser"),
			name: "Browser",
			icon: "search",
			func: "controller._OpenUrl(undefined, 0);",
		});
		Util.ModelPush(menu.model, {
			label: qsTr("View history"),
			name: "History",
			icon: "folder",
			func: "controller._OpenHistoryPage();",
		});
		Util.ModelPush(menu.model, {
			label: qsTr("Setting"),
			name: "Setting",
			icon: "developer-mode",
			func: "controller._OpenSettingPage();",
		});
		Util.ModelPush(menu.model, {
			label: qsTr("About"),
			name: "About",
			icon: "about",
			func: "controller._OpenAboutPage();",
		});

		__Dev();

		_UT.CheckUpdate();

		Script.Init(_UT, LocalStorage.openDatabaseSync);
	}
}
