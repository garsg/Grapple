package eu.proto.sceneBase.view
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

import flash.geom.Point;

    import starling.display.BlendMode;
    import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

/**
	 * Base class for the game scene, taking care of physics recalculation
	 * @author Tomasz Piotrowski
	 */
	
	public class Level extends Sprite
	{
		protected var world:b2World;
		private var dt:Number;
		public static var worldScale:Number = 20;
		public static var displayScale:Number = 1;
		public static var displayOffset:Point = new Point();

        private var background:Sprite = new Sprite();
        private var gamePlane:Sprite = new Sprite();
        private var foreground:Sprite = new Sprite();
		
		public function Level(width:Number, height:Number):void
		{
			world = new b2World(new b2Vec2(0, 10), true);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            super.addChild(background);
            super.addChild(gamePlane);
            super.addChild(foreground);
            background.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onFrame(e:EnterFrameEvent):void
		{
			world.Step(e.passedTime, 10, 10);
			world.ClearForces();
			
			scaleX = Level.displayScale;
			scaleY = Level.displayScale;
			
			x = displayOffset.x * displayScale;
			y = displayOffset.y * displayScale;




            for (var i:int = 0; i < background.numChildren; i++)
            {
                var child:DisplayObject = background.getChildAt(i);
                if (child is ParallaxLayer)
                {
                    (child as ParallaxLayer).position = new Point((displayOffset.x) - pivotX, (displayOffset.y) - pivotY);
                    (child as ParallaxLayer).update();
                }
            }
			
			for (var i:int = 0; i < gamePlane.numChildren; i++)
			{
				var child:DisplayObject = gamePlane.getChildAt(i);
				if (child is BodySprite)
				{
					(child as BodySprite).update();
				}
			}
		}

        public function addParallaxLayer(texture:Texture, depth:Number, blendMode:String = BlendMode.AUTO):void
        {
            var layer:ParallaxLayer = new ParallaxLayer(texture, depth);

            if(depth <= 1)
            {
                addLayerToSprite(layer, background);
            }
            else
            {
                addLayerToSprite(layer, foreground);
            }
        }

        private function addLayerToSprite(layer:ParallaxLayer, sprite:Sprite):void
        {
            for (var i:int = 0; i < sprite.numChildren; i++)
            {
                var child:DisplayObject = sprite.getChildAt(i);
                if (child is ParallaxLayer)
                {
                    if((child as ParallaxLayer).depth > layer.depth)
                    {
                        sprite.addChildAt(layer,  i);
                        break;
                    }
                }
            }
            if(layer.parent == null)
            {
                sprite.addChild(layer);
            }
        }
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
            gamePlane.addChild(child);
			if (child is BodySprite)
			{
				(child as BodySprite).body = world.CreateBody((child as BodySprite).bodyDef);
			}
            return child;
		}

    private function onTouch(e:TouchEvent):void
    {
        if (e.touches.length == 1)
        {
            var touch:Touch = e.getTouch(stage, TouchPhase.MOVED);
            if (touch && !e.ctrlKey)
            {
                var offset:Point = touch.getMovement(stage);
                Level.displayOffset = Level.displayOffset.add(new Point(offset.x / displayScale, offset.y / displayScale));
            }
            else if (touch)
            {
                Level.displayScale += touch.getMovement(stage).x / 1000;
                var prevPivotX:Number = pivotX;
                var prevPivotY:Number = pivotY;
                pivotX = width/2;
                pivotY = height/2;
                x += pivotX - prevPivotX;
                y += pivotY - prevPivotY;
                Level.displayOffset = new Point(x / displayScale,y / displayScale);
            }
        }
        else
        {
            var touches:Vector.<Touch> = e.getTouches(stage)
            {
                var touchA:Touch = touches[0];
                var touchB:Touch = touches[1];

                var currentPosA:Point  = touchA.getLocation(parent);
                var previousPosA:Point = touchA.getPreviousLocation(parent);
                var currentPosB:Point  = touchB.getLocation(parent);
                var previousPosB:Point = touchB.getPreviousLocation(parent);

                var currentVector:Point  = currentPosA.subtract(currentPosB);
                var previousVector:Point = previousPosA.subtract(previousPosB);

                // update pivot point based on previous center
                var previousLocalA:Point  = touchA.getPreviousLocation(this);
                var previousLocalB:Point  = touchB.getPreviousLocation(this);
                pivotX = (previousLocalA.x + previousLocalB.x) * 0.5;
                pivotY = (previousLocalA.y + previousLocalB.y) * 0.5;

                // update location based on the current center
                x = (currentPosA.x + currentPosB.x) * 0.5;
                y = (currentPosA.y + currentPosB.y) * 0.5;

                // scale
                var sizeDiff:Number = currentVector.length / previousVector.length;

                Level.displayScale *= sizeDiff;

                Level.displayScale = Math.max(Math.min(Level.displayScale, 3),0.3);

                scaleX = Level.displayScale;
                scaleY = Level.displayScale;

                Level.displayOffset = new Point(x / displayScale,y / displayScale);
            }
        }
    }
	}

}