package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/*
	class Light:
	
	Light and Light_Beam are separated classes.
*/
class Light extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	/*
		_dir: direction of light
		0: Upware
		1: Downward
		2: Leftward
		3: Rightward
	*/
	var _dir:Int = -1;

	public function new(?row:Int=0, ?col:Int=0, ?dir:Int=-1) {
		super(row, col, dir);
		_row = row;
		_col = col;
		_dir = dir;
	}
}
