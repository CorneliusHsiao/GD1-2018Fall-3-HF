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
	public var flashlight = new FlxSprite(0, 0);
    public function new(?X:Float=0, ?Y:Float=0, points:Array<FlxPoint>, times:Array<Float>, ?SimpleGraphic:FlxGraphicAsset)
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

	 //set default facing direction
	 facing = FlxObject.DOWN;
	movementAnimation = new MovementAnimation(points, times);
	setGraphicSize(64, 64);
	updateHitbox();

	flashlight.loadGraphic("assets/images/FlashlightLight.png", false, 32, 32);
	flashlight.alpha = 0.8;
	flashlight.setGraphicSize(32, 64);
 	}

	override public function update(elapsed:Float):Void{
		movementAnimation.updateTime(elapsed);
		movementAnimation.setPositionAndDirection(this);
		super.update(elapsed);
	}
	
}
