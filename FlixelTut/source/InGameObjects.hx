package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

// ************* DO NOT NEED NOW *************
/*
	class Scene:
	Hold all elements that will fill the whole window throughout the main game.
*/
class Scene extends FlxSprite {
	var _background:String = "";

	public function new(?background:String="", ?width:Int=0, ?height:Int=0) {
		super(background, width, height);
		_background = background;
		// Load background image from default image folder
		loadGraphic("assets/images/"+_background, false, width, height);
	}
}

/*
	class Slot:
	The elements inside object Puzzle -- the main playground of main game

	Inaccessable slots: should be marked "_shown=false"
	Occupied slots: should be marked "_occupied=true"
*/
class Slot extends Puzzle {
	var _row:Int = 0;
	var _col:Int = 0;
	var _shown:Bool = false;
	var _occupied:Bool = false;

	public function new(?row:Int=-1, ?col:Int=-1, ?shown:Bool=false, ?occupied:Bool=false) {
		super(row, col, shown, occupied);
		_shown = shown;
		_occupied = occupied;
	}
}

/*
	class Puzzle:
	The active playground in main game. It sets the bound where player and effect can reach.
	Generally, Puzzle is a rectangular area.
*/
class Puzzle extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _slot_side:Int = 0;
	var _puzzle:Array<Array<Slot>> = null;

	public function new(?heigth:Int=0, ?width:Int=0, ?slot_side:Int=0, ?unshown_slots:Array<Array<Int>>=null) {
		super(height, width, slot_side, unshown_slots);
		_row = height;
		_col = width;
		_slot_side = slot_side;
		// Create a full rectangule grid
		_puzzle = [for (x in 0..._row) [for (y in 0..._col) new Slot(x, y, true, false)]];
		// Mark inaccessable slots
		for (slot in unshown_slots) {
			_puzzle[slot[0]][slot[1]]._shown = false;
		}
	}
}

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

/*
	class Mirror
*/
class Mirror extends FlxSprite {
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
