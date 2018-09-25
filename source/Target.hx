package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/*
	class Target
*/
class Target extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _side_length:Int = 0;
	/**
		_activated:
		"false": open gate
		"true": closed gate
	**/
	var _activated:Bool = false;
	var _inactivated_img:String="";
	var _activated_img:String="";

	public function new(?row:Int=0, ?col:Int=0, ?side_length:Int=0, ?inactivated_img:String="", ?activated_img:String="") {
		super();
		this._row = row;
		this._col = col;
		this._side_length = side_length;
		this._activated = false;
		this._inactivated_img = inactivated_img;
		this._activated_img = activated_img;

		loadGraphic(this._inactivated_img, false, _side_length, _side_length, true);
		setPosition(this._col, this._row);
	}

	/*
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
		}
	}
	*/

	public function getActivationStatus():Bool {
		return this._activated;
	}

	public function setActivationStatus(switchStatus:Bool):Void {
		this._activated = true;
	}
}
