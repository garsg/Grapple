/**
 * Author: Tomasz Piorowski
 * Date: 30.12.12
 * Time: 22:47
 */
package eu.proto.gameActors
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;

	import eu.proto.sceneBase.view.BodySprite;
	import eu.proto.sceneBase.view.Level;

	import starling.display.Image;

	public class ChainLink extends BodySprite
	{
		private var image:Image;
		var revolute_joint:b2RevoluteJointDef=new b2RevoluteJointDef();

		public function ChainLink(previousLink:BodySprite, finalLink:BodySprite = null)
		{
			pivotY = 5;
			image = new Image(Droid.chainLinkTexture);
			addChild(image);
			shape = new b2PolygonShape();
			(shape as b2PolygonShape).SetAsEdge(new b2Vec2(0, Level.worldScale * 0), new b2Vec2(Level.worldScale * 60, 0));
			/*revolute_joint.Initialize(previousLink.body, body, new b2Vec2(, i-0.5));
			.CreateJoint(revolute_joint); */
			super();
		}
	}
}
