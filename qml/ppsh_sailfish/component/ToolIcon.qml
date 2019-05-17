import Sailfish.Silica 1.0

IconButton{
	id: root;

	objectName: "idToolIcon";
	property string iconId;

	onIconIdChanged: {
		icon.source = __HandleIconSource(iconId);
	}

	function __HandleIconSource(iconsrc)
	{
		var icon = __ConvertIconId(iconsrc);
		var prefix = "icon-m-"
		if (icon.indexOf(prefix) !== 0) icon =  prefix.concat(icon);
		return "image://theme/" + icon;
	}

	function __ConvertIconId(iconsrc)
	{
		if(iconsrc.indexOf("toolbar-") !== 0) return iconsrc;
		var icon = iconsrc.substr(8);
		switch(icon)
		{
			case "view-menu":
			case "list":
			return "menu";
			case "favorite-mark":
			return "favorite-selected";
			case "grid":
			return "events";
			case "previous":
			case "tab-previous":
			return "back";
			case "next":
			case "tab-next":
			return "forward";
			case "gallery":
			return "file-image";
			case "application":
			return "about";
			case "directory":
			return "folder";
			case "settings":
			return "developer-mode";
			case "new-chat":
			return "message";
			case "close":
			return "clear";
			case "stop":
			return "clear";
			case "done":
			return "acknowledge";
			case "pages-all":
			return "clipboard";
			case "mediacontrol-play":
			return "play";
			case "mediacontrol-pause":
			return "pause";
			case "mediacontrol-previous":
			return "previous-song";
			case "mediacontrol-next":
			return "next-song";
			case "mediacontrol-stop":
			return "tab";
			default:
			return icon;
		}
	}
}
