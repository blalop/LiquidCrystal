import Toybox.Lang;
import Toybox.Math;
import Toybox.System;
import Toybox.Time;
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
                return [
                    System.getClockTime().hour.format("%02d"),
                    System.getClockTime().min.format("%02d")
                ];
            case DATE:
                return [
                    Calendar.info(Time.now(), Time.FORMAT_SHORT).day,
                    Calendar.info(Time.now(), Time.FORMAT_SHORT).month.format("%02d")
                ];
            case DAY_OF_WEEK:
                return [Calendar.info(Time.now(), Time.FORMAT_LONG).day_of_week];
            case BATTERY:
                return [
                    Math.floor(System.getSystemStats().battery.toNumber())
                ];
            case TEMPERATURE:
                return [Weather.getCurrentConditions().feelsLikeTemperature.format("%02d")];
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
            case TEMPERATURE: return "$1$C";
            default: throw new Lang.InvalidValueException(type);
        }
    }
}