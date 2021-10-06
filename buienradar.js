function addStationName(inputarray, index, name) {
		inputarray[index] = name;
		return inputarray;
}

function addMinutes(time/*"hh:mm"*/, minsToAdd/*"N"*/) {
  function z(n){
    return (n<10? '0':'') + n;
  }
  var bits = time.split(':');
  var mins = bits[0]*60 + (+bits[1]) + (+minsToAdd);

  return z(mins%(24*60)/60 | 0) + ':' + z(mins%60);  
}

function formatScale(maxRegen, yScale) {
    if (yScale = 0) {
	return 72 / maxRegen;
    } else {
	return 72 / yScale;
    }
}

function formatTemp(tempValue, locationName) {
//adapted to reflect locale settings
	if (locationName) return locationName + ": " + i18n.number( Number( tempValue ), 1 ) + " °C";
	return "Even geduld..."
}


function dateFormat( dateStr ) {
    return  dateStr.substring(0, 10) + " " + dateStr.substring(11,16);
}


function formatDimTemp( tempValue ) {
//adapted to reflect locale settings

	return i18n.number( Number( tempValue ), 1 )  + " °C";
}


function formatWind(richting, bf) {
	return "wind: " + bf + " BFT, " + richting;
}


function formatWind2(richting, bf) {
	return bf + " " + richting;
}


function formatZin(zin) {
	if (zin.length > 21) {
	return zin.substring(0,21) + "...";
	} else {
		return zin;
	}
}


function determineNight (tijdnu, zonop, zononder) {
	var zonoptimestr = zonop.substring(11,16);
	var zonondertimestr = zononder.substring(11,16);
	if (tijdnu.length == 4)
		tijdnu = "0" + tijdnu;
	var isTodayDay = ((tijdnu <= zonondertimestr) && (tijdnu >= zonoptimestr));
	return !isTodayDay;
}


function formatGevoelstemp( temperature, windSpeed, humidity ) {
   
    if ( isNaN( temperature ) )
	//	return temperature;
	return "--"; // return dashes. NaN is a bit strange on screen. Half the world has no clue what NaN means
    var result;
    if (windSpeed > 1.2) {
	if (temperature <= 10.0) {
	    var windVar = (3.6 * windSpeed);
	    result = (13.12 + (0.6215 * temperature) - (11.37 * Math.pow(windVar, 0.16)) + (0.3965 * temperature * Math.pow(windVar, 0.16)));
	} else	{
	    var num = (17.27 * temperature);
	    var den = (237.7 + Number(temperature)); // Need to cast temperature explicitly, overloaded methods for "+" are quite buggy, apparently. 

	    var vapourPressure =  (humidity / 100.0) * 6.105 * Math.exp( num/den );
	    result = ( Number(temperature) + (0.33 * vapourPressure) - (0.70 * windSpeed) - 4.0 );
	}
    } else {
	result = temperature;
    }
   return "gevoelstemp: " + i18n.number( (Math.round(result * 2) / 2), 1) + " °C";

}

	
function formatLuchtdruk(ld, humidity) {
	return i18n.number(ld, 0, i18n.general_rounding, 1) + " hPa; lv: " + humidity + " %";
}


function lineTemp(tempValue) {
	return i18n.number( Number( tempValue ), 1 ) + " °C";
}


function lineZonOpOnder(zonop, zononder) {
	return zonop.substr(11,5) + " / " + zononder.substr(11,5);
}


function lineWindsnelheid(bf) {
	return bf + " BFT";
}


function lineLuchtvochtigheid(lv) {
	return lv + " %";
}


function lineLuchtdruk(ld) {
	return i18n.number(ld, 0, i18n.general_rounding, 1) + " hPa";
}


function lineZichtmeters(zm) {
	return zm + " m";
}


function lineWindstotenMS(ws) {
	return "Windstoten:       " + ws + " m/s";
}


/**
* @brief Calculate a filename to choose weather icons, distinquishing day and night icons. If later than 16:00 local time a night icon will be chosen.
* @param forceDay : Boolean
*	 If set to true, choice of day icon is forced.
* @param sourceFileName : String
*	 This is the first part of the filename including the path.
* @param weatherId : String
*	 A string that holds an Id coming from buienradar.nl. This is the basis of the decision what icon to pick.
* @param weatherText : String
*	 If weatherId is "0", the icon is chosen on the basis of this string.
* @return relative path to weather icon as string
*/

