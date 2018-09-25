 package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.math.FlxPoint;
import flixel.FlxObject;

 class Player extends FlxSprite
 {
	 //var animation_playing : Bool;
	 public var speed : Float = 450;
	 
     public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
     {
		 //animation_playing = false;
         super(X, Y, SimpleGraphic);
		 //set to solid so it collides with other solid objects
		 solid = true;
		 //width and height are for actual hitbox
		 width = 30; //100, 114
		 height = 30;
		 offset.set(1,1);
		 //temporarily using guard sprite
		 loadGraphic("assets/images/PlayerWalkInteract.png", true, 32, 32);
		 //loadGraphic("assets/images/GuardSpriteSheet.png", true, 32, 32);
		 animation.add("go_left", [11,9,10,11], 8, true);
		 animation.add("go_right", [6,7,8,6], 8, true);
		 animation.add("go_up", [0,1,2,0], 8, true);
		 animation.add("go_down", [5,3,4,5], 8, true);
		 animation.add("interact", [12,13,12], 3, false);
		 //animation.add("walk", [0,1,2,1,0], 30, true);
		 drag.x = drag.y = 1600;
		 //animation.play("walk");
		setGraphicSize(64, 64);
		updateHitbox();
	 }
	 public function play_animation():Void{
		 switch(facing){
			case FlxObject.UP:
			 	animation.play("go_up");
			case FlxObject.DOWN:
				animation.play("go_down");
			case FlxObject.LEFT:
				animation.play("go_left");
			case FlxObject.RIGHT:
				animation.play("go_right");
		 }
	 }
	 public function end_animation():Void{
		 //animation_playing = false;
		 animation.finish();
	 }
	 function movement():Void{
 		//player movement control
 		//moving animation plays as player moves
		
		var up : Bool =  false; 
		var left : Bool =  false; 
		var down : Bool =  false; 
		var right : Bool =  false; 
		if(FlxG.keys.pressed.W){
			up = true;
			
		}
		else if(FlxG.keys.pressed.A){
			left = true;
			
		}
		else if(FlxG.keys.pressed.S){
			down = true;
			
		}
		else if(FlxG.keys.pressed.D){
			right = true;
			
		}
		
		
		var moving : Bool = (up || left || right || down);
 		
 		if(!moving){
 			end_animation();
 		}
		
		//angle rotates clockwise
		if(moving){
 			var angle : Float = 0;
			if(up){
				angle = 270;
				facing = FlxObject.UP;
			}
			else if(down){
				angle = 90;
				facing = FlxObject.DOWN;
			}
			else if(left){
				angle = 180;
				facing = FlxObject.LEFT;
			}
			else if(right){
				angle = 0;
				facing = FlxObject.RIGHT;
			}
			play_animation();
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), angle);
		}
	 }
	 override public function update(elapsed:Float):Void
	 {
	     movement();
	     super.update(elapsed);
	 }
 }