import QtQuick 2.1
import qb.components 1.0
import "buienradar.js" as BuienradarJS

Screen {
	id: buienradarDetailsScreen

	screenTitle: "Actueel weer plus weersverwachting";

	property string tlineTempName: BuienradarJS.getlocationName(app.location);
	property string tlineTemp: BuienradarJS.lineTemp(app.temperatuurGC);
	property string tlineWindrichting: BuienradarJS.lineWindrichting(app.windrichting);
	property string tlineWindsnelheid: BuienradarJS.lineWindsnelheid(app.windsnelheidBF);
	property string tlineLuchtvochtigheid: BuienradarJS.lineLuchtvochtigheid(app.luchtvochtigheid);
	property string tlineZichtmeters: BuienradarJS.lineZichtmeters(app.zichtmeters);
	property string tlineLuchtdruk: BuienradarJS.lineLuchtdruk(app.luchtdruk);
	property string tlineZonOpOnder: BuienradarJS.lineZonOpOnder(app.zonopkomst, app.zononder);
	property string tlinedp0Wind: BuienradarJS.formatWind2(app.dp0windrichting, app.dp0windkracht)
	property string tlinedp1Wind: BuienradarJS.formatWind2(app.dp1windrichting, app.dp1windkracht)
	property string tlinedp2Wind: BuienradarJS.formatWind2(app.dp2windrichting, app.dp2windkracht)
	property string tlinedp3Wind: BuienradarJS.formatWind2(app.dp3windrichting, app.dp3windkracht)
	property string tlinedp4Wind: BuienradarJS.formatWind2(app.dp4windrichting, app.dp4windkracht)
	property string tlinedp5Wind: BuienradarJS.formatWind2(app.dp5windrichting, app.dp5windkracht)


	property bool dimState: screenStateController.dimmedColors;

	onCustomButtonClicked: {
		if (app.buienradarEditLonLatScreen) {
			 app.buienradarEditLonLatScreen.show();
		}
	}

	onShown: {
		addCustomTopRightButton("Locatie");
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
	
	Text {
		id: buienradarTitelWS
		text: tlineTempName
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradardatumUpdate
		text: "Laatste update:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 55 : 45
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradardatumUpdateText
		text: BuienradarJS.dateFormat(app.datumupdate)
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 55 : 45
			left: parent.left
			leftMargin: isNxt ? 155 : 125
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l1
		text: "Temperatuur:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}


	Text {
		id: buienradarDS2v1
		text: tlineTemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l2
		text: "Windsnelheid:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}


	Text {
		id: buienradarDS2v2
		text: tlineWindsnelheid
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l3
		text: "Windrichting:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradarDS2v3
		text: app.windrichting
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l4
		text: "Luchtvochtigheid:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradarDS2v4
		text: tlineLuchtvochtigheid
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l5
		text: "Luchtdruk:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 185 : 150
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradarDS2v5
		text: tlineLuchtdruk
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 185 : 150
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l6
		text: "Zicht:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 210 : 170
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradarDS2v6
		text: tlineZichtmeters
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 210 : 170
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

	Text {
		id: buienradarDS1l7
		text: "Zon op/onder:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 235 : 190
			left: parent.left
			leftMargin: 10
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: buienradarDS2v7
		text: tlineZonOpOnder
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 235 : 190
			left: parent.left
			leftMargin: isNxt ? 225 : 180
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor
	}

//weatherforecast data day of week

	Text {
		id: forecastdp0dagweek
		text: app.dp0dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: parent.left
			leftMargin: isNxt ? 510 : 410
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp1dagweek
		text: app.dp1dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: forecastdp0dagweek.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp2dagweek
		text: app.dp2dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: forecastdp1dagweek.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp3dagweek
		text: app.dp3dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: forecastdp2dagweek.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp4dagweek
		text: app.dp4dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: forecastdp3dagweek.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp5dagweek
		text: app.dp5dagweek
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 25
			left: forecastdp4dagweek.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

//weatherforecast zonkans

	Text {
		id: forecastdp1kanszonlabel
		text: "zonkans %:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: parent.left
			leftMargin: isNxt ? 375 : 300
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp0kanszon
		text: app.dp0kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp0dagweek.left
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp1kanszon
		text: app.dp1kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp0kanszon.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp2kanszon
		text: app.dp2kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp1kanszon.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp3kanszon
		text: app.dp3kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp2kanszon.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp4kanszon
		text: app.dp4kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp3kanszon.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp5kanszon
		text: app.dp5kanszon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 60 : 50
			left: forecastdp4kanszon.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

//weatherforecast regenkans

	Text {
		id: forecastdp1kansregenlabel
		text: "neerslag %:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: parent.left
			leftMargin: isNxt ? 375 : 300
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp0kansregen
		text: app.dp0kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp0dagweek.left
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp1kansregen
		text: app.dp1kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp0kansregen.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp2kansregen
		text: app.dp2kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp1kansregen.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp3kansregen
		text: app.dp3kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp2kansregen.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp4kansregen
		text: app.dp4kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp3kansregen.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp5kansregen
		text: app.dp5kansregen
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 85 : 70
			left: forecastdp4kansregen.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

//weatherforecast min temp

	Text {
		id: forecastdp1mintemplabel
		text: "min. temp:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: parent.left
			leftMargin: isNxt ? 375 : 300
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp0mintemp
		text: app.dp0mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp0dagweek.left
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp1mintemp
		text: app.dp1mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp0mintemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp2mintemp
		text: app.dp2mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp1mintemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp3mintemp
		text: app.dp3mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp2mintemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp4mintemp
		text: app.dp4mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp3mintemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp5mintemp
		text: app.dp5mintemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 110 : 90
			left: forecastdp4mintemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

//weatherforecast max temp

	Text {
		id: forecastdp1maxtemplabel
		text: "max. temp:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: parent.left
			leftMargin: isNxt ? 375 : 300
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp0maxtemp
		text: app.dp0maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp0dagweek.left
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp1maxtemp
		text: app.dp1maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp0maxtemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp2maxtemp
		text: app.dp2maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp1maxtemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp3maxtemp
		text: app.dp3maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp2maxtemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp4maxtemp
		text: app.dp4maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp3maxtemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}
	Text {
		id: forecastdp5maxtemp
		text: app.dp5maxtemp
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 135 : 110
			left: forecastdp4maxtemp.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

//weatherforecast wind

	Text {
		id: forecastdp1windlabel
		text: "wind:"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: parent.left
			leftMargin: isNxt ? 375 : 300
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp0wind
		text: tlinedp0Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp0dagweek.left
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp1wind
		text: tlinedp1Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp0wind.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp2wind
		text: tlinedp2Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp1wind.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp3wind
		text: tlinedp3Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp2wind.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp4wind
		text: tlinedp4Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp3wind.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}

	Text {
		id: forecastdp5wind
		text: tlinedp5Wind
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 160 : 130
			left: forecastdp4wind.left
			leftMargin: isNxt ? 80 : 65
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 18 : 15
		}
		color: colors.clockTileColor

	}


//weatherforecast icons

	Image {
		id: forecastdp0icoon
		source: app.dp0icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp0dagweek.left
		}
		cache: false
	}

	Image {
		id: forecastdp1icoon
		source: app.dp1icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp0icoon.left
			leftMargin: isNxt ? 80 : 65
		}
		cache: false
	}


	Image {
		id: forecastdp2icoon
		source: app.dp2icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp1icoon.left
			leftMargin: isNxt ? 80 : 65
		}
		cache: false
	}


	Image {
		id: forecastdp3icoon
		source: app.dp3icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp2icoon.left
			leftMargin: isNxt ? 80 : 65
		}
		cache: false
	}


	Image {
		id: forecastdp4icoon
		source: app.dp4icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp3icoon.left
			leftMargin: isNxt ? 80 : 65
		}
		cache: false
	}


	Image {
		id: forecastdp5icoon
		source: app.dp5icoon
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 180 : 145
			left: forecastdp4icoon.left
			leftMargin: isNxt ? 80 : 65
		}
		cache: false
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
