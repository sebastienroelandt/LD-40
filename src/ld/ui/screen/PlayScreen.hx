package ld.ui.screen;

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


/**
 * ...
 * @author Sebastien roelandt
 */
class PlayScreen extends Screen
{
	private var screenController 	: 	ScreenController;
	
	private var playlayer 			:	CameraLayer;
	private var debutPoint			:	VisualPoint;
	
	private var newPlayer			: 	ICollisionableEntity;
	
	private var generator			:	ParticlesGenerator;
	
	public function new(screenController:ScreenController) 
	{
		super();
		
		this.screenController = screenController;
		this.playlayer = new CameraLayer(200,200,8);
		
		var map = new TiledMapUI(GameController.assets.getTileset("tileset"), [[0, 0, 0, 1], [0, 1, 0, 1], [1, 1, 0, 0], [1, 0, 0, 0]], [1]);
		
		//var box = new CollisionBox(0, 0, 10, 10);
		
		var polygon = [new Point(0.1, 0.1), new Point(0.2, 110.1), new Point(210.2, 210.3), new Point(10.4, 0.3)];
		var collisionPolygon = new CollisionPolygon(polygon);
		
		newPlayer = new CollisionableEntity(GameController.assets.getStatedAnimationData("head"));
		//newPlayer.addProcess(new GravityProcess(newPlayer));
		newPlayer.addProcess(new FrictionProcess(newPlayer));
		newPlayer.addProcess(new MoveProcess(newPlayer));
		//newPlayer.addProcess(new GridBoxCollisionProcess(newPlayer, 50, 50, map.getCollisionGrid()));
		//newPlayer.addProcess(new BoxCollisionProcess(newPlayer, box));
		newPlayer.addProcess(new PolygonCollisionProcess(newPlayer, collisionPolygon));
		//newPlayer.addProcess(new TransparencyEffectProcess(newPlayer, 1000));
		//newPlayer.addProcess(new RotationEffectProcess(newPlayer, 10000));
		newPlayer.addProcess(new LookAtRotationEffectProcess(newPlayer));
		
		newPlayer.setYy(50);
		newPlayer.setXx(50);
		
		playlayer.add(map);
		playlayer.add(newPlayer);
		
		playlayer.add(new VisualPolygon(polygon));
		
		this.add(playlayer);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		/*if (Mouse.isBeginClick()) {
			playlayer.setTarget(Mouse.getXY());
		}*/
		
		playlayer.setTarget(new Point(newPlayer.getXx(), newPlayer.getYy()));
		//var cell = player.getCell(0);
		//debutPoint.x = cell.getVisualPosition().x + 32;
		//debutPoint.y = cell.getVisualPosition().y + 32;
		
		//var mouseXY = Mouse.getXY();
		//generator.setPosition(mouseXY);
	}
}