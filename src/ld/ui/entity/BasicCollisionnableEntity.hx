package ld.ui.entity;
import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.data.StatedAnimationData;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;
import openfl.geom.Point;
import ld.ui.screen.PlayScreen;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicCollisionnableEntity extends CollisionableEntity
{

	public function new(statedAnimationData: StatedAnimationData, collisionMap  : Array<Array<Bool>>) 
	{
		super(statedAnimationData);
		this.addProcess(new GridBoxCollisionProcess(this, PlayScreen.TILE_WIDTH, PlayScreen.TILE_HEIGHT, collisionMap));
	}
	
	public function getCurrentTile() : {x: Int, y: Int} {
		return {x: Std.int((this.getXx() + 12)/ PlayScreen.TILE_WIDTH), y:Std.int((this.getYy() + 12) / PlayScreen.TILE_HEIGHT)};
	}
	
}