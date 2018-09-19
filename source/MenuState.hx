package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
class MenuState extends FlxState
{
	var _playButton : FlxButton;
	
	override public function create():Void
	{
		_playButton = new FlxButton(20,20,"Play:", clickPlay);
		add(_playButton);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	function clickPlay():Void{
		FlxG.switchState(new PlayState());
	}
}
