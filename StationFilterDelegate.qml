import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Rectangle
{
	width: isNxt ? 320 : 250
	height: isNxt ? 32 : 25
	color: colors.canvas
	property string kpiPrefix: "stationFilterScreen."

	StandardButton {
		id: filterButton
		controlGroup: stationFilterGroup
		width: isNxt ? 270 : 220
		height: isNxt ? 25 : 20
		radius: 5
		text: name
		fontPixelSize: isNxt ? 18 : 15

		onClicked: {
			app.location = app.locationArray[index];
			app.indexStation = index;
			app.saveSettings();
			app.updateBuienradar();
			hide();
		}
	}
}


