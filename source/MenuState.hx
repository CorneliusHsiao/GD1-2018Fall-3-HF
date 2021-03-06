package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.ui.*;
import flixel.FlxSprite;
class MenuState extends FlxState
{
	var _playButton : FlxButton;
	
	override public function create():Void
	{
		_playButton = new FlxButton(512,600,"Play:", clickPlay);
		add(_playButton);
		super.create();
		var text = new FlxSprite(0, 0);
		text.loadGraphic("assets/images/title.png", true, 1000, 500);
		add(text);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	function clickPlay():Void{
		FlxG.switchState(new TextState());
	}
}

