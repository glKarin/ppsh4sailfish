import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
	id: root;

	property bool bListenTextChanged: false;
	property alias sText: input.text;
	property alias bReadOnly: input.readOnly;
	property alias sPlaceholder: input.placeholderText;
	property alias bButtonVisible: btn.visible;
	property alias eInputMethodHints: input.inputMethodHints;
	signal search(string text);
	signal textChanged(string text);
	signal cleared;

	objectName: "idSearchWidget";
	width: parent.width;
	height: constants._iSizeLarge;
	clip: true;

	function __Search()
	{
		var text = input.text;
		if(text !== "")
		root.search(text);
		//_MakeFocus();
	}

	function __Clear()
	{
		input.text = "";
		root.cleared();
		_MakeFocus();
	}

	function _MakeFocus()
	{
		input.forceActiveFocus();
	}

	function _MakeBlur()
	{
		input.focus = false;
	}

	TextField{
		id: input;
		anchors.left: parent.left;
		anchors.right: btn.left;
		anchors.verticalCenter: parent.verticalCenter;
		height: parent.height;
		clip: true;
		labelVisible: false;

		EnterKey.enabled: input.text.length > 0;
		EnterKey.highlighted: EnterKey.enabled;
		EnterKey.iconSource: "image://theme/icon-m-search";
		EnterKey.onClicked: {
			_MakeBlur();
			root.__Search();
		}

		onTextChanged: {
			if(root.bListenTextChanged)
			root.textChanged(text);
		}

	}
	ToolIcon{
		id: clear;
		anchors.right: input.right;
		anchors.verticalCenter: input.verticalCenter;
		iconId: "toolbar-close";
		enabled: input.text !== "" && !input.readOnly;
		visible: enabled;
		z: 1;
		onClicked: {
			root.__Clear();
		}
	}

	ToolIcon{
		id: btn;
		anchors.right: parent.right;
		anchors.verticalCenter: parent.verticalCenter;
		width: height;
		height: visible ? parent.height : 0;
		iconId: "toolbar-search";
		z: 2;
		enabled: input.text !== "";
		onClicked: {
			root.__Search();
		}
	}
}
