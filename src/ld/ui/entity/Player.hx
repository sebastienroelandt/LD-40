package src.ld.ui.entity;

import ld.generator.loot.LootType;
import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.core.GameController;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.entity.process.impl.GridBoxCollisionProcess;
import lib.sro.entity.process.impl.MoveProcess;
import ld.ui.screen.PlayScreen;
import lib.sro.input.Keys;
import openfl.ui.Keyboard;
import ld.generator.loot.LootGroup;

/**
 * ...
 * @author Sebastien roelandt
 */
class Player extends CollisionableEntity
{
	private static var PLAYER_SPEED		= 1;
	private static var PLAYER_FRICTION	= 0.7;
	
	public static var GET_LOOT_EVENT = "GET_LOOT_EVENT";
	
	private var lootMap		: Array<LootGroup>;
	private var currentLoot	: Map<LootType, Int>;

	public function new(collisionMap  : Array<Array<Bool>>) 
	{
		super(GameController.assets.getStatedAnimationData("player"));
		
		this.addProcess(new FrictionProcess(this, PLAYER_FRICTION, PLAYER_FRICTION));
		this.addProcess(new MoveProcess(this, PLAYER_SPEED));
		
		this.addProcess(new GridBoxCollisionProcess(this, PlayScreen.TILE_WIDTH, PlayScreen.TILE_HEIGHT, collisionMap));
		
		this.setYy(90);
		this.setXx(90);
		this.currentLoot = new Map<LootType, Int>();
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (Keys.isClick(Keyboard.SPACE) && lootMap != null) {
			for (loot in lootMap) {
				var earnedLoot = loot.getLootRequested();
				if (earnedLoot != null) {
					for (lootType in Type.allEnums(LootType)) {
						//Si le loot existe dans les gains
						if (earnedLoot.exists(lootType)) {
							if (currentLoot.exists(lootType)) {
								currentLoot.set(lootType, currentLoot.get(lootType) 
									+ earnedLoot.get(lootType));
							} else {
								currentLoot.set(lootType, earnedLoot.get(lootType));
							}
						}
					}
				}
			}
		}
	}
	
	public function addLootOnMap(loot : LootGroup) {
		if (lootMap == null) {
			lootMap = new Array<LootGroup>();
		}
		lootMap.push(loot);
	}
	
}