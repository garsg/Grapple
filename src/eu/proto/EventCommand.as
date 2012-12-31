package eu.proto
{
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author Proto
	 */
	public class EventCommand extends StarlingCommand 
	{
		
		public function EventCommand() 
		{
			super();
			
		}
		
		override public function execute():void
        {
            trace("EventCommand.execute()");
        }
	}

}