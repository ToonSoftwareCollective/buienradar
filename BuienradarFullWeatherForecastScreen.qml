import QtQuick 2.1
import qb.components 1.0

Screen {
	id: buienradarFullWeatherForecastScreen
	screenTitle: app.weersverwachtingTitel;

	Rectangle {
		id: backgroundRect
		height: parent.height - 20
		width: parent.width - 20
		anchors {
			baseline: parent.top
			baselineOffset: 10
			left: parent.left
			leftMargin: 10
		}
		color: colors.addDeviceBackgroundRectangle

	       Flickable {
	            id: flickArea
	             anchors.fill: parent
	             contentWidth: backgroundRect.width;
		     contentHeight: forecastText.height + 100
	             flickableDirection: Flickable.VerticalFlick
	             clip: true

	             TextEdit{
	                  id: forecastText
	                   wrapMode: TextEdit.Wrap
	                   width:backgroundRect.width
			   textFormat: TextEdit.RichText

	                   readOnly:true
				font {
					family: qfont.regular.name
					pixelSize: isNxt ? 20 : 15
				}

	                   text:  app.weersverwachtingTekst
	            }
	      }
	}
}
