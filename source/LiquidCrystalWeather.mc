import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Weather;

class LiquidCrystalWeather extends WatchUi.Drawable {

    private var _x;
    private var _y;
    private var _font;
    
    typedef LiquidCrystalWeatherParams as {
        :x as Float,
        :y as Float,
    };

    function initialize(params as LiquidCrystalWeatherParams) {
        Drawable.initialize(params);
        _x = params[:x];
        _y = params[:y];
        _font = Application.loadResource(Rez.Fonts.Data);
    }

    function draw(dc as Dc) as Void {
        if (!Properties.getValue("showWeather")) {
            return;
        }

        var currentConditions = Weather.getCurrentConditions();
        var string = Lang.format("$1$C", [currentConditions.temperature.format("%02d")]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_x, _y, _font, string, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.clear();
    }

}