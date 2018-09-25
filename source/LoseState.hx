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
	
	override public function create():Void
	{
		_playButton = new FlxButton(20,20,"Play Again", clickPlay);
		add(_playButton);
		loadGraphic("assets/images/YouLose.png", false, 600, 300, true);
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
