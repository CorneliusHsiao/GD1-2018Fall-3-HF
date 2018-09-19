package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

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
