package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.math.*;

class LightBeamData {
	public var didContactGem: Bool;
	public var pointList: Array<FlxPoint>;
	public var beamSprites: Array<Light>;
	public function new()
	{
		didContactGem = false;
		pointList = new Array<FlxPoint>();
		beamSprites = new Array<Light>();
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

    public function getDataForLightBeam(startX: Int, startY: Int, endX: Int, endY: Int, direction: Int): LightBeamData
	{
		var RIGHT = 0;
		var DOWN = 1;
		var LEFT = 2;
		var UP = 3;
		var currentDirection = direction;
		var currentX = startX;
		var currentY = startY;
		var dx = 0;
		var dy = 0;
		var lbd = new LightBeamData();
		var p = new FlxPoint(startX, startY);
		lbd.pointList.push(p);


		while (true)
		{
			if (currentDirection == UP)
			{
				dx = 0;
				dy = -1; // not a mistake
			}
			if (currentDirection == DOWN)
			{
				dx = 0;
				dy = 1; // not a mistake
			}
			if (currentDirection == LEFT)
			{
				dx = -1;
				dy = 0;
			}
			if (currentDirection == RIGHT)
			{
				dx = 1;
				dy = 0;
			}

			if (currentX + dx >= _width || currentY + dy >= _height || currentX + dx < 0 || currentY + dy < 0)
			{
				break;
			}
			else
			{
				currentX += dx;
				currentY += dy;

				lbd.pointList.push(new FlxPoint(currentX, currentY));
				if (currentY == endY && currentX == endX)
				{
					lbd.didContactGem = true;
					break;
				}

				if (!isGridSpaceEmpty(currentX, currentY))
				{	
					var directionForL = 0;
					//the magic reflection formula.
					if (getObjectsAtGridLocation(currentX, currentY)[0].facing == FlxObject.DOWN)
					{
						if (currentDirection == RIGHT || currentDirection == UP)
						{
							directionForL = RIGHT;
						}
						else
						{
							directionForL = LEFT;
						}

						if (currentDirection % 2 == 0)
						{
							currentDirection += 1;
						}
						else
						{
							currentDirection -= 1;
						}
					}
					else
					{
						if (currentDirection == LEFT || currentDirection == UP)
						{
							directionForL = UP;
						}
						else
						{
							directionForL = DOWN;
						}

						currentDirection = 3 - currentDirection;
					}
					lbd.beamSprites.push(new Light(currentX * _width + _offsetX, currentY * _height + _offsetY, directionForL, 0));

				}
				else
				{
					lbd.beamSprites.push(new Light(currentX * _width + _offsetX, currentY * _height + _offsetY, currentDirection, 1));
				}
			}
		}


		return lbd;
	}

	public function setPositionForAllObjects()
	{
		for (x in 0..._width)
		{
			for (y in 0..._height)
			{
				for (obj in getObjectsAtGridLocation(x, y))
				{
					obj.setPosition(x * _boxSize + _offsetX, y * _boxSize + _offsetY);
				}
			}
		}
	}

	public function getAllObjects(): Array<FlxSprite>
	{
		var allObjects: Array<FlxSprite> = new Array<FlxSprite>();
		for (x in 0..._width)
		{
			for (y in 0..._height)
			{
				for (obj in getObjectsAtGridLocation(x, y))
				{
					allObjects.push(obj);
				}
			}
		}
		return allObjects;
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


