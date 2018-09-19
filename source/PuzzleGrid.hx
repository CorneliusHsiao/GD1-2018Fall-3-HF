package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;


typedef Point = {
	x: Int,
	y: Int
};

class LightBeamData {
	var didContactGem: Bool;
	var pointList: Array<Point>;
	public function new()
	{
		didContactGem = false;
		pointList = new Array<Point>();
	}
}

class PuzzleGrid
{
	var _width: Int = 0;
	var _height: Int = 0;
	var _offsetX: Int = 0;
	var _offsetY: Int = 0;
	var _boxSize: Int = 0;
	var objectMap: Map<String, Array<FlxSprite>> = new Map<String, Array<FlxSprite>>();
	
	public function getObjectsAtGridLocation(x: Int, y: Int) : Array<FlxSprite>
	{
		return objectMap.get(xyToKey(x, y));
	}

	public function objectsAtGridLocation(x: Int, y: Int): Int
	{
		return getObjectsAtGridLocation(x, y).length;
	}

	public function isGridSpaceEmpty(x: Int, y: Int): Bool
	{
		return objectsAtGridLocation(x, y) == 0;
	}

    	public function xyToKey(x: Int, y: Int) : String
    	{
		return x + " " + y;
    	}

	public function addObjectToGridLocation(x: Int, y: Int, sprite: FlxSprite): Int
	{
		return objectMap.get(xyToKey(x, y)).push(sprite);
	}

	public function removeObjectAtGridLocation(x: Int, y: Int, sprite: FlxSprite): Bool
	{
		return objectMap.get(xyToKey(x, y)).remove(sprite);
	}

	public function removeObjectFromGrid(sprite: FlxSprite): Bool
	{
		var removed = false;
		for (x in 0..._width)
		{
			for (y in 0..._height)
			{
				removed = removeObjectAtGridLocation(x, y, sprite);
				if (removed)
				{
					return true;
				}
			} 
		}

		return false;
	}

	public function getDataForLightBeam(startX: Int, startY: Int): LightBeamData
	{
		var lbd = new LightBeamData();
		return lbd;
	}

	public function new(width: Int, height: Int, boxSize: Int, offsetX: Int, offsetY: Int)
	{
		_width = width;
		_height = height;
		_boxSize = boxSize;
		_offsetX = offsetX;
		_offsetY = offsetY;
		
		for (x in 0..._width)
		{
			for (y in 0..._height)
			{
				objectMap.set(xyToKey(x, y), new Array<FlxSprite>());
			}
		}
	}
}


