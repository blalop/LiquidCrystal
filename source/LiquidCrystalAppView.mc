import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Weather;

using Toybox.Time.Gregorian as Calendar;

class LiquidCrystalView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
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
        drawData(dc, Weather.getCurrentConditions(), System.getSystemStats());
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
      var dayString = date.day.toString();
      var dayView = View.findDrawableById("Day") as Text;
      dayView.setText(dayString);

      var weekDayString = date.day_of_week.substring(0, 2).toUpper();
      var weekDayView = View.findDrawableById("WeekDay") as Text;
      weekDayView.setText(weekDayString);
    }

    private function drawData(dc, weather, system) {
      var temperatureString = Lang.format("$1$C", [weather.feelsLikeTemperature.format("%d")]);
      var temperatureView = View.findDrawableById("Temperature") as Text;
      temperatureView.setText(temperatureString);

      var batteryString = Lang.format("$1$%", [system.battery.format("%d")]);
      var batteryView = View.findDrawableById("Battery") as Text;
      batteryView.setText(batteryString);
    }

}
