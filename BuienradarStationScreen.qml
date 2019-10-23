import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;

Screen {
	id: buienradarStationScreen
	screenTitle: "Selecteer weerstation"

	onShown: {

		stationFilterModel.clear();
		for (var i = 0; i < app.stationArray.length; i++) {
			stationFilterModel.append({name: app.stationArray[i]});
		}

	}


	ControlGroup {
		id: stationFilterGroup
		exclusive: false
	}

	GridView {
		id: stationGridView

		model: stationFilterModel
		delegate: StationFilterDelegate {}

		interactive: false
		flow: GridView.TopToBottom
		cellWidth: isNxt ? 320 : 250
		cellHeight: isNxt ? 30 : 24

		anchors {
			fill: parent
			top: parent.top
			left: parent.left
			topMargin: 5
			leftMargin: 40
		}
	}

	ListModel {
		id: stationFilterModel
	}
}
