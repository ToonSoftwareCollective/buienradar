import QtQuick 2.1
import qb.components 1.0

Screen {
	id: buienradarActualRadarScreen

	screenTitle: "Actuele Buienradar";

	onCustomButtonClicked: {
		if (app.buienradarEditLonLatScreen) {
			app.buienradarEditLonLatScreen.show();
		}
	}

	onShown: {
		addCustomTopRightButton("Locatie");
		stillRadarImage.visible = false;
		bigRadarImage.visible = true;
	}


	Rectangle {
		id:bigRadarImage
		anchors {
			baseline: parent.top
			left: parent.left
			leftMargin: 50
		}
		visible: true
   		AnimatedImage { id: animation; source: app.radarimagesurl }
	}

	Image {
		id: stillRadarImage
		source: app.stillimagesurl
		anchors {
			baseline: parent.top
			left: parent.left
			leftMargin: 50
		}
		visible: false
	}

	StandardButton {
		id: btnBuienradar
		width: isNxt ? 130 : 105
		text: "Buienradar"
		anchors {
			baseline: parent.top
			left: parent.left
			leftMargin: isNxt ? 660 : 475
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/RadarMapNL?w=600&h=600";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/RadarMapNL?w=400&h=400";
			}
			setTitle("Actuele Buienradar");
		}
	}

	StandardButton {
		id: btnBuienradarEU
		width: isNxt ? 45 : 40
		text: "EU"
		anchors {
			baseline: parent.top
			left: btnBuienradar.right
			leftMargin: 10
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/radarmapeu/?nt=0&hist=-1&forc=37&step=1&w=600&h=600";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/radarmapeu/?nt=0&hist=-1&forc=37&step=1&w=400&h=400";
			}
			setTitle("Actuele Buienradar Europa");
		}
	}

	StandardButton {
		id: btnBuienradar2
		width: isNxt ? 45 : 40
		text: "+1u"
		anchors {
			baseline: parent.top
			left: btnBuienradarEU.right
			leftMargin: 10
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/radarmapnl/?nt=0&hist=-1&forc=13&step=1&w=600&h=600";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/radarmapnl/?nt=0&hist=-1&forc=13&step=1&w=400&h=400";
			}
			setTitle("Actuele Buienradar 1 uur vooruit");
		}
	}

	StandardButton {
		id: btnBuienradar3
		width: isNxt ? 45 : 40
		text: "+3u"
		anchors {
			baseline: parent.top
			left: btnBuienradar2.right
			leftMargin: 10
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://image.buienradar.nl/2.0/image/animation/RadarMapRainNL?extension=gif&width=600&height=600&history=0&forecast=18";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/radarmapnl/?nt=0&hist=-1&forc=37&step=2&h=400&w=400";
			}
			setTitle("Actuele Buienradar 3 uur vooruit");
		}
	}

	StandardButton {
		id: btnBuienradar4
		width: isNxt ? 45 : 40
		text: "+24u"
		anchors {
			baseline: parent.top
			left: btnBuienradar3.right
			leftMargin: 10
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/24hourforecastmapnl/?nt=0&hist=-1&forc=13&step=0&h=600&w=600";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/24hourforecastmapnl/?nt=0&hist=-1&forc=13&step=0&h=400&w=400";
			}
			setTitle("Actuele Buienradar 24 uur vooruit");
		}
	}

	StandardButton {
		id: btnMotregenradar
		width: isNxt ? 350 : 305
		text: "Motregenradar"
		anchors {
			top: btnBuienradar.bottom
			topMargin: 10
			left: btnBuienradar.left
		}
		onClicked: {
			stillRadarImage.visible = false;
			bigRadarImage.visible = true;
			if (isNxt) {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/drizzlemapnl/gif/?w=600";
			} else {
				app.radarimagesurl = "https://api.buienradar.nl/image/1.0/drizzlemapnl/gif/?w=400";
			}
			setTitle("Motregenradar");
		}
	}

	StandardButton {
		id: btnMuggenradar
		width: isNxt ? 350 : 305
		text: "Muggenradar"
		anchors {
			top: btnMotregenradar.bottom
			topMargin: 10
			left: btnBuienradar.left
		}
		onClicked: {
			setTitle("Muggenradar");
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/mosquitoradarnl/gif/?h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/mosquitoradarnl/gif/?h=400";
			}
		}
	}

	StandardButton {
		id: btnPollenradar
		width: isNxt ? 350 : 305
		text: "Pollenradar"
		anchors {
			top: btnMuggenradar.bottom
			topMargin: 10
			left: btnMuggenradar.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/pollenradarnl/gif/?h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/pollenradarnl/gif/?h=400";
			}
			setTitle("Pollenradar");
		}
	}

	StandardButton {
		id: btnBBQradar
		width: isNxt ? 350 : 305
		text: "BBQ radar"
		anchors {
			top: btnPollenradar.bottom
			topMargin: 10
			left: btnPollenradar.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/bbqradarnl/gif/?h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/bbqradarnl/gif/?h=400";
			}
			setTitle("Barbeque radar"); 
		}
	}


	StandardButton {
		id: btnActueleTemperatuur
		width: isNxt ? 350 : 305
		text: "Actuele Temperatuur"
		anchors {
			top: btnBBQradar.bottom
			topMargin: 10
			left: btnBBQradar.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=temperature&h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=temperature&h=400";
			}
			setTitle("Actuele temperatuur"); 
		}
	}

	StandardButton {
		id: btnMinTemperatuur
		width: isNxt ? 100 : 80
		text: "Minimum"
		anchors {
			top: btnActueleTemperatuur.bottom
			topMargin: 10
			left: btnActueleTemperatuur.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=mintemperature&h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=mintemperature&h=400";
			}
			setTitle("Minimum temperatuur vandaag"); 
		}
	}

	StandardButton {
		id: btnMaxTemperatuur
		width: isNxt ? 240 : 215
		text: "Maximum Temperatuur"
		anchors {
			top: btnActueleTemperatuur.bottom
			topMargin: 10
			left: btnMinTemperatuur.right
			leftMargin: 10
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=maxtemperature&h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=maxtemperature&h=400";
			}
			setTitle("Maximum temperatuur vandaag"); 
		}
	}

	StandardButton {
		id: btnActueleWind
		width: isNxt ? 350 : 305
		text: "Actuele Windkracht"
		anchors {
			top: btnMinTemperatuur.bottom
			topMargin: 10
			left: btnMinTemperatuur.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=windspeedbft&h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=windspeedbft&h=400";
			}
			setTitle("Actuele windkracht"); 
		}
	}

	StandardButton {
		id: btnMinimumGroundTemp
		width: isNxt ? 350 : 305
		text: "Minimum grondtemperatuur"
		anchors {
			top: btnActueleWind.bottom
			topMargin: 10
			left: btnActueleWind.left
		}
		onClicked: {
			stillRadarImage.visible = true;
			bigRadarImage.visible = false;
			if (isNxt) {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=mingroundtemperature&h=600";
			} else {
				app.stillimagesurl = "https://api.buienradar.nl/image/1.0/weathermapnl/?type=mingroundtemperature&h=400";
			}
			setTitle("Min. grondtemperatuur vandaag");
		}
	}
}
