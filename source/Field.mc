import Toybox.Lang;
import Toybox.Math;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Weather;

using Toybox.Time.Gregorian as Calendar;

module Field {
    const TIME = 0;
    const DATE = 1;
    const DAY_OF_WEEK = 2;
    const BATTERY = 3;
    const TEMPERATURE = 4;

    function resolveFieldValue(type) {
        switch(type) {
            case TIME:
                var clockTime = System.getClockTime();
                return [clockTime.hour.format("%02d"), clockTime.min.format("%02d")];
            case DATE:
                var date = Calendar.info(Time.now(), Time.FORMAT_SHORT);
                return [date.day, date.month.format("%02d")];
            case DAY_OF_WEEK:
                var dayOfWeek = Calendar.info(Time.now(), Time.FORMAT_SHORT).day_of_week;
                var dayOfWeekString = WatchUi.loadResource(resolveDayOfWeek(dayOfWeek));
                return [dayOfWeekString];
            case BATTERY:
                var battery = System.getSystemStats().battery;
                return [Math.floor(battery.toNumber())];
            case TEMPERATURE:
                var currentConditions = Weather.getCurrentConditions();
                return [currentConditions.feelsLikeTemperature.format("%02d")];
            default:
                throw new Lang.InvalidValueException(type);
        }
    }

    function resolveFieldFormat(type) {
        switch(type) {
            case TIME: return "$1$:$2$";
            case DATE: return "$1$/$2$";
            case DAY_OF_WEEK: return "$1$";
            case BATTERY: return "$1$%";
            case TEMPERATURE: return "$1$ºC";
            default: throw new Lang.InvalidValueException(type);
        }
    }

    function resolveDayOfWeek(num) {
        switch(num) {
            case 1: return Rez.Strings.Sun;
            case 2: return Rez.Strings.Mon;
            case 3: return Rez.Strings.Tue;
            case 4: return Rez.Strings.Wed;
            case 5: return Rez.Strings.Thu;
            case 6: return Rez.Strings.Fri;
            case 7: return Rez.Strings.Sat;
            default: throw new Lang.InvalidValueException(num);
        }
    }

}