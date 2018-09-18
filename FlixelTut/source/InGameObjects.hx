package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/*
	class Scene:
	Hold all elements that will fill the whole window throughout the main game.
*/
class Scene extends FlxSprite {
	var background_img_name = String;

	public function new(?background_img_name:String="", ?width:Int=0, ?height:Int=0) {
		super(background_img_name, width, height);
		// Load background image from default image folder
		loadGraphic("assets/images/"+background_img_name, False, width, height);
	}
}

/*
	class Slot:
	The elements inside object Puzzle -- the main playground of main game

	Inaccessable slots: should be marked "shown=False"
	Occupied slots: should be marked "occupied=True"
*/
class Slot extends FlxSprite {
	var shown = Bool;
	var occupied = Bool;

	public function new(?row:Int=-1, ?col:Int=-1, ?in_shown:Bool=False, ?in_occupied:Bool=False) {
		super(row, col, in_shown, in_occupied);
		shown = in_shown;
		occupied = in_occupied;
	}
}

/*
	class Puzzle:
	The active playground in main game. It sets the bound where player and effect can reach.
	Generally, Puzzle is a rectangular area.
*/
class Puzzle extends Slot {
	var row = Int;
	var col = Int;

	public function new(?heigth:Int=0, ?width:Int=0, ?slot_side:Int=0, ) {
		super(height, width);
		row = height;
		col = width;
	}
}
