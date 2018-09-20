package;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxG.keys;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.*;


class PlayState extends FlxState
{
	var da_player : Player;
    var da_map : TiledMap;
    var da_walls : FlxTilemap;
	override public function create():Void
	{
		da_player = new Player();
		da_map = new TiledMap(AssetPaths.test_map__tmx);
		da_walls = new FlxTilemap();
		da_walls.loadMapFromArray(cast(da_map.getLayer("Layer1"), TiledTileLayer).tileArray,
		   da_map.width, da_map.height, AssetPaths.tiles__png, da_map.tileWidth, da_map.tileHeight, 1,1,3);
		da_walls.follow();
		da_walls.setTileProperties(2, FlxObject.NONE);
		da_walls.setTileProperties(3, FlxObject.ANY);	
		add(da_walls);
		var tmpMap : TiledObjectLayer = cast da_map.getLayer("player");
		for(e in tmpMap.objects){
			placeEntities(e.type, e.xmlData.x);
		}
		//da_player = new Player(100,100);
		FlxG.camera.follow(da_player, NO_DEAD_ZONE, 1);
		add(da_player);
	}

	override public function update(elapsed:Float):Void
	{
		
		//press esc to return to menu
		if(FlxG.keys.pressed.ESCAPE){
			FlxG.switchState(new MenuState());
		}
		//collide detection
		FlxG.collide(da_player, da_walls);
		super.update(elapsed);
	}
	function placeEntities(entityName:String, entityData:Xml):Void
	{
	     var x:Int = Std.parseInt(entityData.get("x"));
	     var y:Int = Std.parseInt(entityData.get("y"));
	     if (entityName == "player")
	     {
	         da_player.x = x;
	         da_player.y = y;
		 }
	}
}


