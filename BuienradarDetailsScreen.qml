import QtQuick 2.1
import qb.components 1.0
import "buienradar.js" as BuienradarJS

Screen {
	id: buienradarDetailsScreen

	screenTitle: "Actueel weer plus weersverwachting";

	property bool dimState: screenStateController.dimmedColors;

	onCustomButtonClicked: {
		if (app.buienradarEditLonLatScreen) {
			 app.buienradarEditLonLatScreen.show();
		}
	}

	onShown: {
		addCustomTopRightButton("Locatie");
		fivedayforecastModel.clear();
		for (var i = 0; i < app.fivedayforecast.length; i++) {
			fivedayforecastModel.append(app.fivedayforecast[i]);
		}
		actualWeatherModel.clear();
		for (var i = 0; i < app.actualweather.length; i++) {
			actualWeatherModel.append(app.actualweather[i]);
		}
	}

//selected weatherstation data

	Rectangle {
		id: backgroundRect
		height: isNxt ? 240 : 190
		width: isNxt ? 345 : 275
		anchors {
			baseline: parent.top
			baselineOffset: 5
			left: parent.left
			leftMargin: 5
		}
		color: colors.addDeviceBackgroundRectangle
	}

	Rectangle {
		id: backgroundRect2
		height: isNxt ? 240 : 190
		width:  isNxt ? 655 : 500
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 5 : 5
			right: parent.right
			rightMargin: 5
		}
		color: colors.addDeviceBackgroundRectangle
	}

	Rectangle {
		color: "#FFFF00"
		width: backgroundRect.width
		height: isNxt ? 35 : 28
		anchors {
			top: backgroundRect.top
			left: backgroundRect.left
		}
	}
	

