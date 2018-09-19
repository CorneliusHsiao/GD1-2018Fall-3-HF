package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/*
	class Gate:
	Entrance or Exit
*/
class Gate extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _type:String = "";

	public function new(?row:Int=0, ?col:Int=0, ?type:String="") {
		super(row, col, type);
	}
}
