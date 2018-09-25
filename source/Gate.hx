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
		"false": open gate for Entrance; closed gate for Exit
		"true": closed gate for Entrance; open gate for Entrance
	**/
	var _activated:Bool = false;
	var _inactivated_img:String = "";
	var _activated_img:String = "";

	public function new(?row:Int=0, ?col:Int=0, ?type:String="", ?side_length:Int=0, ?inactivated_img:String="", ?activated_img:String=""):Void {
		super();
		this._row = row;
		this._col = col;
		this._side_length = side_length;
		this._type = type;
		this._activated = false;
		this._inactivated_img = inactivated_img;
		this._activated_img = activated_img;

		loadGraphic(this._inactivated_img, false, _side_length, _side_length, true);
		setPosition(this._col, this._row);
	}

	override public function update(elapsed:Float):Void
 	{
     	super.update(elapsed);
 	}

	public function activate():Void {
		if (this._activated == false) {
			this._activated = true;
			loadGraphic(this._activated_img, false, this._side_length, this._side_length, true);
			setPosition(this._col, this._row);
		}
	}

	// This should not be called since player cannot drop Target
	public function inactivate():Void {
		if (this._activated == true) {
			this._activated = false;
			loadGraphic(this._inactivated_img, false, this._side_length, this._side_length, true);
			setPosition(this._col, this._row);
			trace("Warning: Gate " + this._type + " inactivated.");
		}
	}

	public function getActivationStatus():Bool {
		return this._activated;
	}

	public function updatePosition():Void {
		setPosition(this._col, this._row);
	}
}