//weatherforecast data for selected weather station

	GridView {
		id: grid

		model: actualWeatherModel
		delegate: actualDelegateGrid

		interactive: false
		flow: GridView.TopToBottom
		cellWidth: isNxt ? 175 : 140
		cellHeight: backgroundRect.height
		height: backgroundRect.height
		width: parent.width
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 32 : 24
			left: parent.left
			leftMargin: 10
		}
	}


	ListModel {
		id: actualWeatherModel
	}

	Component {
		id: actualDelegateGrid

		Item {
			width: grid.width / grid.columns
		        height: grid.height
			Rectangle {
				anchors.fill: parent

			 	Text {
					id: txtstation
					text: location
					anchors {
						baseline: parent.top
					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}


				Text {
					id: txttemperature
					text: temperature
					anchors {
						top: txtstation.bottom
						topMargin: isNxt ? 5 : 4
					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txtwindsnelheid
					text: windsnelheid
					anchors {
						top: txttemperature.bottom
						topMargin: isNxt ? 5 : 4

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txtwindrichting
					text: windrichting
					anchors {
						top: txtwindsnelheid.bottom
						topMargin: isNxt ? 5 : 4

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txthumidity
					text: luchtvochtigheid
					anchors {
						top: txtwindrichting.bottom
						topMargin: isNxt ? 5 : 4

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txtluchtdruk
					text: luchtdruk
					anchors {
						top: txthumidity.bottom
						topMargin: isNxt ? 5 : 4

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txtzicht
					text: zicht
					anchors {
						top: txtluchtdruk.bottom
						topMargin: isNxt ? 5 : 4
					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: txtzonop
					text: zonoponder
					anchors {
						top: txtzicht.bottom
						topMargin: isNxt ? 5 : 4

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}
			}
		}
        }

//weatherforecast data per day of week

	GridView {
		id: grid2

		model: fivedayforecastModel
		delegate: delegateGrid

		interactive: false
		flow: GridView.TopToBottom
		cellWidth: isNxt ? 100 : 75
		cellHeight: backgroundRect2.height
		height: backgroundRect2.height
		width: parent.width
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 32 : 24
			left: parent.left
			leftMargin: isNxt ? 375 : 300		}
	}

	ListModel {
		id: fivedayforecastModel
	}

	Component {
		id: delegateGrid

		Item {
			width: grid.width / grid.columns
		        height: grid.height
			Rectangle {
				anchors.fill: parent

			 	Text {
					id: forecastdagweek
					text: dagweek
					anchors {
						baseline: parent.top
					}
					font {
						family: qfont.bold.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}
	
				Text {
					id: forecastkanszon
					text: kanszon
					anchors {
						top: forecastdagweek.bottom
						topMargin: isNxt ? 5 : 4
						left: forecastdagweek.left

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: forecastkansregen
					text: kansregen
					anchors {
						top: forecastkanszon.bottom
						topMargin: isNxt ? 5 : 4
						left: forecastdagweek.left

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: forecastmintemp
					text: mintemp
					anchors {
						top: forecastkansregen.bottom
						topMargin: isNxt ? 5 : 4
						left: forecastdagweek.left

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: forecastmaxtenmp
					text: maxtemp
					anchors {
						top: forecastmintemp.bottom
						topMargin: isNxt ? 5 : 4
						left: forecastdagweek.left

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}

				Text {
					id: forecastwind
					text: wind
					anchors {
						top: forecastmaxtenmp.bottom
						topMargin: isNxt ? 5 : 4
						left: forecastdagweek.left

					}
					font {
						family: (index == 0) ? qfont.bold.name : qfont.regular.name
						pixelSize: isNxt ? 18 : 15
					}
					color: colors.clockTileColor
				}
				Image {
					id: forecasticoon
					source: icoon
					anchors {
						top: forecastwind.bottom
						topMargin: isNxt ? 10 : 8
						left: forecastdagweek.left

					}
					cache: false
				}
			}
		}
        }

	Text {
		id: buienradarDS2wvtitel
		text: app.weersverwachtingTitel
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 270 : 215
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: 20
		}
		color: colors.clockTileColor
	}

	Rectangle {
		id: backgroundRect3
		height: isNxt ? 280 : 180
		width: isNxt ? 800 : 580
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 280 : 225
			left: parent.left
			leftMargin: 10
		}
		color: colors.addDeviceBackgroundRectangle

	       Flickable {
	            id: flickArea
	             anchors.fill: parent
	             contentWidth: backgroundRect3.width; contentHeight: backgroundRect3.height
	             flickableDirection: Flickable.VerticalFlick
	             clip: true

	             TextEdit{
	                  id: helpText
	                   wrapMode: TextEdit.Wrap
	                   width:backgroundRect3.width;
			   textFormat: TextEdit.RichText
	                   readOnly:true
				font {
					family: qfont.regular.name
					pixelSize: isNxt ? 18 : 15
				}

	                   text:  app.weersverwachtingTekst
	            }
	      }
		MouseArea {
			anchors.fill: parent
			onClicked: {
				if (app.buienradarFullWeatherForecastScreen)
					app.buienradarFullWeatherForecastScreen.show();
			}
		}

	}

	Rectangle {
 		id: backgroundRectradar
		height: 180
		width: 180
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 280 : 225
			right: parent.right
			rightMargin: 10
		}
    		AnimatedImage { id: animation; source: app.radarimagesSmallurl }

		MouseArea {
			anchors.fill: parent
			onClicked: {
				app.radarimagesurl = "http://toon/";  //resetimage
				if (isNxt) {
					app.radarimagesurl = "https://api.buienradar.nl/image/1.0/RadarMapNL?w=600&h=600";
				} else {
					app.radarimagesurl = "https://api.buienradar.nl/image/1.0/RadarMapNL?w=400&h=400";
				}
				if (app.buienradarActualRadarScreen) {
					app.buienradarActualRadarScreen.setTitle("Actuele Buienradar");
					app.buienradarActualRadarScreen.show();
				}
			}
		}
	}
}
