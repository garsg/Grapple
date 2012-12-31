package eu.proto
{
import eu.proto.sceneBase.view.Level;
import eu.proto.sceneBase.view.LevelMediator;

import org.robotlegs.mvcs.StarlingContext;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Proto
	 */
	public class StarlingGameContext extends StarlingContext 
	{
		
		public function StarlingGameContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
			
		}
		
		override public function startup():void
        {
            mediatorMap.mapView(GrapplingGame, GrapplingGameMediator);
            mediatorMap.mapView(Level, LevelMediator);

            commandMap.mapEvent(FlashEvent.EVENT_NAME, EventCommand);

            super.startup();
        }
		
	}

}