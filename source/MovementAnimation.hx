package;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxG.keys;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.*;
import flixel.group.FlxGroup;
import flixel.math.*;


class MovementAnimation
{
	var points: Array<FlxPoint>;
	var times: Array<Float>;
	var currentTime: Float = 0.0;
	var totalTime: Float = 0.0;
	public function new(points: Array<FlxPoint>, times: Array<Float>)
	{
		this.points = points;
		this.times = times;

		for (time in this.times)
		{
			totalTime += time;
		}
	}

	public function updateTime(elapsed:Float): Void
	{
		currentTime = (currentTime + elapsed) % totalTime;
	}

	public function setPositionAndDirection(guard: Guard): Void
	{
		var point1: FlxPoint;
		var point2: FlxPoint;
		var timeForPoint1: Float = 0.0;
		var timeToNextPoint: Float = 0.0;
		for (x in 0 ... times.length)
		{
			if (times[(x + 1) % times.length] + timeForPoint1 > currentTime)
			{
				timeToNextPoint = times[(x + 1) % times.length];
				point1 = points[(x) % times.length];
				point2 = points[(x + 1) % times.length];
				var dx: Float = point2.x - point1.x;
				var dy: Float = point2.y - point1.y;
				if (dy == 0.0 && dx >= 0.0)
				{
					guard.facing = FlxObject.RIGHT;
					guard.animation.play("go_right");
				}
				else if (dx == 0.0 && dy > 0.0)
				{
					guard.facing = FlxObject.DOWN;
					guard.animation.play("go_down");
				}
				else if (dy == 0.0 && dx < 0.0)
				{
					guard.facing = FlxObject.LEFT;
					guard.animation.play("go_left");
				}
				else if (dx == 0.0 && dy < 0.0)
				{
					guard.facing = FlxObject.UP;
					guard.animation.play("go_up");
				}
				else
				{
					//something is wrong.				
				}
			
				var percent: Float = (currentTime - timeForPoint1) / timeToNextPoint;
				var newX: Float = (point2.x * percent) + (point1.x * (1 - percent));
				var newY: Float = (point2.y * percent) + (point1.y * (1 - percent));
								

				guard.setPosition(newX, newY);
				return;

			}
			else
			{
				timeForPoint1 += times[x];
			}
		}
	}

}