import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.FlxObject;

class Mirror extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		moves = false;
		immovable = true;
		solid = true;
		width = 32;
		height = 32;
		//offset.set(3,3);
		loadGraphic("assets/images/Mirror.png", true, 32, 32);
		
		//this segment of code flips the image as the 
		//direction that the object faces change
		
		//the mirror should only have two states like "/" and "\"
		//so I'm assuming it only faces upwards or downwards
		
		//the facing variable can also be used to define the state (orientation)
		//of the mirror
		
		setFacingFlip(FlxObject.DOWN, false, true);
		setFacingFlip(FlxObject.UP, false, false);
		
		
		facing = FlxObject.DOWN;
	}
 	override public function update(elapsed:Float):Void
 	{
     	super.update(elapsed);
 	}
	public function flip():Void{
		
		//This segment of code only modifies the facing variable
		
		if(facing == FlxObject.DOWN){
			facing = FlxObject.UP;
		}
		else if(facing == FlxObject.UP){
			facing = FlxObject.DOWN;
		}
	}
}