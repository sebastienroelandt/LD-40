package src.ld.ui.entity;

import ld.generator.loot.LootType;
import ld.ui.entity.BasicCollisionnableEntity;
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
class Player extends BasicCollisionnableEntity
{
	private static var PLAYER_SPEED		= 1;
	private static var PLAYER_FRICTION	= 0.7;
	
	public static var GET_LOOT_EVENT = "GET_LOOT_EVENT";
	
	private var lootMap		: Array<LootGroup>;
	private var currentLoot	: Map<LootType, Int>;
	private var lootChange : Bool;

	public function new(collisionMap  : Array<Array<Bool>>) 
	{
		super(GameController.assets.getStatedAnimationData("player"), collisionMap);
		
		this.addProcess(new FrictionProcess(this, PLAYER_FRICTION, PLAYER_FRICTION));
		this.addProcess(new MoveProcess(this, PLAYER_SPEED));
		
		this.setYy(90);
		this.setXx(90);
		this.currentLoot = new Map<LootType, Int>();
		this.lootChange = false;
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
		lootChange = true;
		lootMap.push(loot);
	}
	
	public function getCurrentLoot() : Map<LootType, Int> {
		return this.currentLoot;
	}
	
	public function hasLootChange() : Bool {
		var lootChangeTemp = lootChange;
		//lootChange = false;
		return lootChangeTemp;
	}
	
}