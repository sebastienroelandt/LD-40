package ld.ui.screen;

import ld.ui.light.LightMap;
import ld.ui.entity.BasicMonster;
import ld.ui.loot.InventoryLayer;
import lib.sro.debug.VisualPoint;
import lib.sro.debug.VisualPolygon;
import lib.sro.engine.CollisionBox;
import lib.sro.engine.CollisionPolygon;
import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.entity.impl.MovableEntity;
import lib.sro.entity.process.impl.BoxCollisionProcess;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.entity.process.impl.GravityProcess;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;
import lib.sro.entity.process.impl.LookAtRotationEffectProcess;
import lib.sro.entity.process.impl.PolygonCollisionProcess;
import lib.sro.entity.process.impl.RotationEffectProcess;
import lib.sro.entity.process.impl.TransparencyEffectProcess;
import lib.sro.layers.CameraLayer;
import lib.sro.layers.DrawableLayer;
import lib.sro.particles.BasicParticle;
import lib.sro.particles.ParticlesGenerator;
import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.ui.impl.TiledMapUI;
import lib.sro.ui.impl.ToggleButtonUI;
import lib.sro.ui.impl.ToggleButtonUI.ToggleButtonState;
import lib.sro.input.Mouse;
import lib.sro.core.Bezier.BezierType;
import lib.sro.entity.impl.BasicEntity;
import lib.sro.entity.process.impl.MoveProcess;
import openfl.geom.Point;
import src.ld.ui.entity.Player;
import ld.generator.room.MapGenerator;
import ld.generator.loot.LootGenerator;


/**
 * ...
 * @author Sebastien roelandt
 */
class PlayScreen extends Screen
{
	public static var TILE_WIDTH	= 32;
	public static var TILE_HEIGHT	= 32;
	
	public static var SCREEN_WIDTH	= 800;
	public static var SCREEN_HEIGHT = 600;
	
	private var screenController 	: 	ScreenController;
	
	private var playlayer 			:	CameraLayer;
	private var inventorylayers 	:	Array<DrawableLayer>;
	private var debutPoint			:	VisualPoint;
	
	private var newPlayer			: 	Player;
	
	private var generator			:	ParticlesGenerator;
	
	public function new(screenController:ScreenController) 
	{
		super();
		
		this.screenController = screenController;
		
		//Play
		this.playlayer = new CameraLayer(SCREEN_HEIGHT, SCREEN_WIDTH, 8);
		var map = new TiledMapUI(GameController.assets.getTileset("tileset"), 
			MapGenerator.initMap(),
			[0]);
		newPlayer = new Player(map.getCollisionGrid());
		playlayer.add(map);
		playlayer.add(newPlayer);

		LootGenerator.initLootMap([newPlayer], playlayer);
		
		var testMonster = new BasicMonster(GameController.assets.getStatedAnimationData("basicMonster"), [newPlayer], map.getCollisionGrid());
		testMonster.setXx(80);
		testMonster.setYy(8 * 32);
		playlayer.add(testMonster);
		
		playlayer.add(new LightMap(TILE_HEIGHT, TILE_WIDTH, 5 * 6 +1, 7 * 6 +1, [newPlayer], map.getCollisionGrid()));
		this.add(playlayer);
		playlayer.x = 100;
		
		//Inventaire
		var inventorylayer = new InventoryLayer(newPlayer);
		this.add(inventorylayer);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);

		playlayer.setTarget(new Point(newPlayer.getXx(), newPlayer.getYy()));
	}
}