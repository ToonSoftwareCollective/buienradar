import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0
import FileIO 1.0
import "buienradar.js" as BuienradarJS

App {
	id: buienradarApp
	objectName: "BuienradarApp"

		// default weerstation after cold boot if no saved location exists	
	property string location : "6344";
		// default coordinates voor 2-uurs regenradardata if no saved location exists
	property string lat : "52.21"
	property string lon : "4.53"

	property url tileUrl : "BuienradarTile.qml"
	property url tileUrlRegen : "BuienradarRegenTile.qml"
	property url tileSunrise : "BuienradarSunriseTile.qml"
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
	property variant locationArray : []
	property int indexStation
	property variant latArray : []
	property variant lonArray : []
	property variant brJson : {}

	property string temperatuurGC
	property string gevoelstemperatuur
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

	property variant fivedayforecast: []
	property variant actualweather: []
	property string firstdayForecast: "  "

	// user settings from config file
	property variant buienradarSettingsJson : {}

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
		registry.registerWidget("tile", tileUrlRegen, this, null, {thumbLabel: "Regenverw.", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("tile", tileSunrise, this, null, {thumbLabel: "Zon op/onder", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
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
		} catch(e) {
		}
	}

	function saveSettings() {
		
		// save user settings
 		var tmpUserSettingsJson = {
			"selectedStation": location,
			"selectedLongitude": lon,
			"selectedLatitude": lat
		}

  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/buienradar.userSettings.json");
   		doc3.send(JSON.stringify(tmpUserSettingsJson ));
	}

	function degreesToCardinal(degree){   //convert winddirection in degrees to cardinal

   		if (degree>337.5) return 'N';
   		if (degree>292.5) return 'NW';
   		if (degree>247.5) return 'W';
    		if (degree>202.5) return 'ZW';
    		if (degree>157.5) return 'Z';
    		if (degree>122.5) return 'ZO';
    		if (degree>67.5) return 'O';
    		if (degree>22.5){return 'NO';}
    		return 'N';
	}

	function msToBeaufort(mps) {  // convert windspeed in m/s to Beaufort scale
      		var scale = [0.3, 1.5, 3.3, 5.5, 7.9, 10.7, 13.8, 17.1, 20.7, 24.4, 28.4, 32.6];
      		for (var i = 0; i < scale.length; i++) {
       			 if (mps < scale[i]) return i;
      		}
      		return 12;
    	}

	function updateBuienradar() {
		
  		var weekday = new Array(7);
  		weekday[0] = "Zo";
  		weekday[1] = "Ma";
 		weekday[2] = "Di";
  		weekday[3] = "Wo";
 		weekday[4] = "Do";
  		weekday[5] = "Vr";
  		weekday[6] = "Za";

		var now = new Date().getTime();
		timeStr = i18n.dateTime(now, i18n.time_yes);

		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {

			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					var brJson = JSON.parse(xmlhttp.responseText);
					indexStation = -1;

						// if not done already first fill array with available weatherstations

					for (var i=0; i < brJson['Actual']['WeatherStationMeasurements'].length; i++) {
						stationArray = BuienradarJS.addStationName(stationArray, i, brJson['Actual']['WeatherStationMeasurements'][i]['StationName'].slice (-1 * (brJson['Actual']['WeatherStationMeasurements'][i]['StationName'].length - 12)));
						locationArray = BuienradarJS.addStationName(locationArray, i, brJson['Actual']['WeatherStationMeasurements'][i]['StationId']);
						latArray = BuienradarJS.addStationName(latArray, i, brJson['Actual']['WeatherStationMeasurements'][i]['latitude']);
						lonArray = BuienradarJS.addStationName(lonArray, i, brJson['Actual']['WeatherStationMeasurements'][i]['longitude']);
						if (location == brJson['Actual']['WeatherStationMeasurements'][i]['StationId']) indexStation = i;
					}

						// read specific selected location weather data

					if ( indexStation > -1 ) {
 
	
						// save actual temp for use in TemperatureLogger app

   						var doc2 = new XMLHttpRequest();
						doc2.open("PUT", "file:///var/volatile/tmp/actualBuienradarTemp.txt");
   						doc2.send(brJson['Actual']['WeatherStationMeasurements'][indexStation]['temperature'] + ":" + brJson['Actual']['WeatherStationMeasurements'][indexStation]['Timestamp']);

						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['Windspeed']) windsnelheidMS = brJson['Actual']['WeatherStationMeasurements'][indexStation]['Windspeed'];
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['Windspeed']) windsnelheidBF = msToBeaufort(Number(brJson['Actual']['WeatherStationMeasurements'][indexStation]['Windspeed']));
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['WindDirection']) windrichting = degreesToCardinal(Number(brJson['Actual']['WeatherStationMeasurements'][indexStation]['WindDirectionDegrees']));
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['AirPressure']) luchtdruk = brJson['Actual']['WeatherStationMeasurements'][indexStation]['AirPressure'];
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['Visibility']) zichtmeters = brJson['Actual']['WeatherStationMeasurements'][indexStation]['Visibility'];
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['Temperature']) temperatuurGC = brJson['Actual']['WeatherStationMeasurements'][indexStation]['Temperature'];
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['FeelTemperature']) gevoelstemperatuur = brJson['Actual']['WeatherStationMeasurements'][indexStation]['FeelTemperature'];
						if (brJson['Actual']['WeatherStationMeasurements'][indexStation]['Humidity']) luchtvochtigheid = brJson['Actual']['WeatherStationMeasurements'][indexStation]['Humidity'];

						icoonzin = brJson['Actual']['WeatherStationMeasurements'][indexStation]['WeatherDescription'];
						var tmpUrl = brJson['Actual']['WeatherStationMeasurements'][indexStation]['IconUrl'].split("/");
						icoonid = tmpUrl[tmpUrl.length - 1].substring(0, tmpUrl[tmpUrl.length - 1].length - 4);
						icoonlink = "qrc:/tsc/" + icoonid + ".png";

							// fill model for grid of weather station data on detail screen
	
						var tmpActual = [];	
						tmpActual.push({'location': stationArray[indexStation],
							  'temperature': 'Temperatuur:',
							  'windsnelheid': 'Windsnelheid:',
							  'windrichting': 'Windrichting:',
							  'luchtvochtigheid': 'Luchtvochtigheid:',
							  'luchtdruk': 'Luchtdruk:',
							  'zicht': 'Zicht:',
							  'zonoponder': 'Zon op\/onder'});
						tmpActual.push({'location': BuienradarJS.dateFormat(brJson['Actual']['WeatherStationMeasurements'][indexStation]['Timestamp']),
							  'temperature': temperatuurGC,
							  'windrichting': windrichting,
							  'windsnelheid': windsnelheidBF,
							  'luchtvochtigheid': luchtvochtigheid,
							  'luchtdruk': luchtdruk,
							  'zicht': zichtmeters,
							  'zonoponder': BuienradarJS.lineZonOpOnder(brJson['Actual']['Sunrise'], brJson['Actual']['Sunset'])});
						actualweather = tmpActual;

				
						zonopkomst = brJson['Actual']['Sunrise']
						zononder = brJson['Actual']['Sunset']

					}


						// read 5-days weather forecast

					var tmpNewDate = new Date(brJson['Forecast']['FiveDayForecast'][0]['Day']);
					var tmpdagweek = weekday[tmpNewDate.getDay()];

					var tmpForecast = [];	
					tmpForecast.push({'kanszon': 'zon %',
							  'kansregen': 'regen %',
							  'mintemp': 'min',
							  'maxtemp': 'max',
							  'wind': 'wind'});

						// if the new day-plus 1 differs from the old one, we have received a new set of 5 days and can copy the old day1 to day0 (which is today actually)

					if (firstdayForecast == "  ") {
						firstdayForecast = tmpdagweek;
						tmpForecast.push({}); // at start, empty column 1
					} else {
						if (firstdayForecast !== tmpdagweek) {
							tmpForecast.push(fivedayforecast[2])  // move column 2 to column 1
							firstdayForecast = tmpdagweek;
						} else {
							tmpForecast.push(fivedayforecast[1])  // keep old column 1
						}
					}

						// load next 5 days forecast

					for (var i = 0; i < 5; i++) {
						var tmpNewDate = new Date(brJson['Forecast']['FiveDayForecast'][i]['Day']);
						var tmpdagweek = weekday[tmpNewDate.getDay()];
						var tmpUrl = brJson['Forecast']['FiveDayForecast'][i]['IconUrl'].split("/");
						var dpicoonid = tmpUrl[tmpUrl.length - 1].substring(0, tmpUrl[tmpUrl.length - 1].length - 4);
						var dpicoon = "qrc:/tsc/" + dpicoonid + ".png";
						tmpForecast.push({'dagweek': tmpdagweek,
							  'kanszon': brJson['Forecast']['FiveDayForecast'][i]['SunChance'].toString(),
							  'kansregen': brJson['Forecast']['FiveDayForecast'][i]['RainChance'].toString(),
							  'mintemp': brJson['Forecast']['FiveDayForecast'][i]['MinTemperatureMin'].toString(),
							  'maxtemp': brJson['Forecast']['FiveDayForecast'][i]['MaxTemperatureMax'].toString(),
							  'wind': brJson['Forecast']['FiveDayForecast'][i]['WindDirection'].toUpperCase() + " " + brJson['Forecast']['FiveDayForecast'][i]['WindBeaufort'].toString(),
							  'icoon': dpicoon});
					}
					fivedayforecast = tmpForecast;

						//forecast title and text, remove special characters

					weersverwachtingTitel = brJson['Forecast']['WeatherReport']['Title'];
					weersverwachtingTekst = brJson['Forecast']['WeatherReport']['Text'];
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
		xmlhttp.open("GET", "https://data.buienradar.nl/2.0/feed/json", true);
		xmlhttp.send();
	}

	function updateRegenkans() {
		var xmlhttp = new XMLHttpRequest();
		var newArray = [];
		var mmRegen = 0;
		var maxValue = 0;
		regenMaxValue = 0;
		var tmpNewDate = new Date();
		var now = new Date();
		var startForecasts = 0;
		var forecastCounter = 0;
		showRain = false;

		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {

					var response = xmlhttp.responseText;
			                if (response.length > 0) {

						var brJson = JSON.parse(xmlhttp.responseText);
							// find start of actual forecast

						for (var i = 0; i < brJson['forecasts'].length ; i++) {
							tmpNewDate = new Date(brJson['forecasts'][i]['datetime']);
							if (now < tmpNewDate) {
								startForecasts = i;
								break;
							}
						}

      			       			regenVerwachtingVanaf = brJson['forecasts'][startForecasts]['datetime'].substring(11,16);
 
							// fill array with the next 24 values

						for (var i = startForecasts; i < brJson['forecasts'].length ; i++) {
							mmRegen =  brJson['forecasts'][i]['precipation'];
							newArray.push(mmRegen);
							if (mmRegen > 0) showRain = true;
							if (mmRegen > maxValue) maxValue = mmRegen;
							forecastCounter = forecastCounter + 1;
							if (forecastCounter == 24) break;
						}

							// fill remaining slots , just in case we didn't had 24 datapoints

						if (forecastCounter < 24) {

							for (var i = forecastCounter; i < 24 ; i++) {  // add empty columns
								mmRegen = 0;
								newArray.push(mmRegen);
							}
						}

       			       			regenVerwachtingMidden = BuienradarJS.addMinutes(regenVerwachtingVanaf, 60);
       		          			regenVerwachtingTot = BuienradarJS.addMinutes(regenVerwachtingVanaf, 120);
						regenVerwachting = newArray;
							
						regenMaxValue = Math.round(maxValue + 0.5); 
					}
				}
			}
		}

		xmlhttp.open("GET", "https://graphdata.buienradar.nl/2.0/forecast/geo/RainHistoryForecast?lat="+lat+"&lon="+lon, true);
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
