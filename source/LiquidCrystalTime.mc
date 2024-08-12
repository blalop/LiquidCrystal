import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class LiquidCrystalTime extends WatchUi.Drawable {

    private var _x;
    private var _y;
    private var _font;
    
    typedef LiquidCrystalTimeParams as {
        :x as Number,
        :y as Number,
    };

    function initialize(params as LiquidCrystalTimeParams) {
        Drawable.initialize(params);
        _x = params[:x];
        _y = params[:y];
        _font = Application.loadResource(Rez.Fonts.Time);
    }

    function draw(dc as Dc) as Void {
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_x, _y, _font, timeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.clear();
    }
}