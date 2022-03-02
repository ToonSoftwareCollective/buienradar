import QtQuick 2.1
import qb.components 1.0
import "buienradar.js" as BuienradarJS

Tile {
	id: buienradarTile
	property string tempVal: (app.indexStation < 0) ? "Even geduld" : BuienradarJS.formatTemp(app.temperatuurGC, app.stationArray[app.indexStation])
	property string tempWind: BuienradarJS.formatWind(app.windrichting, app.windsnelheidBF)
	property string tempZin: BuienradarJS.formatZin(app.icoonzin)
	property string tempLuchtdruk: BuienradarJS.formatLuchtdruk(app.luchtdruk,app.luchtvochtigheid)
	property string dimTempVal: BuienradarJS.formatDimTemp(app.temperatuurGC)

	property bool dimState: screenStateController.dimmedColors

	onClicked: {
		app.radarimagesSmallurl ="http://toon/";  //resetimage
		app.radarimagesSmallurl ="https://api.buienradar.nl/image/1.0/RadarMapNL?w=180&h=180";
		if (app.buienradarDetailsScreen)
			app.buienradarDetailsScreen.show();
	}


	Image {
		id: weatherTileIconzz
		source: app.icoonimageDim
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 100 : 65
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
       		visible: dimState
	}

	Text {
		id: weatherTileTemperatureTextzz
		text: i18n.number( Number( app.temperatuurGC ), 1 ) + "°"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 70 : 55
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 65 : 50
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
       		visible: dimState
	}



	Text {
		id: buienradarTileTitleText2
		text: tempVal
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 32 : 25
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 22 : 18
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
        	visible: !dimState
	}

	Text {                                                                                 
                id: buienradarTileTitleText3
                text: tempZin
                anchors {
                        baseline: parent.top
                        baselineOffset: isNxt ? 85 : 70
                        horizontalCenter: parent.horizontalCenter
                }
                font {
                        family: qfont.regular.name
			pixelSize: isNxt ? 20 : 16
                }
                color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
        	visible: !dimState
       }

	Text {                                                                                 
                id: buienradarTileGevoelstempText4
                text: "gevoelstemperatuur: " + i18n.number( Number( app.gevoelstemperatuur), 1 ) + "°"
                anchors {
                        baseline: parent.top
                        baselineOffset: isNxt ? 60 : 50
                        horizontalCenter: parent.horizontalCenter
                }
                font {
                        family: qfont.regular.name
			pixelSize: isNxt ? 20 : 16
                }
                color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	         visible: !dimState
        }

	Text {
		id: buienradarTileWindsnelheidText
		text: tempWind
		anchors {
			baseline: buienradarTileLuchtdrukText4.top
			baselineOffset: isNxt ? -5 : -4
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 20 : 16
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	       visible: !dimState

	}

	Text {                                                                                 
                id: buienradarTileLuchtdrukText4
                text: tempLuchtdruk
                anchors {
			baseline: parent.bottom
			baselineOffset: -19
                        horizontalCenter: parent.horizontalCenter
                }
                font {
                        family: qfont.regular.name
			pixelSize: isNxt ? 20 : 16
                }
                color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
	        visible: !dimState
        }

	Image {
		id: weatherTileIcon
		source: app.icoonlink
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 96 : 75
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
        	visible: !dimState
	}
}
