import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Weather;

using Toybox.Time.Gregorian as Calendar;

class GWatchView extends WatchUi.WatchFace {
    private var _timeFont;

    function initialize() {
        WatchFace.initialize();
        _timeFont = Application.loadResource(Rez.Fonts.TimeFont);
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        drawTime(dc, System.getClockTime());
        drawDate(dc, Calendar.info(Time.now(), Time.FORMAT_LONG));
        drawWeather(dc, Weather.getCurrentConditions().feelsLikeTemperature);
    }

    function onHide() as Void {
    }

    function onExitSleep() as Void {
    }

    function onEnterSleep() as Void {
    }

    private function drawTime(dc, clockTime) {
      var timeString = Lang.format("$1$$2$", [clockTime.hour, clockTime.min.format("%02d")]);

      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2 + 10,
        _timeFont,
        timeString,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER 
      );
    }

    private function drawDate(dc, date) {
      //var dateString = Lang.format("$1$ $2$", [date.day_of_week, date.day]);

      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2 - 60,
        _timeFont,
        date.day,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER 
      );
    }

    private function drawWeather(dc, temperature) {
      var temperatureString = temperature.format("%d");

      dc.drawText(
        dc.getWidth() / 2,
        dc.getHeight() / 2 + 60,
        _timeFont,
        temperatureString,
        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER 
      );
    }

}
