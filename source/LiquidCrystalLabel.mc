import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.Time.Gregorian as Calendar;

class LiquidCrystalLabel extends WatchUi.Drawable {
    const DATA_VALUE = {
        "Battery" => [
            Math.floor(System.getSystemStats().battery.toNumber())
        ],
        "Date" => [
            Calendar.info(Time.now(), Time.FORMAT_SHORT).day,
            Calendar.info(Time.now(), Time.FORMAT_SHORT).month.format("%02d")

        ],
        "DayOfWeek" => [ Calendar.info(Time.now(), Time.FORMAT_LONG).day_of_week],
        "Temperature" => [Weather.getCurrentConditions().feelsLikeTemperature.format("%02d")],
        "Time" => [
            System.getClockTime().hour.format("%02d"),
            System.getClockTime().min.format("%02d")
        ]
    };

    const DATA_FORMAT = {
        "Battery" => "$1$%",
        "Date" => "$1$/$2$",
        "DayOfWeek" => "$1$",
        "Temperature" => "$1$C",
        "Time" => "$1$:$2$"
    };

    private var _color;
    private var _font;
    private var _justification;
    private var _toggle;

    typedef LiquidCrystalLabelParams as {
        :identifier as String,
        :locX as Float,
        :locY as Float,
        :font as FontResource,
        :color as ColorValue,
        :justification as Number,
    };

    function initialize(params as LiquidCrystalLabelParams) {
        Drawable.initialize(params);
        _color = params[:color];
        _font = params[:font];
        _justification = params[:justification];
        _toggle = Lang.format("show$1$", [identifier]);
    }

    function draw(dc as Dc) as Void {
        if (!readProperty(_toggle, true)) {
            return;
        }

        var dataValue = DATA_VALUE[identifier];
        var dataFormat = DATA_FORMAT[identifier];
        var string = Lang.format(dataFormat, dataValue);

        dc.setColor(_color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(locX, locY, _font, string, _justification);
        dc.clear();
    }

    private function readProperty(key, fallbackValue) {
        try {
            return Properties.getValue(key);
        } catch (ex) {
            return fallbackValue;
        }
    }

}