package eu.proto
{
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author Proto
	 */
	public class GrapplingGameMediator extends StarlingMediator
	{
		
		public function GrapplingGameMediator()
		{
			super ();
		}

		
		 
		override public function onRegister():void
        {
            trace("GameMediator.onRegister()");
        }

        override public function onRemove():void
        {
            trace("GameMediator.onRemove()");
        }
	}

}