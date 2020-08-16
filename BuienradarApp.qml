import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0
import FileIO 1.0
import "buienradar.js" as BuienradarJS

App {
	id: buienradarApp
	objectName: "BuienradarApp"

	// These are the URL's for the QML resources from which our widgets will be instantiated.
	// By making them a URL type property they will automatically be converted to full paths,
	// preventing problems when passing them around to code that comes from a different path.

	//Edit these settings:
		// default weerstation after cold boot if no saved location exists	
	property string location : "6344";
		// default coordinates voor 2-uurs regenradardata if no saved location exists
	property string lat : "52.21"
	property string lon : "4.53"
	property real yaxisScale : 0
	//Stop editing here!	

	property url tileUrl : "BuienradarTile.qml"
	property url tileUrlRegen : "BuienradarRegenTile.qml"
	property url thumbnailIcon: "qrc:/tsc/buienradar.png"
	property BuienradarDetailsScreen buienradarDetailsScreen
	property BuienradarStationScreen buienradarStationScreen
	property BuienradarActualRadarScreen buienradarActualRadarScreen
	property BuienradarEditLonLatScreen buienradarEditLonLatScreen
	property BuienradarFullWeatherForecastScreen buienradarFullWeatherForecastScreen
	property url menuUrl : "BuienradarMenu.qml"
	property url trayUrl : "BuienradarTray.qml";
	property string timeStr

	property string locationName
	property variant regenVerwachting : []
	property string regenVerwachtingVanaf
	property string regenVerwachtingMidden
	property string regenVerwachtingTot
	property real regenMaxValue
	property bool showRain : false
	property variant stationArray : []
	property variant latArray : []
	property variant lonArray : []

	property string temperatuurGC
	property string windsnelheidBF
	property string windsnelheidMS
	property string windrichting
	property string icoonlink
	property string icoonid
	property string icoonzin
	property string icoonimageDim
	property string icoonimageNoDim
	property string luchtvochtigheid
	property string luchtdruk
	property string zichtmeters
	property string weersverwachtingTitel
	property string weersverwachtingTekst
	property string datumupdate
	property string stillimagesurl
	property string radarimagesurl
	property string radarimagesSmallurl
	property string extraScreensurl
	property string zonopkomst
	property string zononder

// day plus 0  This day is not provided by Buienradar but will be remembered from last day's prediction for today
	property string dp0dagweek : "--"
	property string dp0kanszon
	property string dp0kansregen
	property string dp0mintemp
	property string dp0maxtemp
	property string dp0windrichting
	property string dp0windkracht
	property string dp0icoonid
	property string dp0icoon

// day plus 1
	property string dp1dagweek
	property string dp1kanszon
	property string dp1kansregen
	property string dp1mintemp
	property string dp1maxtemp
	property string dp1windrichting
	property string dp1windkracht
	property string dp1icoonid
	property string dp1icoon

// day plus 2
	property string dp2dagweek
	property string dp2kanszon
	property string dp2kansregen
	property string dp2mintemp
	property string dp2maxtemp
	property string dp2windrichting
	property string dp2windkracht
	property string dp2icoonid
	property string dp2icoon

// day plus 3
	property string dp3dagweek
	property string dp3kanszon
	property string dp3kansregen
	property string dp3mintemp
	property string dp3maxtemp
	property string dp3windrichting
	property string dp3windkracht
	property string dp3icoonid
	property string dp3icoon

// day plus 4
	property string dp4dagweek
	property string dp4kanszon
	property string dp4kansregen
	property string dp4mintemp
	property string dp4maxtemp
	property string dp4windrichting
	property string dp4windkracht
	property string dp4icoonid
	property string dp4icoon

// day plus 5
	property string dp5dagweek
	property string dp5kanszon
	property string dp5kansregen
	property string dp5mintemp
	property string dp5maxtemp
	property string dp5windrichting
	property string dp5windkracht
	property string dp5icoonid
	property string dp5icoon
	property bool autoAdjustDimBrightness: true
	property int autoDimlevelSunUp: 30
	property int autoDimlevelSunDown: 10

	// user settings from config file
	property variant buienradarSettingsJson : {
		'selectedStation': "",
		'selectedLongitude': "",
		'autoAdjustDimBrightness': "Yes",
		'autoDimlevelSunUp': 30,
		'autoDimlevelSunDown': 10
	}

	FileIO {
		id: buienradarSettingsFile
		source: "file:///mnt/data/tsc/buienradar.userSettings.json"
 	}

	QtObject {
		id: p

		property url buienradarDetailsScreenUrl : "BuienradarDetailsScreen.qml"
		property url buienradarStationScreenUrl : "BuienradarStationScreen.qml"
		property url buienradarActualRadarScreenUrl : "BuienradarActualRadarScreen.qml"
		property url buienradarEditLonLatScreenUrl : "BuienradarEditLonLatScreen.qml"
		property url buienradarFullWeatherForecastScreenUrl : "BuienradarFullWeatherForecastScreen.qml"
		property url buienradarMenuUrl   : "BuienradarMenu.qml"
		property url buienradarTrayUrl: "BuienradarTray.qml"
	}

	
	function init() {
		registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: qsTr("Buienradar"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("tile", tileUrlRegen, this, null, {thumbLabel: "Regenverwachting", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", p.buienradarDetailsScreenUrl, this, "buienradarDetailsScreen");
		registry.registerWidget("screen", p.buienradarStationScreenUrl, this, "buienradarStationScreen");
		registry.registerWidget("screen", p.buienradarActualRadarScreenUrl, this, "buienradarActualRadarScreen");
		registry.registerWidget("screen", p.buienradarEditLonLatScreenUrl, this, "buienradarEditLonLatScreen");
		registry.registerWidget("screen", p.buienradarFullWeatherForecastScreenUrl, this, "buienradarFullWeatherForecastScreen");
		registry.registerWidget("menuItem", p.buienradarMenuUrl, this, "buienradarMenu", {weight: 110});
		registry.registerWidget("systrayIcon", p.buienradarTrayUrl, buienradarApp);
	}

	Component.onCompleted: {

		//read user settings

		try {
			buienradarSettingsJson = JSON.parse(buienradarSettingsFile.read());
			if (buienradarSettingsJson['selectedStation']) location = buienradarSettingsJson['selectedStation'];		
			if (buienradarSettingsJson['selectedLongitude']) lon = buienradarSettingsJson['selectedLongitude'];		
			if (buienradarSettingsJson['selectedLatitude']) lat = buienradarSettingsJson['selectedLatitude'];		
			if (buienradarSettingsJson['autoDimlevelSunUp']) autoDimlevelSunUp = buienradarSettingsJson['autoDimlevelSunUp'];		
			if (buienradarSettingsJson['autoDimlevelSunDown']) autoDimlevelSunDown = buienradarSettingsJson['autoDimlevelSunDown'];		
			if (buienradarSettingsJson['autoAdjustDimBrightness']) {
				 if (buienradarSettingsJson['autoAdjustDimBrightness'] == "Yes") {
					autoAdjustDimBrightness = true;
				} else {
					autoAdjustDimBrightness = false;
				}		
			}
		} catch(e) {
		}
	}

	function saveSettings() {
		
		// save user settings
 		var tmpUserSettingsJson = {
			"selectedStation": location,
			"selectedLongitude": lon,
			"selectedLatitude": lat,
			"autoAdjustDimBrightness": autoAdjustDimBrightness ? "Yes" : "No",
			"autoDimlevelSunUp": autoDimlevelSunUp,
			"autoDimlevelSunDown": autoDimlevelSunDown
		}

  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/buienradar.userSettings.json");
   		doc3.send(JSON.stringify(tmpUserSettingsJson ));
	}

	function updateBuienradar() {
		
		var i = 0;
		var j = 0;
		var k = 0;
		var l = 0;

		var now = new Date().getTime();
		timeStr = i18n.dateTime(now, i18n.time_yes);

		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var aNode = xmlhttp.responseText;

						// if not done already first fill array with available station

					stationArray.length = 0;
					lonArray.length = 0;
					latArray.length = 0;
					i = aNode.indexOf("<stationcode>");
					if (i > 0) {
						while (i > 0) {
							j = aNode.indexOf("Meetstation", i);
							k = aNode.indexOf("<", j);
							if (aNode.substring(j+12, k).indexOf("platform") < 0) {  //skip platform weather stations
								stationArray = BuienradarJS.addStationName(stationArray, l, aNode.substring(i+13, i+17) + " - " + aNode.substring(j+12, k));
								i = aNode.indexOf("<lat>", k);
								j = aNode.indexOf("<", i+5);
								latArray = BuienradarJS.addStationName(latArray, l, aNode.substring(i+5, j));
								i = aNode.indexOf("<lon>", k);
								j = aNode.indexOf("<", i+5);
								lonArray = BuienradarJS.addStationName(lonArray, l, aNode.substring(i+5, j));
								l = l + 1;
							}
							i = aNode.indexOf("<stationcode>", k);
						}
					}

						// read specific location weather data

					i = aNode.indexOf("<stationcode>" + location);
					if ( i > 0 ) {
 						aNode = aNode.slice(i);
						i = aNode.indexOf("<datum>");
						datumupdate = aNode.substring(i+7, i+26);
						i = aNode.indexOf("<luchtvochtigheid>");
						luchtvochtigheid = aNode.substring(i+18, i+20);
						i = aNode.indexOf("<temperatuurGC>");
						var j = aNode.indexOf("<", i+15);
						temperatuurGC= aNode.substring(i+15, j);

							// save actual temp for use in TemperatureLogger app

	   						var doc2 = new XMLHttpRequest();
   							doc2.open("PUT", "file:///var/volatile/tmp/actualBuienradarTemp.txt");
   							doc2.send(temperatuurGC + ":" + datumupdate);

						i = aNode.indexOf("<windsnelheidMS>");
						j = aNode.indexOf("<", i+16);
						windsnelheidMS = aNode.substring(i+16, j);
						i = aNode.indexOf("<windsnelheidBF>");
						j = aNode.indexOf("<", i+16);
						windsnelheidBF = aNode.substring(i+16, j);
						i = aNode.indexOf("<windrichting>");
						j = aNode.indexOf("<", i+13);
						windrichting = aNode.substring(i+14, j);
						i = aNode.indexOf("<luchtdruk>");
						j = aNode.indexOf("<", i+11);
						luchtdruk = aNode.substring(i+11, j);
						i = aNode.indexOf("<zichtmeters>");
						j = aNode.indexOf("<", i+12);
						zichtmeters = aNode.substring(i+13, j);
						i = aNode.indexOf("<icoonactueel");
						aNode = aNode.slice(i);
						i = aNode.indexOf("ID=");
						j = aNode.indexOf("\"", i+5);
						icoonid = aNode.substring(i+4, j);
						i = aNode.indexOf("zin=");
						j = aNode.indexOf("\"", i+6);
						icoonzin = aNode.substring(i+5, j);
						icoonlink = "qrc:/tsc/" + icoonid + ".png"


// zon op - zon onder

						i = aNode.indexOf("<zonopkomst>");
						zonopkomst = aNode.substring(i+12, i+31);
						i = aNode.indexOf("<zononder>");
						zononder = aNode.substring(i+10, i+29);

// auto adjust brightness if configured

						if (autoAdjustDimBrightness) {
	                 				if (BuienradarJS.determineNight (timeStr, zonopkomst, zononder)) 
        	             					screenStateController.backLightValueScreenDimmed = autoDimlevelSunDown;
                	  				else
                     						screenStateController.backLightValueScreenDimmed = autoDimlevelSunUp;
                  					screenStateController.notifyChangeOfSettings();
						}
					}


// read 5-days weather forecast
					i = aNode.indexOf("<dag-plus1>");
					aNode = aNode.slice(i);
					i = aNode.indexOf("<dagweek>");
					var tmpdp1dagweek = aNode.substring(i+9, i+11);

// if the new day-plus 1 differs from the old one, we have received a new set of 5 days and can copy the old day1 to day0 (which is today actually)

					if (tmpdp1dagweek !== dp1dagweek) {
						dp0dagweek = dp1dagweek;
						dp0kanszon = dp1kanszon;
						dp0kansregen = dp1kansregen;
						dp0mintemp = dp1mintemp;
						dp0maxtemp = dp1maxtemp;
						dp0windrichting = dp1windrichting;
						dp0windkracht = dp1windkracht;
						dp0icoonid = dp1icoonid;
						dp0icoon = dp1icoon;
					}

					dp1dagweek = aNode.substring(i+9, i+11);
					i = aNode.indexOf("<kanszon>");
					j = aNode.indexOf("<", i+10);
					dp1kanszon = aNode.substring(i+9, j);
					i = aNode.indexOf("<kansregen>");
					j = aNode.indexOf("<", i+12);
					dp1kansregen = aNode.substring(i+11, j);
					i = aNode.indexOf("<mintemp>");
					j = aNode.indexOf("<", i+10);
					dp1mintemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<maxtemp>");
					j = aNode.indexOf("<", i+10);
					dp1maxtemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<windrichting>");
					j = aNode.indexOf("<", i+15);
					dp1windrichting = aNode.substring(i+14, j);
					i = aNode.indexOf("<windkracht>");
					j = aNode.indexOf("<", i+12);
					dp1windkracht = aNode.substring(i+12, j);
					i = aNode.indexOf("<icoon");
					aNode = aNode.slice(i);
					i = aNode.indexOf("ID=");
					j = aNode.indexOf("\"", i+5);
					dp1icoonid = aNode.substring(i+4, j);
					dp1icoon = "qrc:/tsc/" + dp1icoonid + ".png"

					i = aNode.indexOf("<dag-plus2>");
					aNode = aNode.slice(i);
					i = aNode.indexOf("<dagweek>");
					dp2dagweek = aNode.substring(i+9, i+11);
					i = aNode.indexOf("<kanszon>");
					j = aNode.indexOf("<", i+10);
					dp2kanszon = aNode.substring(i+9, j);
					i = aNode.indexOf("<kansregen>");
					j = aNode.indexOf("<", i+12);
					dp2kansregen = aNode.substring(i+11, j);
					i = aNode.indexOf("<mintemp>");
					j = aNode.indexOf("<", i+10);
					dp2mintemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<maxtemp>");
					j = aNode.indexOf("<", i+10);
					dp2maxtemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<windrichting>");
					j = aNode.indexOf("<", i+15);
					dp2windrichting = aNode.substring(i+14, j);
					i = aNode.indexOf("<windkracht>");
					j = aNode.indexOf("<", i+12);
					dp2windkracht = aNode.substring(i+12, j);
					i = aNode.indexOf("<icoon");
					aNode = aNode.slice(i);
					i = aNode.indexOf("ID=");
					j = aNode.indexOf("\"", i+5);
					dp2icoonid = aNode.substring(i+4, j);
					dp2icoon = "qrc:/tsc/" + dp2icoonid + ".png"


					i = aNode.indexOf("<dag-plus3>");
					aNode = aNode.slice(i);
					i = aNode.indexOf("<dagweek>");
					dp3dagweek = aNode.substring(i+9, i+11);
					i = aNode.indexOf("<kanszon>");
					j = aNode.indexOf("<", i+10);
					dp3kanszon = aNode.substring(i+9, j);
					i = aNode.indexOf("<kansregen>");
					j = aNode.indexOf("<", i+12);
					dp3kansregen = aNode.substring(i+11, j);
					i = aNode.indexOf("<mintemp>");
					j = aNode.indexOf("<", i+10);
					dp3mintemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<maxtemp>");
					j = aNode.indexOf("<", i+10);
					dp3maxtemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<windrichting>");
					j = aNode.indexOf("<", i+15);
					dp3windrichting = aNode.substring(i+14, j);
					i = aNode.indexOf("<windkracht>");
					j = aNode.indexOf("<", i+12);
					dp3windkracht = aNode.substring(i+12, j);
					i = aNode.indexOf("<icoon");
					aNode = aNode.slice(i);
					i = aNode.indexOf("ID=");
					j = aNode.indexOf("\"", i+5);
					dp3icoonid = aNode.substring(i+4, j);
					dp3icoon = "qrc:/tsc/" + dp3icoonid + ".png"


					i = aNode.indexOf("<dag-plus4>");
					aNode = aNode.slice(i);
					i = aNode.indexOf("<dagweek>");
					dp4dagweek = aNode.substring(i+9, i+11);
					i = aNode.indexOf("<kanszon>");
					j = aNode.indexOf("<", i+10);
					dp4kanszon = aNode.substring(i+9, j);
					i = aNode.indexOf("<kansregen>");
					j = aNode.indexOf("<", i+12);
					dp4kansregen = aNode.substring(i+11, j);
					i = aNode.indexOf("<mintemp>");
					j = aNode.indexOf("<", i+10);
					dp4mintemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<maxtemp>");
					j = aNode.indexOf("<", i+10);
					dp4maxtemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<windrichting>");
					j = aNode.indexOf("<", i+15);
					dp4windrichting = aNode.substring(i+14, j);
					i = aNode.indexOf("<windkracht>");
					j = aNode.indexOf("<", i+12);
					dp4windkracht = aNode.substring(i+12, j);
					i = aNode.indexOf("<icoon");
					aNode = aNode.slice(i);
					i = aNode.indexOf("ID=");
					j = aNode.indexOf("\"", i+5);
					dp4icoonid = aNode.substring(i+4, j);
					dp4icoon = "qrc:/tsc/" + dp4icoonid + ".png"


					i = aNode.indexOf("<dag-plus5>");
					aNode = aNode.slice(i);
					i = aNode.indexOf("<dagweek>");
					dp5dagweek = aNode.substring(i+9, i+11);
					i = aNode.indexOf("<kanszon>");
					j = aNode.indexOf("<", i+10);
					dp5kanszon = aNode.substring(i+9, j);
					i = aNode.indexOf("<kansregen>");
					j = aNode.indexOf("<", i+12);
					dp5kansregen = aNode.substring(i+11, j);
					i = aNode.indexOf("<mintemp>");
					j = aNode.indexOf("<", i+10);
					dp5mintemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<maxtemp>");
					j = aNode.indexOf("<", i+10);
					dp5maxtemp = aNode.substring(i+9, j);
					i = aNode.indexOf("<windrichting>");
					j = aNode.indexOf("<", i+15);
					dp5windrichting = aNode.substring(i+14, j);
					i = aNode.indexOf("<windkracht>");
					j = aNode.indexOf("<", i+12);
					dp5windkracht = aNode.substring(i+12, j);
					i = aNode.indexOf("<icoon");
					aNode = aNode.slice(i);
					i = aNode.indexOf("ID=");
					j = aNode.indexOf("\"", i+5);
					dp5icoonid = aNode.substring(i+4, j);
					dp5icoon = "qrc:/tsc/" + dp5icoonid + ".png"

//forecast title and text
					i = aNode.indexOf("<titel>");
					j = aNode.indexOf("</titel>");
					weersverwachtingTitel = aNode.substring(i+7, j);
					i = aNode.indexOf("<tekst>");
					j = aNode.indexOf("</tekst>");
					weersverwachtingTekst = aNode.substring(i+7, j);
					var w = weersverwachtingTekst.indexOf("nbsp;");
					while (w > 0) { 
						var tmptx = weersverwachtingTekst.substring(0, w - 5) + " " + weersverwachtingTekst.substring(w + 5, weersverwachtingTekst.length);
						weersverwachtingTekst = tmptx;
						w = weersverwachtingTekst.indexOf("nbsp;")
					}
					w = weersverwachtingTekst.indexOf("rsquo;");
					while (w > 0) { 
						var tmptx = weersverwachtingTekst.substring(0, w - 5) + "'" + weersverwachtingTekst.substring(w + 6, weersverwachtingTekst.length);
						weersverwachtingTekst = tmptx;
						w = weersverwachtingTekst.indexOf("rsquo;")
					}



// link to icon images

					icoonimageDim = BuienradarJS.parseWeatherIdAndText(true, "file:///qmf/qml/apps/buienradar/drawables/Dim", icoonid, icoonzin, zonopkomst, zononder, timeStr);
					icoonimageNoDim = BuienradarJS.parseWeatherIdAndText(true, "file:///qmf/qml/apps/buienradar/drawables/Home", icoonid, icoonzin, zonopkomst, zononder, timeStr);

				}
			}
		}
		xmlhttp.open("GET", "http://xml.buienradar.nl", true);
		xmlhttp.send();
	}

	function updateRegenkans() {
		var xmlhttp = new XMLHttpRequest();
		var newArray = [];
		var mmRegen = 0;
		var maxValue = 0;
		regenMaxValue = 2;
		showRain = false;

		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var response = xmlhttp.responseText;
					if (response.length > 0) {
						regenVerwachtingVanaf = response.slice(4,9);
						regenVerwachtingMidden = BuienradarJS.addMinutes(regenVerwachtingVanaf, 60);
						regenVerwachtingTot = BuienradarJS.addMinutes(regenVerwachtingVanaf, 120);

						for (var i = 0; i < response.length/11; i++) {
							mmRegen =  Math.round(Math.pow(10,((Number(response.slice(i*11,i*11+3))-109)/32))*10)/10;
							newArray.push(mmRegen);
							if (maxValue < mmRegen) {
								maxValue = mmRegen;
							}
						}
						regenVerwachting = newArray;
						
						if (maxValue > regenMaxValue) {
							regenMaxValue = Math.round(maxValue + 0.5);
						}
						

						if (maxValue > 0) {
							showRain = true;
						}
					}
				}
			}
		}

		xmlhttp.open("GET", "http://gadgets.buienradar.nl/data/raintext?lat="+lat+"&lon="+lon, true);
//		xmlhttp.open("GET", "http://192.168.1.192/rain.txt", true);
		xmlhttp.send();
	}

	

	Timer {
		id: datetimeTimer
		interval: 600000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: updateBuienradar()
	}


	Timer {
		id: datetimeTimer2
		interval: 300000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: updateRegenkans()
	}
}
