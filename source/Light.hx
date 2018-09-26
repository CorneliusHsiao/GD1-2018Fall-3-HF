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

/*
	class Light:
	
	Light and Light_Beam are separated classes.
*/
class Light extends FlxSprite {

	public function new(X:Float, Y:Float, dir: Int, type: Int, ?SimpleGraphic:FlxGraphicAsset){	
		super(X, Y, SimpleGraphic);
		moves = false;
		immovable = true;
		solid = true;
		width = 32;
		height = 32;
		if (type == 1)
		{
			loadGraphic("assets/images/LightBeam.png", true, 32, 32);
		}
		else
		{
			loadGraphic("assets/images/LightBeamL.png", true, 32, 32);
		}	
		angle = dir * 90;
		setPosition(X, Y);
	}
}
