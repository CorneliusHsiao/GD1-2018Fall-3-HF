package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/*
	class Target
*/
class Target extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _activated:Bool = false;

	public function new(?row:Int=0, ?col:Int=0) {
		super(row, col);
		_row = row;
		_col = col;
	}
}
