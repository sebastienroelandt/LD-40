package ld.generator.loot;

import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.layers.DrawableLayer;
import src.ld.ui.entity.Player;

/**
 * ...
 * @author Sebastien roelandt
 */
class LootGenerator
{
	public static function initLootMap(players: Array<Player>, layerForPopupLoot: DrawableLayer): Array<LootGroup> {
		var loots = new Array<LootGroup>();
		for (p in 0...players.length) {
			var player = players[p];
			var loot = new LootGroup(player, 32, 32, 32, 32, [LootType.Stick => 2], layerForPopupLoot);
			player.addProcess(loot);
			loots.push(loot);
		}
		return loots;
	}
}