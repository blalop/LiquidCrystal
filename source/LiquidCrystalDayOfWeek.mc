import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Time.Gregorian as Calendar;

class LiquidCrystalDayOfWeek extends WatchUi.Drawable {

    private var _x;
    private var _y;
    private var _font;
    
    typedef LiquidCrystalDateParams as {
        :x as Float,
        :y as Float,
    };

    function initialize(params as LiquidCrystalDateParams) {
        Drawable.initialize(params);
        _x = params[:x];
        _y = params[:y];
        _font = Application.loadResource(Rez.Fonts.Data);
    }

    function draw(dc as Dc) as Void {
        var date = Calendar.info(Time.now(), Time.FORMAT_LONG);
        var string = date.day_of_week;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_x, _y, _font, string, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.clear();
    }

}