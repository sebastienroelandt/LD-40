package src.ld.ui.entity;

import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.core.GameController;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;
import lib.sro.entity.process.impl.MoveProcess;
import ld.ui.screen.PlayScreen;

/**
 * ...
 * @author Sebastien roelandt
 */
class Player extends CollisionableEntity
{
	private static var PLAYER_SPEED		= 1;
	private static var PLAYER_FRICTION	= 0.7;

	public function new(collisionMap  : Array<Array<Bool>>) 
	{
		super(GameController.assets.getStatedAnimationData("player"));
		
		this.addProcess(new FrictionProcess(this, PLAYER_FRICTION, PLAYER_FRICTION));
		this.addProcess(new MoveProcess(this, PLAYER_SPEED));
		
		this.addProcess(new GridBoxCollisionProcess(this, PlayScreen.TILE_WIDTH, PlayScreen.TILE_HEIGHT, collisionMap));
		
		this.setYy(50);
		this.setXx(50);
	}
	
}