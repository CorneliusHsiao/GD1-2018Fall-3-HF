/**
	TO DO: Need different png images for different orientation of the gate.
**/

package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
	class Gate:
	Entrance or Exit
**/
class Gate extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _side_length:Int = 0;
	/**
		_dir: direction of movement
			0: Upware
			1: Downward
			2: Leftward
			3: Rightward
	**/
	var _dir:Int = -1;
	/**
		_activated:
		"false": open gate
		"true": closed gate
	**/
	var _activated:Bool = false;

	/**
		Opening and closing door is disabled for now.

		var _closed_img:String = null;
		var _open_img:String = null;
	**/

	public function new(?row:Int=0, ?col:Int=0, ?side_length:Int=0, ?gate_img:String="", ?dir:Int=-1) {
		super();
		this._row = row;
		this._col = col;
		this._side_length = side_length;
		this._activated = false;
		/*
		this._closed_img = closed_img;
		this._open_img = open_img;
		*/
		this._gate_img = gate_img;

		if (dir != 0 && dir != 1 && dir != 2 && dir != 3) {
			trace("Error: Gate direction is wrong.");
		}

		if (dir == 0) {
			loadGraphic(this._gate_img, false, _side_length*3, _side_length, true);
			setPosition(this._col-this._side_length, this._row);
		}
		else if (dir == 1) {
			loadGraphic(this._gate_img, false, _side_length*3, _side_length, true);
			setPosition(this._col-this._side_length, this._row);
		}
		else if (dir == 2) {
			loadGraphic(this._gate_img, false, _side_length, _side_length*3, true);
			setPosition(this._col, this._row)-this._side_length;
		}
		else {
			loadGraphic(this._gate_img, false, _side_length, _side_length*3, true);
			setPosition(this._col, this._row-this._side_length);
		}
	}

/**
	Opening and closing door is disabled for now.

	public function trigger() {
		if (this._activated == false) {
			this._activated = true;
			loadGraphic(this._closed_img, false, this._side_length, this._side_length, true);
			setPosition(this._col, this._row+this._side_length);
		
		}
		else {
			this._activated = false;
			loadGraphic(this._open_img, false, this._side_length, this._side_length*3, true);
			setPosition(this._col, this._row);
			trace("Warning: Gate " + this._type + " reopened.");
		}
	}
}
**/
