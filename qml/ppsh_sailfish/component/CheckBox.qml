import Sailfish.Silica 1.0

TextSwitch{
	id: root;

	objectName: "idCheckBox";
	signal clicked;

	onCheckedChanged: {
		root.clicked();
	}
}
