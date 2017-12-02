package ld.generator.loot;

import lib.sro.engine.CollisionBox;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.impl.BoxCollisionProcess;
import lib.sro.core.GameController;
import lib.sro.layers.DrawableLayer;
import src.ld.ui.entity.Player;

/**
 * ...
 * @author Sebastien roelandt
 */
class LootGroup extends BoxCollisionProcess
{
	private var layer				: DrawableLayer;
	private var lootsList			: Map<LootType, Int>;
	private var centerX				: Int;
	private var centerY 			: Int;
	private var lootPopup			: LootPopup;
	
	private var isPopupVisible		: Bool;
	private var timePopupVisible	: Float;

	public function new(player: Player, x: Int, y: Int, height: Int, 
		width: Int, lootsList: Map<LootType, Int>, layer: DrawableLayer)
	{		
		super(player, new CollisionBox(x, y, height, width), false);
		this.lootsList = lootsList;
		this.centerX = x + Std.int(width / 2);
		this.centerY = y + Std.int(height / 2);
		this.lootPopup = new LootPopup(lootsList, this);
		this.layer = layer;
		layer.add(lootPopup);
		player.addLootOnMap(this);
	}
	
	public function getLootsList() : Map<LootType, Int> {
		return lootsList;
	}
	
	override public function beforeEntityUpdate(delta:Float):Void 
	{
		super.beforeEntityUpdate(delta);
		if (isPopupVisible) {
			timePopupVisible += delta;
			if (timePopupVisible > 300) { //Le joueur s'est éloigné depuis 1sec
				isPopupVisible = false;
				lootPopup.changeVisibility(false);
			}
		}
	}
	
	override public function onCollision() {
		super.onCollision();
		lootPopup.changeVisibility(true);
		isPopupVisible = true;
		timePopupVisible = 0;
	}
	
	public function getLootRequested() : Map<LootType, Int>{
		var loot : Map<LootType, Int> = null;
		if (isPopupVisible) {
			loot = lootsList;
			lootsList = null;
			lootPopup.setLootRequested(true);
			layer.remove(lootPopup);
		}
		return loot;
	}
	
	public function getCenterX() :Int {
		return centerX;
	}
	
	public function getCenterY() :Int {
		return centerY;
	}
	
}