package ld.generator.loot;

import lib.sro.layers.DrawableLayer;
import lib.sro.ui.impl.BasicUI;
import openfl.display.Sprite;
import openfl.text.TextField;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class LootPopup extends BasicUI
{
	private var textsPopup		: Array<TextField>;
	private var background		: Sprite;
	private var lootRequested   : Bool;

	public function new(loots: Map<LootType, Int>, lootGroup: LootGroup) 
	{
		super();
		
		textsPopup = new Array<TextField>();
		for (lootType in Type.allEnums(LootType)) {
			if (lootGroup.getLootsList().exists(lootType)) {
				var textPopup = Text.createText("fonts/AAAA.TTF", 16);
				textPopup.x = lootGroup.getCenterX() - 50;
				textPopup.y = lootGroup.getCenterY() - 50;
				textPopup.text = lootType + " [" + lootGroup.getLootsList().get(lootType) + "]";
				textsPopup.push(textPopup);
				this.addChild(textPopup);
			}
		}
		
		background = new Sprite();		
		background.graphics.beginFill(0x271308);
		background.graphics.drawRect(0, 0, 100, 30);
		background.graphics.endFill();
		background.alpha = 0.7;
		this.addChild(background);
		
		lootRequested = false;
		changeVisibility(false);
	}
	
	public function changeVisibility(isVisible: Bool) {
		//On affiche le loot que s'il n'est pas deja recupéré
		if (!lootRequested) {
			this.getSprite().visible = isVisible;
		}
	}
	
	public function setLootRequested(isVisible: Bool) {
		lootRequested = true;
		this.getSprite().visible = false;
	}
	
}