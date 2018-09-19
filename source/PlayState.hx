package;

import flixel.FlxState;

class PlayState extends FlxState
{
	
	
	override public function create():Void
	{

		super.create();

		var grid = new PuzzleGrid(20, 20, 32, 160, 0);
		grid.getDataForLightBeam(0, 0);
		var mirror = new Mirror(5, 5, 1);
		grid.addObjectToGridLocation(5, 5, mirror);
		add(mirror);
		grid.setPositionForAllObjects();
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
