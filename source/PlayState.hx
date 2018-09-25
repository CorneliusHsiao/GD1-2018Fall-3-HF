package;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxG.keys;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.*;
import flixel.group.FlxGroup;


class PlayState extends FlxState
{
	var da_player : Player;
    var da_map : TiledMap;
    var da_walls : FlxTilemap;
	var guards : FlxTypedGroup<Guard>;
	var mirrors : FlxTypedGroup<Mirror>;
	override public function create():Void
	{
		guards = new FlxTypedGroup<Guard>();
		mirrors = new FlxTypedGroup<Mirror>();
		da_player = new Player();
		da_map = new TiledMap(AssetPaths.TestMap2__tmx);
		da_walls = new FlxTilemap();
		
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
		//add(guards);
		add(mirrors);
		add(da_player);
		guards.add(new Guard(0, 0));
		add(guards);
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
		FlxG.collide(da_player, guards);
		FlxG.overlap(da_player, guards, playerTouchGuard);
		//player hits mirrors
		FlxG.overlap(da_player, mirrors, playerTouchMirror);
		//FlxG.collide(da_player, mirrors);
		
		//guard hit mirrors (?)
		FlxG.collide(guards, mirrors);
		
		for (guard in guards)
		{
			guard.update(elapsed);
		}
		
		super.update(elapsed);

		

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
			mirrors.add(new Mirror(x, y));
		}
		else if(entityName == "guard"){
			var g = new Guard(x, y);
			g.setPosition(20, 20);
			guards.add(g);
	
		}
		else if(entityName == "case"){
			//add case and gem
		}
	}
	function playerTouchGuard(p : Player, g : Guard):Void{
		//something happens
	}
	function playerTouchMirror(p : Player, m : Mirror):Void{
		if(FlxG.keys.justPressed.SPACE){
			m.flip();
		}
		FlxObject.separate(p, m);
			//m.update();
			//}
	}
}
	

