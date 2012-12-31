package eu.proto
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.robotlegs.mvcs.StarlingContext;
	import starling.core.Starling;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	/**
	 * ...
	 * @author Proto
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
        public function Main()
        {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 60;
			stage.addEventListener(Event.RESIZE, onResize);
        }
		
		private function onResize(e:Event):void 
		{
            initViewPort();
            removeEventListener(Event.RESIZE, onResize);
		}
		
		private function initViewPort():void
		{
            var viewPort:Rectangle = new Rectangle();
            viewPort.width = stage.stageWidth;
            viewPort.height = stage.stageHeight;

            Starling.multitouchEnabled = true;

            _starling = new Starling(GrapplingGame, stage, viewPort);
            _starling.start();
			_starling.showStats = true;
            _starling.antiAliasing = 0;
		}
		

	}
	
}