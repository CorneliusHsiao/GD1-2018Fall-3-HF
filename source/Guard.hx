package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/*
	class Guard
*/
class Guard extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	/*
		_speed: speed of current movement (slots per 3 seconds)
		_dir: direction of movement
		0: Upware
		1: Downward
		2: Leftward
		3: Rightward
	*/
	var _speed:Int = -1;
	var _dir:Int = -1;

	public function new(?row:Int=0, ?col:Int=0, ?speed:Int=-1, ?dir:Int=-1) {
		super(row, col);
		_row = row;
		_col = col;
		_speed = speed;
		_dir = dir;
	}
}
