package ld.ui.loot;
import lib.sro.layers.DrawableLayer;
import openfl.display.Sprite;
import src.ld.ui.entity.Player;
import openfl.text.TextField;
import ld.generator.loot.LootType;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class InventoryLayer extends DrawableLayer
{
	private var player 		: Player;
	
	private var loots 		: Array<TextField>;
	private var background	: Sprite;

	public function new(player : Player) 
	{
		super();
		
		this.player = player;
		this.background = new Sprite();
		background.graphics.beginFill(0x271308);
		background.graphics.drawRect(0, 0, 100, 600);
		background.graphics.endFill();
		this.addChild(background);
		
		this.loots = new Array<TextField>();
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (player.hasLootChange() == true) {
			var lootList = player.getCurrentLoot();
			var index = 0;
			for (lootType in Type.allEnums(LootType)) {
				if (lootList.exists(lootType)) {
					if (loots.length < index) {
						//Index existe !
						loots[index].text = lootType + " [" + lootList.get(lootType)  + "]";
					} else {
						var loot = Text.createText("fonts/AAAA.TTF", 16);
						loot.x = 20;
						loot.y = 50 + 50 * index;
						loot.text = lootType + " [" + lootList.get(lootType) + "]";
						loots.push(loot);
						this.addChild(loot);
					}
				}
			}
		}
	}
}