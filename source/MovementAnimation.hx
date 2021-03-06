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
		var integralTime: Float = 0.0;
		var timeToNextPoint: Float = 0.0;
		for (x in 0 ... times.length)
		{
			timeToNextPoint = times[(x) % times.length];
			if (timeToNextPoint + integralTime > currentTime)
			{
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
			
				var percent: Float = (currentTime - integralTime) / timeToNextPoint;
				var newX: Float = (point2.x * percent) + (point1.x * (1 - percent));
				var newY: Float = (point2.y * percent) + (point1.y * (1 - percent));
				guard.setPosition(newX, newY);
				guard.flashlight.setPosition(newX, newY);
				if (guard.facing == FlxObject.UP)
				{
					guard.flashlight.angle = 0;
					guard.flashlight.setPosition(newX + 40, newY - 50);

				}
				else if (guard.facing == FlxObject.DOWN)
				{
					guard.flashlight.angle = 180;
					guard.flashlight.setPosition(newX + 40, newY + 64);
				}
				else if (guard.facing == FlxObject.LEFT)
				{
					guard.flashlight.angle = 270;
					guard.flashlight.setPosition(newX - 35, newY + 40);

				}
				else if (guard.facing == FlxObject.RIGHT)
				{
					guard.flashlight.angle = 90;
					guard.flashlight.setPosition(newX + 60, newY + 40);
				}
				return;

			}
			else
			{
				integralTime += times[x];
			}
		}
	}

}