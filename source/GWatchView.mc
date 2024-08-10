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
      var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
      var view = View.findDrawableById("Time") as Text;
      view.setText(timeString);

    }

    private function drawDate(dc, date) {
      var dateString = Lang.format("$1$", [date.day]);
      var view = View.findDrawableById("Date") as Text;
      view.setText(dateString);
    }

    private function drawWeather(dc, temperature) {
      var temperatureString = temperature.format("%d");
      var view = View.findDrawableById("Weather") as Text;
      view.setText(temperatureString);
    }

}
