package ld.core;

import ld.ui.screen.PlayScreen;
import lib.sro.core.GameController;
import lib.sro.core.ResourcesStorage;
import lib.sro.screen.Screen;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.impl.TiledMapUI;
import lib.sro.core.Bresenham;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	public function new()
	{
		var assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		GameController.assets = assets;
		
		super();
		
		this.addScreen(new PlayScreen(this));
		
		start();
	}
	
	public override function update() {
		super.update();
	}
}