import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class GWatchApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new GWatchView() ];
    }

}

function getApp() as GWatchApp {
    return Application.getApp() as GWatchApp;
}