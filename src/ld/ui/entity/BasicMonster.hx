package ld.ui.entity;
import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.data.StatedAnimationData;
import openfl.geom.Point;
import src.ld.ui.entity.Player;
import lib.sro.entity.impl.MovableEntity.MoveDirection;
import lib.sro.core.Bresenham;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicMonster extends BasicCollisionnableEntity
{
	private static var MONSTER_SPEED	= 0.7;
	private static var MONSTER_FRICTION	= 0.7;
	
	private var players			: Array<Player>;
	private var target			: Player;

	private var centerX			: Int;
	private var centerY			: Int;
	
	private var collisionMap 	: Array<Array<Bool>>;
	
	public function new(statedAnimationData: StatedAnimationData, players: Array<Player>, collisionMap: Array<Array<Bool>>) 
	{
		super(statedAnimationData, collisionMap);
		this.players = players;
		this.centerX = 12;
		this.centerY = 12;
		this.direction = MoveDirection.Up;
		this.collisionMap = collisionMap;
		this.addProcess(new FrictionProcess(this, MONSTER_FRICTION, MONSTER_FRICTION));
	}
	
	override public function entityUpdate(delta:Float) 
	{
		super.entityUpdate(delta);
		
		if (target == null) {
			target = getTarget();
		}
		
		var mouvement = updatePosition(target);
		if (mouvement != null) {
			updateDirection(mouvement);
		}
	}
	
	private function getTarget() : Player {
		var currentTilePosition = getCurrentTile();
		var eyesposition = getEyesPosition();
		eyesposition = { x: eyesposition.x + currentTilePosition.x, y: eyesposition.y + currentTilePosition.y };
		
		var playerTarget 			: Player = null;
		var playerTargetDistance 	: Int = 0;
		for (player in players) {
			var currentPlayerPosition = player.getCurrentTile();
			
			if (Bresenham.isInFieldOfVision(currentTilePosition.x, currentTilePosition.y, eyesposition.x, 
				eyesposition.y, currentPlayerPosition.x, currentPlayerPosition.y, 10, 90, collisionMap)) {
				if (playerTarget == null) {
					playerTarget = player;
				} else {
					//TODO
				}
			}
		}
		return playerTarget;
	}
	
	private function updatePosition(playerTarget:Player) : Point {
		var mouvement = null;
		if (playerTarget != null) {
			mouvement = Bresenham.getMouvement(MONSTER_SPEED, {x: this.getXx(), y: this.getYy()}, {x: playerTarget.getXx(), y: playerTarget.getYy()});
			dx += mouvement.x;
			dy += mouvement.y;
		}
		return mouvement;
	}
	
	private function updateDirection(mouvement : Point) {
		var isUp = false;
		var upDownValue : Float;
		var isLeft = false;
		var leftRightValue : Float;
		if (mouvement.y > 0) {
			isUp = false;
			upDownValue = mouvement.y;
		} else {
			isUp = true;
			upDownValue = -mouvement.y;
		}
		if (mouvement.x > 0) {
			isLeft = false;
			leftRightValue = mouvement.x;
		} else {
			isLeft = true;
			leftRightValue = -mouvement.x;
		}
		
		if (upDownValue > leftRightValue) {
			// Mouvement haut/bas plus important
			if (isUp) {
				setNewDirection(MoveDirection.Up);
			} else {
				setNewDirection(MoveDirection.Down);
			}
		} else {
			// Mouvement gauche/droite
			if (isLeft) {
				setNewDirection(MoveDirection.Left);
			} else {
				setNewDirection(MoveDirection.Right);
			}
		}
	}
	
	private function setNewDirection(moveDirection: MoveDirection) {
		if (this.getDirection() != moveDirection) {
			this.setDirection(moveDirection);
			if (moveDirection == MoveDirection.Up) {
				this.change("move_up");
			} else if (moveDirection == MoveDirection.Down) {
				this.change("move_down");
			} else if (moveDirection == MoveDirection.Left) {
				this.change("move_left");
			} else if (moveDirection == MoveDirection.Right) {
				this.change("move_right");
			}
			
			
		}
	}
	
	private function getEyesPosition() : { x : Int, y: Int } {
		var position : {x : Int, y: Int} = null;
		if (direction == MoveDirection.Up) {
			position = { x : 0, y: -1 };
		} else if (direction == MoveDirection.Down) {
			position = { x : 0, y: 1 };
		} else if (direction == MoveDirection.Left) {
			position = { x : -1, y: 0 };
		} else if (direction == MoveDirection.Right) {
			position = { x : 1, y: 0 };
		}  
		return position;
	}
	
}