package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.math.FlxPoint;
import flixel.FlxObject;

/*
	class Guard
*/
class Guard extends FlxSprite {
	public var speed : Float = 300;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
	 //animation_playing = false;
     super(X, Y, SimpleGraphic);
	 //set to solid so it collides with other solid objects
	 solid = true;
	 //width and height are for actual hitbox
	 width = 28; //100, 114
	 height = 28;
	 offset.set(2,2);
	 loadGraphic("assets/images/GuardSpriteSheet.png", true, 32, 32);
	 animation.add("go_left", [10,11,12,11], 6, true);
	 animation.add("go_right", [7,8,9,8], 6, true);
	 animation.add("go_up", [1,2,3,2], 6, true);
	 animation.add("go_down", [4,5,6,5], 6, true);
	 drag.x = drag.y = 1600;
	 //set default facing direction
	 facing = FlxObject.DOWN;
	 //animation.play("walk");
 	}
	//basic movement, assuming guard moves all the time and
	//moves in the direction it faces
	
	//need to implement a function to let the guard follow
	//a certain pattern
	function movement(): Void{
		var angle : Float = 0;
		if(facing == FlxObject.RIGHT){
			angle = 0;
		}
		else if(facing == FlxObject.DOWN){
			angle = 90;
		}
		else if(facing == FlxObject.LEFT){
			angle = 180;
		}
		else if(facing == FlxObject.RIGHT){
			angle = 270;
		}
		velocity.set(speed, 0);
		velocity.rotate(FlxPoint.weak(0, 0), angle);
	}
	override public function update(elapsed:Float):Void{
		movement();
		super.update(elapsed);
	}
	
}
