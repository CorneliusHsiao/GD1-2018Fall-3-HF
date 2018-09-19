import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.FlxObject;

<<<<<<< HEAD
	public function new(?row:Int=0, ?col:Int=0, ?dir:Int=-1) {
		super();
		loadGraphic("assets/images/Mirror.png", true, 32, 32);
		_row = row;
		_col = col;
		_dir = dir;
=======
class Mirror extends FlxSprite{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset){
		super(X, Y, SimpleGraphic);
		moves = false;
		immovable = true;
		solid = true;
		width = 26;
		height = 26;
		offset.set(3,3);
		loadGraphic("assets/images/mirror.png", true, 32, 32);
		setFacingFlip(FlxObject.DOWN, false, false);
		setFacingFlip(FlxObject.UP, false, true);
		facing = FlxObject.DOWN;
	}
 	override public function update(elapsed:Float):Void
 	{
     	super.update(elapsed);
 	}
	public function flip():Void{
		if(facing == FlxObject.DOWN){
			facing = FlxObject.UP;
		}
		else if(facing == FlxObject.UP){
			facing = FlxObject.DOWN;
		}
>>>>>>> 2c72471cef6905dab4d7748b5b8915edaf35a141
	}
}