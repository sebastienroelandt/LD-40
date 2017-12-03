package ld.core;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import lib.sro.data.StatedAnimationData;
import lib.sro.core.ResourcesLoader;
import lib.sro.core.ResourcesStorage;


/**
 * ...
 * @author Sebastien roelandt
 */
class MyResourcesLoader
{
	public static function load(rs:ResourcesStorage) {
			
		var tileset = Assets.getBitmapData("img/tilemap.png");
		var tilesetSplited = ResourcesLoader.splitToBitmapData(tileset, 0, 0, 32, 32, 4, 1);
		rs.addTileset("tileset", tilesetSplited);
		
		var player = new StatedAnimationData("player"); 
		var playerTileset = Assets.getBitmapData("img/player.png"); 
		player.addLinearFrames("idle", ResourcesLoader.splitToBitmapData(playerTileset, 0, 0, 25, 25, 4, 1), 100);
		player.setLoop("idle", true); 
		player.addLinearFrames("move_up", ResourcesLoader.splitToBitmapData(playerTileset, 0, 0, 25, 25, 4, 1), 100);
		player.setLoop("move_up", true); 
		player.addLinearFrames("move_right", ResourcesLoader.splitToBitmapData(playerTileset, 0, 1*25, 25, 25, 4, 1), 100);
		player.setLoop("move_right", true); 
		player.addLinearFrames("move_down", ResourcesLoader.splitToBitmapData(playerTileset, 0, 2*25, 25, 25, 4, 1), 100);
		player.setLoop("move_down", true); 
		player.addLinearFrames("move_left", ResourcesLoader.splitToBitmapData(playerTileset, 0, 3*25, 25, 25, 4, 1), 100);
		player.setLoop("move_left", true); 
		rs.addStatedAnimationData("player", player); 
		
		var basicMonster = new StatedAnimationData("basicMonster"); 
		var basicMonsterTileset = Assets.getBitmapData("img/basic_monster.png"); 
		basicMonster.addLinearFrames("idle", ResourcesLoader.splitToBitmapData(basicMonsterTileset, 0, 0, 25, 25, 4, 1), 100);
		basicMonster.setLoop("idle", true); 
		basicMonster.addLinearFrames("move_up", ResourcesLoader.splitToBitmapData(basicMonsterTileset, 0, 0, 25, 25, 4, 1), 100);
		basicMonster.setLoop("move_up", true); 
		basicMonster.addLinearFrames("move_right", ResourcesLoader.splitToBitmapData(basicMonsterTileset, 0, 1*25, 25, 25, 4, 1), 100);
		basicMonster.setLoop("move_right", true); 
		basicMonster.addLinearFrames("move_down", ResourcesLoader.splitToBitmapData(basicMonsterTileset, 0, 2*25, 25, 25, 4, 1), 100);
		basicMonster.setLoop("move_down", true); 
		basicMonster.addLinearFrames("move_left", ResourcesLoader.splitToBitmapData(basicMonsterTileset, 0, 3*25, 25, 25, 4, 1), 100);
		basicMonster.setLoop("move_left", true); 
		rs.addStatedAnimationData("basicMonster", basicMonster); 
	}
	
}