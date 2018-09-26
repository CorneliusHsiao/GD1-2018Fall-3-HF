package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.FlxObject;

class Emitter extends FlxSprite {

	public function new(X:Float, Y:Float, ?SimpleGraphic:FlxGraphicAsset){	
		super(X, Y, SimpleGraphic);
		moves = false;
		immovable = true;
		solid = true;
		width = 32;
		height = 32;
		loadGraphic("assets/images/emitter.png", true, 32, 32);
		setPosition(X, Y);
	}
}
