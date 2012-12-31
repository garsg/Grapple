package eu.proto
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Proto
	 */
	public class FlashEvent extends Event 
	{
		public static const EVENT_NAME:String = "bla";
		public function FlashEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}