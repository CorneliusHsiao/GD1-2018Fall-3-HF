package;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxG.keys;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.*;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PlayStateLv1 extends FlxState
{
	var da_player : Player;
	var da_map : TiledMap;
	var da_walls : FlxTilemap;
	var guards : FlxTypedGroup<Guard>;
	var mirrors : FlxTypedGroup<Mirror>;
	var pg = new PuzzleGrid(32, 32, 32, 0, 0);
	var gemActivated = false;
	var target : Target;
	var entrance : Gate;
	var exit : Gate;
	override public function create():Void
	{
		// Scene Fade-in Animation
		FlxG.camera.fade(FlxColor.BLACK, .33, true);

		guards = new FlxTypedGroup<Guard>();
		mirrors = new FlxTypedGroup<Mirror>();
		da_player = new Player();
		da_map = new TiledMap(AssetPaths.TestMap2__tmx);
		da_walls = new FlxTilemap();
		// *** 1 *** Set position of Target, Entrance and Exit
		target = new Target(550,260,32,"assets/images/Crystal.png");
		entrance = new Gate(200,-160,"Entrance",32,"assets/images/EntranceOpen.png","assets/images/EntranceClose.png");
		exit = new Gate(500,870,"Exit",32,"assets/images/ExitClose.png","assets/images/ExitOpen.png");
		
		// we put "Layer1" in the getLayer function because the map(wall & floor) layer in
		// test map is named "Layer1". 
		//
		// should be changed if the map layer have another name.
		
		da_walls.loadMapFromArray(cast(da_map.getLayer("Layer1"), TiledTileLayer).tileArray,
		   da_map.width, da_map.height, AssetPaths.MapTileSet__png, da_map.tileWidth, da_map.tileHeight, 1,1,16);
		da_walls.follow();
		for(i in 1...12){
			da_walls.setTileProperties(i, FlxObject.NONE);
		}
		//da_walls.setTileProperties(2, FlxObject.NONE);
		//da_walls.setTileProperties(3, FlxObject.ANY);	
		
		da_walls.offset.set(128, 0);
		add(da_walls);
		
		// make sure player, mirrors and guards have their own layers,
		// and the items in the layers are named correctly
		// (as required in the placeEntities function)
		// layers should also be named according to the following code
		// reading spawn location of player
		
		var tmpMap_p : TiledObjectLayer = cast da_map.getLayer("player");
		for(e in tmpMap_p.objects){
			placeEntities(e.type, e.xmlData.x);
		}
		
		
		
		/* 
		
			commented out this part because the test map doesn't have
			mirror and guard layers, and attempting to read those layers
			would cause runtime exceptions
		
			should work fine w/ maps having those two layers
		*/	
		// reading position of mirrors
		var tmpMap_m : TiledObjectLayer = cast da_map.getLayer("mirrors");
		for(e in tmpMap_m.objects){
			placeEntities(e.type, e.xmlData.x);
		}
		
		/*
		//position of guards
		var tmpMap_g : TiledObjectLayer = cast da_map.getLayer("guards");
		for(e in tmpMap_g.objects){
			placeEntities(e.type, e.xmlData.x);
		}
		*/
		
		
		//da_player = new Player(100,100);
		FlxG.camera.follow(da_player, NO_DEAD_ZONE, 1);
		pg.setPositionForAllObjects();
		add(mirrors);
		add(da_player);
		add(guards);
		add(target);
		add(entrance);
		add(exit);
	}

	override public function update(elapsed:Float):Void
	{
		
		//press esc to return to menu
		if(FlxG.keys.pressed.ESCAPE){
			FlxG.switchState(new MenuState());
		}
		
		//collide detection
		//player hits wall
		FlxG.collide(da_player, da_walls);

		//guards hit wall
		FlxG.collide(guards, da_walls);

		//player hits guards
		FlxG.collide(da_player, guards); //Why do we have this?
		FlxG.overlap(da_player, guards, playerTouchGuard);

		//player hits mirrors
		FlxG.overlap(da_player, mirrors, playerTouchMirror);
		
		//guard hit mirrors (?)
		FlxG.collide(guards, mirrors);

		// Player hits Target
		FlxG.overlap(da_player, target, playerTouchTarget);
		if (target.getActivateExitFlag()) {
			exit.activate();
		}

		// Player hits Entrance
		FlxG.overlap(da_player, entrance, playerTouchEntrance);

		// Player hits Exit
		FlxG.overlap(da_player, exit, playerTouchExit);
		
		for (guard in guards)
		{
			guard.update(elapsed);
		}
		
		super.update(elapsed);

		// Maintain positions of Target, Entrance, and Exit
		target.updatePosition();
		entrance.updatePosition();
		exit.updatePosition();
		// Update activation status of target from gemActivated
		target.setActivationStatus(gemActivated);

	}
	function placeEntities(entityName:String, entityData:Xml):Void
	{
	     var x : Float = Std.parseFloat(entityData.get("x"));
	     var y : Float = Std.parseFloat(entityData.get("y"));
		 
		 // the player item should be named player
		 // same for mirror and guard items
		 
		if (entityName == "player")
		{
			da_player.x = x;
			da_player.y = y;
		}
		else if(entityName == "mirror"){
			var m = new Mirror(x, y);
			mirrors.add(m);
			pg.addObjectToGridLocation(Std.int(Std.int(x) / 32), Std.int(Std.int(y) / 32), m);
			//need an extra parameter for the direction of the mirror.
		}
		else if(entityName == "guard"){
			var g = new Guard(x, y);
			guards.add(g);
			//need to get path data for the guards.
		}
		else if(entityName == "case"){
			//add case and gem
		}
	}
	function playerTouchGuard(p : Player, g : Guard):Void{
		// Scene Fade-out animation
		FlxG.camera.fade(FlxColor.BLACK,.33, false, function() {
		    FlxG.switchState(new LoseState());
		});
	}
	function playerTouchMirror(p : Player, m : Mirror):Void{
		if(FlxG.keys.justPressed.SPACE){
			m.flip();
			var lbd = pg.getDataForLightBeam(0, 0, 0, 0, 1); //change to start and end points of beam and initial direction of beam.
			if (lbd.didContactGem && !gemActivated)
			{
				gemActivated = true;
			}
		}
		FlxObject.separate(p, m);
	}
	function playerTouchTarget(p : Player, t : Target):Bool{
		if (t.getActivationStatus()) {
			// Hide Target (still reusable at stage)
			t.kill();
			// Set flag to activate Exit
			t.setActivateExitFlag(true);
			// returned value will activate Exit in Update function
			return true;
		}
		else {
			FlxObject.separate(p, t);
			// Maintain position of Target
			t.updatePosition();
			return false;
		}
	}
	function playerTouchExit(p : Player, g : Gate):Void{
		if (g.getActivationStatus()) {
			// Scene Fade-out animation
			FlxG.camera.fade(FlxColor.BLACK,.33, false, function() {
			    FlxG.switchState(new PlayStateLv2());
			});
			//FlxG.switchState(new PlayStateLv2());
		}
		else {
			FlxObject.separate(p, g);
			// Maintain position of Gate
			g.updatePosition();
		}
	}
	function playerTouchEntrance(p : Player, g : Gate):Void{
		if (g.getActivationStatus()) {
			FlxObject.separate(p, g);
			// Maintain position of Gate
			g.updatePosition();
		}
		else {
			g.activate();
			// Maintain position of Gate
			g.updatePosition();
		}
	}
}
	

