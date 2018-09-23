package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.util.*;

/*
	class Guard
*/
class Guard extends FlxSprite {
	public var speed : Float = 300;
	public var movementAnimation: MovementAnimation;

    public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
    {
	 //animation_playing = false;
     super(X, Y, SimpleGraphic);
	 //set to solid so it collides with other solid objects
	 solid = true;
	 //width and height are for actual hitbox
	 width = 26; //100, 114
	 height = 26;
	 offset.set(3,3);
	 loadGraphic("assets/images/GuardSpriteSheet.png", true, 32, 32);
	 animation.add("go_left", [11,10,9,11], 8, true);
	 animation.add("go_right", [6,7,8,6], 8, true);
	 animation.add("go_up", [0,1,2,0], 8, true);
	 animation.add("go_down", [3,4,5,3], 8, true);
	 //drag.x = drag.y = 1600;
	 //set default facing direction
	 facing = FlxObject.DOWN;
	 //animation.play("walk");
	var tempPoints = new Array<FlxPoint>();
	tempPoints.push(new FlxPoint(0, 0));
	tempPoints.push(new FlxPoint(100, 0));
	tempPoints.push(new FlxPoint(100, 100));
	tempPoints.push(new FlxPoint(0, 100));

	var tempTimes = new Array<Float>();
	tempTimes.push(1.3);
	tempTimes.push(1.4);
	tempTimes.push(1.5);
	tempTimes.push(1.2);
	
	movementAnimation = new MovementAnimation(tempPoints, tempTimes); 
	//FlxG.debugger.visible = true;
	//trace("hello");
	//this.path = new FlxPath().start(tempPoints, 50, FlxPath.FORWARD);
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
		//movement();
		movementAnimation.updateTime(elapsed);
		movementAnimation.setPositionAndDirection(this);
		super.update(elapsed);
	}
	
}
