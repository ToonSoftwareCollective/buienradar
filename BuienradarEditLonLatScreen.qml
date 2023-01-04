import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

import BxtClient 1.0
import "buienradar.js" as BuienradarJS

Screen {
	id: lonlatEntryScreen

	property string qrCodeID

	function saveLon(text) {
		//rounding at 2 decimals
		if (text) {
			app.lon = (Math.round(parseFloat(text.replace(",", ".")) * 100) / 100);
			lonLabel.inputText = app.lon;
	   		app.saveSettings();
		}
	}

	function saveLat(text) {
		//rounding at 2 decimals
		if (text) {
			app.lat = (Math.round(parseFloat(text.replace(",", ".")) * 100) / 100);
			latLabel.inputText = app.lat;
	   		app.saveSettings();
			findNearestWeatherStation();
		}
	}

	function validateCoordinate(text, isFinalString) {
		return null;
	}

	hasCancelButton: true
	hasSaveButton: false

	screenTitle: "Buienradar settings"

	onShown: {
		addCustomTopRightButton("Opslaan");
		if (app.indexStation > -1) stationLabel.inputText = app.stationArray[app.indexStation]; 
		lonLabel.inputText = app.lon;
		latLabel.inputText = app.lat;
		dimSunDownLabel.inputText = app.autoDimlevelSunDown;
		dimSunUpLabel.inputText = app.autoDimlevelSunUp;
		yaxisLabel.inputText = app.yaxisScale;
		autoDimToggle.isSwitchedOn = app.autoAdjustDimBrightness ;
	}
	
	function toRad(x) {
    		return x * Math.PI / 180;
  	}
	
	function haversineDistance(lat1, lon1, lat2, lon2) {

		var R = 6371; // km
		var x1 = lat2 - lat1;
  		var dLat = toRad(x1);
  		var x2 = lon2 - lon1;
  		var dLon = toRad(x2);
  		var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
		var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  		var d = R * c;
		return d;
	}

	function findNearestWeatherStation() {

		var nearestDistance = 1000000;	// a random very high number :-)
		var nearestStation = "";
		var distance = 0;
		for (var i = 0; i < app.stationArray.length; i++) {
			distance = haversineDistance(parseFloat(app.lat), parseFloat(app.lon), parseFloat(app.latArray[i]), parseFloat(app.lonArray[i])); 			
			if (nearestDistance > distance) {
				nearestDistance = distance;
				nearestStation = app.locationArray[i];
			}
		}
		app.location = nearestStation;
		app.indexStation = app.locationArray.indexOf(parseInt(app.location))
		app.saveSettings();
		app.updateBuienradar();
		stationLabel.inputText = app.stationArray[app.indexStation]; 
		qdialog.showDialog(qdialog.SizeLarge, "Buienradar mededeling", "Op basis van de ingevoerde lat/lon coordinaten is het volgende dichtsbijzijnde weerstation geselekteerd:\n\nStation: " + app.stationArray[app.indexStation] + "\nAfstand : " + (Math.round(nearestDistance * 100) / 100) + " km", "Sluiten");
	}

	onCustomButtonClicked: {
		app.saveSettings();
		app.updateRegenkans();
		hide();
	}

	Text {
		id: title
		text: "Invoeren GPS coordinaten (2 decimalen) voor de exacte regenverwachting en automatische selektie van het dichtsbijzijnde weerstation."
       		width: isNxt ? 500 : 400
        	wrapMode: Text.WordWrap
		font.pixelSize: isNxt ? 20 : 16
		font.family: qfont.semiBold.name
		color: colors.rbTitle

		anchors {
			left: lonButton.right
			leftMargin: 20
			top: lonButton.top
		}

	}

	EditTextLabel4421 {
		id: lonLabel
		width: isNxt ? 350 : 280
		height: isNxt ? 45 : 35
		leftText: "Lengtegraad:"
		leftTextAvailableWidth: isNxt ?  175 : 140

		anchors {
			left: parent.left
			leftMargin: 40
			top: parent.top
			topMargin: 30
		}

		onClicked: {
			qnumKeyboard.open("Lengtegraad", lonLabel.inputText, app.lon, 1 , saveLon, validateCoordinate);
		}
	}

	IconButton {
		id: lonButton
		width: isNxt ? 50 : 40

		iconSource: "qrc:/tsc/edit.png"

		anchors {
			left: lonLabel.right
			leftMargin: 6
			top: lonLabel.top
		}

		bottomClickMargin: 3
		onClicked: {
			qnumKeyboard.open("Lengtegraad", lonLabel.inputText, app.lon, 1 , saveLon, validateCoordinate);
		}
	}

	EditTextLabel4421 {
		id: latLabel
		width: lonLabel.width
		height: isNxt ? 45 : 35
		leftText: "Breedtegraad:"
		leftTextAvailableWidth: isNxt ?  175 : 140

		anchors {
			left: lonLabel.left
			top: lonLabel.bottom
			topMargin: 6
		}

		onClicked: {
			qnumKeyboard.open("Breedtegraad", latLabel.inputText, app.lat, 1 , saveLat, validateCoordinate);
		}
	}

	IconButton {
		id: latButton
		width: isNxt ? 50 : 40
		iconSource: "qrc:/tsc/edit.png"

		anchors {
			left: latLabel.right
			leftMargin: 6
			top: lonLabel.bottom
			topMargin: 6
		}

		topClickMargin: 3
		onClicked: {
			qnumKeyboard.open("Breedtegraad", latLabel.inputText, app.lat, 1 , saveLat, validateCoordinate);
		}
	}

	EditTextLabel4421 {
		id: stationLabel
		width: lonLabel.width
		height: isNxt ? 45 : 35
		leftText: "Weerstation:"
		leftTextAvailableWidth: isNxt ?  175 : 140

		anchors {
			left: lonLabel.left
			top: latLabel.bottom
			topMargin: 6
		}

		onClicked: {
  	              if (app.buienradarStationScreen) {
  	                     app.buienradarStationScreen.show();
  	              }

		}
	}

	IconButton {
		id: stationButton
		width: isNxt ? 50 : 40
		iconSource: "qrc:/tsc/edit.png"

		anchors {
			left: stationLabel.right
			leftMargin: 6
			top: latLabel.bottom
			topMargin: 6
		}

		topClickMargin: 3
		onClicked: {
 	              if (app.buienradarStationScreen) {
  	                     app.buienradarStationScreen.show();
  	              }

		}
	}

	Text {
		id: uitlegStation
		text: "Eventuele handmatige selektie weerstation."
       		width: isNxt ? 500 : 400
		anchors {
			left: stationButton.right
			leftMargin: 20
			top: stationButton.top
		}
		font {
			family: qfont.semiBold.name
			pixelSize: isNxt ? 20 : 16
		}
		color: colors.rbTitle
	}
}
