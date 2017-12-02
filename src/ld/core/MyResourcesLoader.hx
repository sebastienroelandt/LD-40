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
		
		var body = new StatedAnimationData("body"); 
		var bodyTileset = Assets.getBitmapData("img/Body.png"); 
		body.addLinearFrames("move", ResourcesLoader.splitToBitmapData(bodyTileset, 0, 0, 64, 64, 4, 1),100); 
		body.setLoop("move", true); 
		rs.addStatedAnimationData("body", body); 
		
		var head = new StatedAnimationData("head"); 
		var headTileset = Assets.getBitmapData("img/Head.png"); 
		head.addLinearFrames("move", ResourcesLoader.splitToBitmapData(headTileset, 0, 0, 25, 25, 4, 1),100); 
		head.setLoop("move", true); 
		rs.addStatedAnimationData("head", head); 
		
		var toggleButtonBitmapData:BitmapData = Assets.getBitmapData("img/sound.png"); 
		var toggleButtons = ResourcesLoader.splitToBitmapData(toggleButtonBitmapData, 0, 0, 32, 32, 2, 1); 
		rs.addBitmapData("t1", toggleButtons[0]); 
		rs.addBitmapData("t2", toggleButtons[1]); 
		
		var tileset = Assets.getBitmapData("img/test_gridcollision.png");
		var tilesetSplited = ResourcesLoader.splitToBitmapData(tileset, 0, 0, 50, 50, 2, 1);
		rs.addTileset("tileset", tilesetSplited);
	}
	
}