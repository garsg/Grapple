package eu.proto.gameActors
{
	import Box2D.Collision.Shapes.b2CircleShape;
import eu.proto.sceneBase.view.BodySprite;
import eu.proto.sceneBase.view.Level;

import flash.geom.Point;

import starling.display.Image;
	import starling.textures.Texture;
import starling.textures.TextureAtlas;

/**
	 * Graphical and physical representation of the a cap, with it's own touch interface 
	 * @author Tomasz Piotrowski
	 */
	
	public class Droid extends BodySprite
	{
		private var image:Image;
        private var texture:Texture;
        public static var chainLinkTexture:Texture;

        [Embed(source="/assets/droid.xml", mimeType="application/octet-stream")]
        public static const DroidSheetXML:Class;
        [Embed(source = "/assets/droid.png")]
        private static const DroidSheet:Class;
		
		public function Droid(kind:int = 0)
		{
			super();
            var xml:XML = XML(new DroidSheetXML());
            var parallaxAtlas = new TextureAtlas(Texture.fromBitmap(new DroidSheet(),true), xml);

            texture = parallaxAtlas.getTexture("Android_Robot");
			chainLinkTexture = parallaxAtlas.getTexture("link");
			
			image = new Image(texture);
			addChild(image);
			shape = new b2CircleShape(100 / Level.worldScale);

		}

        public var chainLinks:Vector.<BodySprite>;

        public function shootChain(target:Point):void
        {

        }
		
	}

}