function parseWeatherIdAndText(forceDay, sourceFileName, weatherId, weatherText, zonop, zononder, tijdnu) {
    
	var isTodayNight = determineNight (tijdnu, zonop, zononder);

    switch (weatherId) {
    case 'a': sourceFileName += isTodayNight ? "ClearNight" : "Sunny";
	break;
    case 'b':
    case 'o':
	sourceFileName += isTodayNight ? "CloudedNight" : "SunnyIntervals";
	break;
    case 'f':
	sourceFileName += isTodayNight ? "LightRainNight" : "LightRainDay";
	break;
    case 'k':
	sourceFileName += isTodayNight ? "RainNight" : "RainDay";
	break;
    case 'h':
    case 'i':
	sourceFileName += isTodayNight ? "RainHailNight" : "RainHailDay";
	break;
    case 'g':
	sourceFileName += isTodayNight ? "Thunder Night" : "ThunderDay";
	break;
    case 'u':
	sourceFileName += isTodayNight ? "LightSnowNight" : "LightSnowDay";
	break;
    case 'd':
	sourceFileName += isTodayNight ? "FogNight" : "FogDay";
	break;
	//symbols with moon
    case 'aa':
	sourceFileName += "ClearNight";
	break;
    case 'bb':
    case 'oo':
	sourceFileName += "CloudedNight";
	break;
    case 'ff':
	sourceFileName += "LightRainNight";
	break;
    case 'kk':
	sourceFileName += "RainNight";
	break;
    case 'hh':
    case 'ii':
	sourceFileName += "RainHailNight";
	break;
    case 'gg':
	sourceFileName += "ThunderNight";
	break;
    case 'uu':
	sourceFileName += "LightSnowNight";
	break;
    case 'dd':
	sourceFileName += "FogNight";
	break;
	//just clouds
    case 'c':
    case 'p':
    case 'cc':
    case 'pp':
	sourceFileName += "Clouded";
	break;
    case 'm':
    case 'mm':
	sourceFileName += "LightRain";
	break;
    case 'l':
    case 'll':
    case 'q':
    case 'qq':
	sourceFileName += "Rain";
	break;
    case 'w':
    case 'ww':
	sourceFileName += "Sleet";
	break;
    case 's':
    case 'ss':
	sourceFileName += "Thunder";
	break;
    case 'v':
    case 'vv':
    case 'y':
    case 'yy':
	sourceFileName += "LightSnow";
	break;
    case '1':
    case '11':
    case 't':
    case 'tt':
    case 'x':
    case 'xx':
    case 'z':
    case 'zz':
	sourceFileName += "Snow";
	break;
    case 'e':
    case 'ee':
	sourceFileName += "Fog";
	break;
    case 'n':
    case 'nn':
	sourceFileName += "SlipRisk";
	break;
    case '0':
// hairy code, maybe clean up with switch .. case?
	if (weatherText !== "")
	{
	    if (weatherText === "zonnig") {
		sourceFileName += "Sunny";
	    } else if (weatherText === "zonnig en bewolkt") {
		sourceFileName += "SunnyIntervals";
	    } else if (weatherText === "zonnig met lichte regen" || weatherText == "zonnig, bewolkt en lichte regen") {
		sourceFileName += "LightRainDay";
	    } else if (weatherText === "zonnig met lichte sneeuwval" || weatherText == "zonnig, bewolkt en lichte sneeuwval") {
		sourceFileName += "LightSnowDay";
	    } else if (weatherText === "heldere nacht") {
		sourceFileName += "ClearNight";
	    } else if (weatherText === "heldere lucht en hier en daar bewolkt") {
		sourceFileName += "SunnyIntervals";
	    } else if (weatherText === "bewolkt") {
		sourceFileName += "Clouded";
	    } else if (weatherText === "bewolkt en lichte regen" || weatherText == "bewolkt met lichte regen" || weatherText == "bewolkt, mistig en lichte regen" || weatherText == "bewolkt, mistig met lichte regen") {
		sourceFileName += "LightRain";
	    } else if (weatherText === "bewolkt en regen" || weatherText == "bewolkt met regen") {
		sourceFileName += "Rain";
	    } else if (weatherText === "bewolkt met sneeuwval" || weatherText == "bewolkt en sneeuwval" || weatherText == "bewolkt en lichte sneeuwval") {
		sourceFileName += "Snow";
	    } else if (weatherText === "mistig") {
		sourceFileName += "Fog";
	    } else {
		sourceFileName += "SunnyIntervals";
	    }
	}
	break;
    default:
	sourceFileName += "Cross";
    }
    
    return sourceFileName += ".png"
}

