import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
	id: root;

	width: parent.width;
	height: constants._iSizeXL;
	clip: true;
	objectName: "idInputWidget";

	property alias bReadOnly: input.readOnly;
	property alias sText: title.sText;
	property alias sInputText: input.text;
	property alias sPlaceholder: input.placeholderText;
	property alias inputMethodHints: input.inputMethodHints;
	property alias iLabelWidth: title.width;
	property alias eInputMethodHints: input.inputMethodHints;
	property int iMargins: 0;
	signal sure(string text);
	signal textChanged(string text);
	signal cleared;

	Row{
		anchors.fill: parent;
		anchors.leftMargin: root.iMargins;
		anchors.rightMargin: root.iMargins;
		spacing: constants._iSpacingSmall;
		clip: true;
		SectionWidget{
			id: title;
			anchors.verticalCenter: parent.verticalCenter;
			width: constants._iSizeXXXL;
			onClicked: {
				if(!input.readOnly) root._MakeFocus();
			}
		}

		Item{
			width: parent.width - parent.spacing - title.width;
			height: parent.height;
			clip: true;
			TextField{
				id: input;
				anchors.left: parent.left;
				anchors.right: clear.left;
				anchors.verticalCenter: parent.verticalCenter;
				height: parent.height;
				labelVisible: false;
				onTextChanged: {
					root.__Sure();
				}

				EnterKey.enabled: input.text.length > 0;
				EnterKey.highlighted: EnterKey.enabled;
				EnterKey.iconSource: "image://theme/icon-m-enter";
				EnterKey.onClicked: root.__Sure();
			}
			ToolIcon{
				id: clear;
				anchors.right: parent.right;
				anchors.verticalCenter: parent.verticalCenter;
				width: enabled ? height : 0;
				height: parent.height;
				iconId: "toolbar-close";
				enabled: input.text !== "" && !input.readOnly;
				visible: enabled;
				onClicked: {
					root.__Clear();
				}
			}
		}
	}

	function _MakeFocus()
	{
		input.forceActiveFocus();
	}

	function _MakeBlur()
	{
		input.focus = false;
	}

	function __Clear()
	{
		input.text = "";
		cleared();
		_MakeFocus();
	}

	function __Sure()
	{
		sure(input.text);
		_MakeFocus();
	}

}
