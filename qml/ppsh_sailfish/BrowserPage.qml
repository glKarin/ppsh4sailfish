import QtQuick 2.0
import Sailfish.Silica 1.0
import "component"
import "../js/main.js" as Script

BasePage {
	id: root;

	sTitle: qsTr("Browser");
	objectName: "idBrowserPage";

	function _Init(url)
	{
		obj._Request(url);
	}

	QtObject{
		id: obj;

		function __BrowserUrl(url)
		{
			var i = url.indexOf("ppsh://");
			if(i !== 0) return false;
			var value = url.substr(i + 7).toLowerCase();
			switch(value)
			{
				case "about":
				controller._ShowMessage("PPSH Web Browser");
				break;
				case "config":
				mainmenu.open(root);
				break;
				default:
				controller._ShowMessage("Invalid argument: " + value);
				return false;
			}
			return true;
		}

		function _Request(url)
		{
			if(url) input.text = url;
			var u = input.text;
			if(u == "") return;
			if(__BrowserUrl(u)) return;
			var nu = _UT.FormatUrl(u);
			if(!nu)
			{
				nu = "http://m.baidu.com/s?word=" + u;
			}
			if(input.text != nu) input.text = nu;
			webpage.url = nu;
		}
	}

	Header{
		id: header;
		//sText: root.sTitle;
		/*
		 ToolIcon{
			 id: back;
			 anchors.left: parent.left;
			 anchors.verticalCenter: parent.verticalCenter;
			 width: height;
			 iconId: "toolbar-back";
			 onClicked: {
				 pageStack.pop();
			 }
		 }
		 */
		ToolIcon{
			id: backward;
			anchors.left: parent.left; //back.right;
			anchors.verticalCenter: parent.verticalCenter;
			width: visible ? height : 0;
			iconId: "toolbar-tab-previous";
			enabled: webpage.bCanGoBack;
			visible: enabled;
			onClicked: {
				webpage.back();
			}
		}
		ToolIcon{
			id: forward;
			anchors.left: backward.right;
			anchors.verticalCenter: parent.verticalCenter;
			width: visible ? height : 0;
			iconId: "toolbar-tab-next";
			enabled: webpage.bCanGoForward;
			visible: enabled;
			onClicked: {
				webpage.forward();
			}
		}

		Item{
			anchors.left: forward.right;
			anchors.right: menuicon.left;
			anchors.verticalCenter: parent.verticalCenter;
			height: parent.height;
			ToolIcon{
				id: clear;
				anchors.left: parent.left;
				anchors.verticalCenter: parent.verticalCenter;
				width: height;
				height: constants._iSizeLarge;
				clip: true;
				iconId: "toolbar-close";
				enabled: input.text !== "" && !input.readOnly && input.focus;
				visible: enabled;
				onClicked: {
					input.text = "";
					input.forceActiveFocus();
					input.platformOpenSoftwareInputPanel();
				}
			}
			TextField{
				id: input;
				anchors.left: clear.right;
				anchors.right: sp.left;
				anchors.verticalCenter: parent.verticalCenter;
				height: parent.height;
				z: 1;
				clip: true;
				placeholderText: qsTr("Input url or keyword");
				inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase;
				labelVisible: false;

				EnterKey.enabled: input.text.length > 0;
				EnterKey.highlighted: EnterKey.enabled;
				EnterKey.iconSource: "image://theme/icon-m-transfer";
				EnterKey.onClicked: {
					obj._Request();
					input.focus = false;
					webpage.forceActiveFocus();
				}
			}
			ToolIcon{
				id: sp;
				anchors.right: parent.right;
				anchors.verticalCenter: parent.verticalCenter;
				width: height;
				height: constants._iSizeLarge;
				clip: true;
				iconId: webpage.progress != 1 ? "toolbar-stop" : "toolbar-refresh";
				onClicked: {
					if(webpage.progress != 1) webpage.stop();
					else webpage.reload();
				}
			}
		}

		ToolIcon{
			id: menuicon;
			anchors.right: parent.right;
			anchors.verticalCenter: parent.verticalCenter;
			width: height;
			iconId: "toolbar-view-menu";
			onClicked: {
				mainmenu.open(root);
			}
		}
	}

	ProgressBar{
		anchors.verticalCenter: header.bottom;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.leftMargin: constants._iSpacingSuper;
		anchors.rightMargin: constants._iSpacingSuper;
		z: 1;
		visible: value != 1;
		value: webpage.progress;
	}

	WebPage{
		id: webpage;
		anchors.top: header.bottom;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
	}

	ContextMenu{
		id: mainmenu;
		MenuItem {
			text: qsTr("Open externally");
			enabled: webpage.url != "";
			onClicked: {
				if(webpage.url != "") controller._OpenUrl(webpage.url, 1);
			}
		}
		MenuItem{
			text: qsTr("Copy url");
			enabled: webpage.url != "";
			onClicked: {
				if(webpage.url != "") controller._CopyToClipboard(webpage.url);
			}
		}
		MenuItem {
			text: qsTr("Back");
			onClicked: {
				pageStack.pop();
			}
		}
	}

}
