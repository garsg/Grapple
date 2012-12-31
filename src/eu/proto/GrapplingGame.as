package eu.proto
{
import eu.proto.gameActors.Droid;
import eu.proto.sceneBase.view.BodySprite;
import eu.proto.sceneBase.view.Level;

    import org.robotlegs.mvcs.StarlingContext;

    import starling.display.BlendMode;
    import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;
    import starling.extensions.ParallaxLayer;
    import starling.text.TextField;
	import starling.textures.Texture;
	import starling.core.Starling;
    import starling.textures.TextureAtlas;

    /**
	 * ...
	 * @author Proto
	 */
	public class GrapplingGame extends Sprite
	{
        [Embed(source="/assets/parallax.xml", mimeType="application/octet-stream")]
        public static const ParallaxSheetXML:Class;
        [Embed(source = "/assets/parallax.png")]
        private static const ParallaxSheet:Class;

		public var scene:Level;
		private var _starlingContext:StarlingContext;

        public function GrapplingGame()
		{
			super();
			
			_starlingContext = new StarlingGameContext(this);

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame)
		}

        private function onFrame(event:EnterFrameEvent):void
        {
            if(droid)
            {
                Level.displayOffset.y -= (Level.displayOffset.y + (droid.y - 500)) * event.passedTime * 5;
            }
        }

        public var droid:Droid;

        private function onAddedToStage(event:Event):void
        {
            var xml:XML = XML(new ParallaxSheetXML());

            scene = new Level(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight );
            Level.displayScale = Starling.current.stage.stageWidth / 1024;

            var parallaxAtlas = new TextureAtlas(Texture.fromBitmap(new ParallaxSheet(),true), xml);

            scene.addParallaxLayer(parallaxAtlas.getTexture("sky"), 0);
            scene.addParallaxLayer(parallaxAtlas.getTexture("clouds"), 0.2);
            scene.addParallaxLayer(parallaxAtlas.getTexture("girder"), 0.8);
            scene.addParallaxLayer(parallaxAtlas.getTexture("glass_tube"), 1);


			_starlingContext.contextView.addChild(scene);

            droid = new Droid();
            droid.x = 512;
			scene.addChild(droid);
        }
		
	}

}