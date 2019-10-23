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

function calcXcoordinate(lon, x, zoom) {
	return  Number(lon) + ((x-150) * (Math.pow(2, (13-zoom)) / 100) / 60);
}

function calcYcoordinate(lat, y, zoom) {
	return  Number(lat) + ((150-y)*(Math.pow(2, (13-zoom))/100)/94);
}

function formatTemp(tempValue, locationName) {
//adapted to reflect locale settings
    return locationName + ": " + i18n.number( Number( tempValue ), 1 ) + " °C";
}


function dateFormat( dateStr ) {
    return  dateStr.substr( 3, 2 ) + "-" + dateStr.substr( 0, 2 ) + "-" +
	dateStr.substr( 6, 4 ) + " " + dateStr.substr( 11, 5 );
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


function lineWindrichting(richting) {
	return "Windrichting:     " + richting;
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


function getlocationName(locid) {
    switch (locid) {
    case "6391" : return "Arcen";
    case "6275" : return "Arnhem";
    case "6249" : return "Berkhout";
    case "6308" : return "Cadzand";
    case "6260" : return "De Bilt";
    case "6235" : return "Den Helder";
    case "6370" : return "Eindhoven";
    case "6377" : return "Ell";
    case "6321" : return "Euro platform";	
    case "6350" : return "Gilze Rijen";
    case "6283" : return "Groenlo";
    case "6280" : return "Groningen";
    case "6315" : return "Hansweert";
    case "6278" : return "Heino";
    case "6356" : return "Herwijnen";
    case "6330" : return "Hoek v Holland";
    case "6279" : return "Hoogeveen";
    case "6251" : return "Terschelling";
    case "6258" : return "Houtribdijk";
    case "6285" : return "Schiermonnikoog";
    case "6209" : return "IJmond";
    case "6225" : return "IJmuiden";
    case "6277" : return "Lauwersoog";
    case "6320" : return "Goeree";
    case "6270" : return "Leeuwarden";
    case "6269" : return "Lelystad";
    case "6348" : return "Lopik-Cabauw";
    case "6380" : return "Maastricht";
    case "6273" : return "Marknesse";
    case "6286" : return "Nieuw Beerta";
    case "6312" : return "Oosterschelde";
    case "6344" : return "Rotterdam";
    case "6316" : return "Schaar";
    case "6240" : return "Schiphol";
    case "6324" : return "Stavenisse";
    case "6267" : return "Stavoren";
    case "6331" : return "Tholen";
    case "6290" : return "Twente";
    case "6313" : return "Vlakte ad Raan";
    case "6242" : return "Vlieland";
    case "6310" : return "Vlissingen";
    case "6375" : return "Volkel";
    case "6215" : return "Voorschoten";
    case "6319" : return "Westdorpe";
    case "6248" : return "Wijdenes";
    case "6257" : return "Wijk aan Zee";
    case "6340" : return "Woensdrecht";
    default: break;
    }
    return "";
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

