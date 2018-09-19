 package;

 import flixel.FlxSprite;
 import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.math.FlxPoint;
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
		 width = 100; //100, 114
		 height = 114;
		 loadGraphic("assets/images/duck.png", true, 100, 114);
		 animation.add("walk", [0,1,2,1,0], 10, true);
		 drag.x = drag.y = 1600;
		 //animation.play("walk");
	 }
	 public function play_animation():Void{
		 //animation_playing = true;
		 animation.play("walk");
	 }
	 public function end_animation():Void{
		 //animation_playing = false;
		 animation.finish();
	 }
	 function movement():Void{
 		//player movement control
 		//moving animation plays as player moves
		if(FlxG.keys.justReleased.A){
			flipX = false;
		}
		var up : Bool =  false; 
		var left : Bool =  false; 
		var down : Bool =  false; 
		var right : Bool =  false; 
		up = FlxG.keys.pressed.W;
		left = FlxG.keys.pressed.A;
		down = FlxG.keys.pressed.S;
		right = FlxG.keys.pressed.D;
		if(up && down){
			up = down = false;
		}
		if(left && right){
			left = right = false;
		}
		var moving : Bool = (up || left || right || down);
 		if(FlxG.keys.anyJustPressed([W,A,S,D]) && moving){
 			play_animation();
 		}
 		if(!moving){
 			end_animation();
 		}
		
		//angle rotates clockwise
		if(moving){
			if(FlxG.keys.justPressed.A){
				flipX = true;
			}
			
 			var angle : Float = 0;
			if(up){
				angle = 270;
				if(left){
					angle -= 45;
				}
				else if(right){
					angle += 45;
				}
			}
			else if(down){
				angle = 90;
				if(left){
					angle += 45;
				}
				else if(right){
					angle -= 45;
				}
			}
			else if(left){
				angle = 180;
			}
			else if(right){
				angle = 0;
			}
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