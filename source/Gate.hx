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
	var _type:String = "";
	/**
		_activated:
		"false": open gate
		"true": closed gate
	**/
	var _activated:Bool = false;
	var _closed_img:String = null;
	var _open_img:String = null;

	public function new(?row:Int=0, ?col:Int=0, ?type:String="", ?side_length:Int=0, ?closed_img:String="", ?open_img:String="") {
		super();
		this._row = row;
		this._col = col;
		this._side_length = side_length;
		this._type = type;
		this._activated = false;
		this._closed_img = closed_img;
		this._open_img = open_img;

		loadGraphic(this._open_img, false, _side_length, _side_length*3, true);
		setPosition(this._col, this._row);
	}

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
