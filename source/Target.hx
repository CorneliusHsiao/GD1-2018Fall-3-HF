package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/*
	class Target
*/
class Target extends FlxSprite {
	var _row:Int = 0;
	var _col:Int = 0;
	var _side_length:Int = 0;
	/**
		_activated:
		"false": No required lightbeam touched
		"true": Required lightbeam touched
	**/
	var _activated:Bool = false;
	var _inactivated_img:String = null;
	var _activated_img:String = null;

	public function new(?row:Int=0, ?col:Int=0, ?side_length:Int=0, ?inactivated_img:String=null, ?activated_img:String=null):Void {
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

	// *** NOTE: This is single image transition now. If using animation instead, change the code. ***
	public function trigger():Void {
		if (this._activated == false) {
			this._activated = true;
			loadGraphic(this._activated_img, false, this._side_length, this._side_length, true);
			setPosition(this._col, this._row);
		}
		else {
			this._activated = false;
			loadGraphic(this._inactivated_img, false, this._side_length, this._side_length, true);
			setPosition(this._col, this._row);
		}
	}

	public function getActivationStatus():Bool {
		return this._activated;
	}
}
