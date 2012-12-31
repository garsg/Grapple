package eu.proto.sceneBase.view
{

import flash.geom.Point;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;

import starling.events.Event;

import starling.textures.Texture;

public class ParallaxLayer extends Sprite
{
    private var _depth:Number = 1;
    private var _displayScale:Number = 1;

    private var _baseScale:Number = 1;

    private var _rows:int = 0;
    private var _cols:int = 0;

    private var _tileWidth:Number = 0;
    private var _tileHeight:Number = 0;

    private var _movingDown:Boolean = true;
    private var _movingRight:Boolean = true;

    public function get depth():Number
    {
        return _depth;
    }

    public function set depth(value:Number):void
    {
        _depth = value;
    }

    private var _texture:Texture;
    private var _sceneWidth:Number;
    private var _sceneHeight:Number;

    private var _position:Point = new Point();

    private var tiles:Vector.<Image> = new Vector.<Image>();

    public function ParallaxLayer(texture:Texture, depth:Number)
    {
        super();
        _texture = texture;
        _depth = depth;

        _baseScale = Level.displayScale;

        _tileWidth = texture.width;
        _tileHeight= texture.height;

        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void
    {
        generateTilesToFitView();
    }

    public function generateTilesToFitView():void
    {
        _displayScale = Level.displayScale;

        _sceneWidth = Starling.current.stage.stageWidth / Level.displayScale;
        _sceneHeight = Starling.current.stage.stageHeight / Level.displayScale;

        var new_cols:int = Math.ceil(_sceneWidth / _tileWidth) + 2;
        var new_rows:int = Math.ceil(_sceneHeight / _tileHeight) + 2;

        if(new_cols == _cols && new_rows == _rows)
        {
            return;
        }

        /*while(tiles.length > 0)
        {
            removeChild(tiles.pop());
        } */


        var tile:Image;

        for(var i:int = 0; i< new_cols; i++)
        {
            for(var j:int = 0; j< new_rows; j++)
            {
                if(i > _cols - 1 || j > _rows - 1)
                {
                    var isNew = true;
                    for each(var tile:Image in tiles)
                    {
                        if(tile.x == i * tile.width && tile.y == j * tile.height)
                        {
                            isNew = false;
                            break;
                        }

                    }
                    if(isNew)
                    {
                        tile = new Image(_texture);
                        tile.x = i * tile.width;
                        tile.y = j * tile.height;
                        tiles.push(tile);
                        addChild(tile);
                    }

                }
            }
        }

        if(new_cols < _cols || new_rows < _rows)
        {
            for each(var tile:Image in tiles)
            {
                if(tile.x >= new_cols * tile.width || tile.y >= new_rows * tile.height)
                {
                    removeChild(tiles.splice(tiles.indexOf(tile),1)[0], true);
                }
            }
        }

        _cols = new_cols;
        _rows = new_rows;

        flatten();
        trace(tiles.length);
    }

    public function update():void
    {
        if(Level.displayScale != _displayScale)
        {
            generateTilesToFitView();
        }

        scaleX = scaleY = 1 / Level.displayScale + (1 - (1 / Level.displayScale)) * depth;

        if(tiles.length > 0)
        {
            x = -position.x + (((depth * position.x) % (tiles[0].width * scaleX)) - tiles[0].width * scaleX);
            y = -position.y + (((depth * position.y) % (tiles[0].height * scaleY)) - tiles[0].height * scaleY);
        }
    }

    public function get position():Point
    {
        return _position;
    }

    public function set position(value:Point):void
    {
        if(_position.x >= value.x)
        {
            _movingRight = true;
        }
        else if(x + position.x > tiles[0].width)
        {
            _movingRight = false;
        }
        else
        {
            _movingRight = true;
        }

        if(_position.y >= value.y)
        {
            _movingDown = true;
        }
        else if(y + position.y > tiles[0].height)
        {
            _movingDown = false;
        }
        else
        {
            _movingDown = true;
        }

        _position = value;
    }
}
}
