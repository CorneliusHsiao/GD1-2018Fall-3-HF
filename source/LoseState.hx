package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;

class LoseState extends FlxState
{
	var _playButton : FlxButton;
	var _loseImage : FlxSprite;
	
	override public function create():Void
	{
		_playButton = new FlxButton(512,600,"Play Again", clickPlay);
		add(_playButton);
		_loseImage = new FlxSprite();
		_loseImage.loadGraphic("assets/images/YouLose.png", false, 1000, 500, true);
		add(_loseImage);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	function clickPlay():Void{
		FlxG.switchState(new MenuState());
	}
}
