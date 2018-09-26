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
	var _activateExitFlag:Bool = false;
	public var caseSprite = new FlxSprite(0, 0);

	public function new(?row:Int=0, ?col:Int=0, ?side_length:Int=0, ?inactivated_img:String="") {
		super();
		this._row = row;
		this._col = col;
		this._side_length = side_length;
		this._activated = false;
		this._inactivated_img = inactivated_img;

		loadGraphic(this._inactivated_img, false, _side_length, _side_length, true);
		setPosition(this._col, this._row);
		caseSprite.loadGraphic("assets/images/Case.png", false, 32, 32);
		caseSprite.setPosition(this._col, this._row);
		caseSprite.alpha = 0.7;
		//add(caseSprite);
	}

	override public function update(elapsed:Float):Void
 	{
     	super.update(elapsed);
 	}

	public function updatePosition():Void {
		setPosition(this._col, this._row);
	}

	public function getActivationStatus():Bool {
		return this._activated;
	}

	public function setActivationStatus(switchStatus:Bool):Void {
		this._activated = switchStatus;
		caseSprite.visible = !_activated;
	}

	public function setActivateExitFlag(?flag:Bool):Void {
		this._activateExitFlag = flag;
	}

	public function getActivateExitFlag():Bool {
		return this._activateExitFlag;
	}
}
