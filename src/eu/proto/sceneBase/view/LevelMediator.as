package eu.proto.sceneBase.view
{
import feathers.controls.supportClasses.LayoutViewPort;

import org.robotlegs.mvcs.StarlingMediator;

public class LevelMediator extends StarlingMediator
{
    [Inject]
    public var view:Level;

    public function LevelMediator()
    {
        super();
    }

    override public function onRegister():void
    {
        trace("LevelMediator.onRegister()");
    }

    override public function onRemove():void
    {
        trace("LevelMediator.onRemove()");
    }
}
}
