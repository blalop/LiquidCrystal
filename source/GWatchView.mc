import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

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

}
