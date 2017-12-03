package ld.ui.light;
import openfl.filters.BlurFilter;
import src.ld.ui.entity.Player;
import openfl.display.Sprite;
import lib.sro.ui.impl.BasicUI;
import lib.sro.core.Bresenham;

/**
 * ...
 * @author Sebastien roelandt
 */
class LightMap extends BasicUI
{
	private var shadowsLevel 	: Array<Array<Int>>;
	private var shadowsTiles 	: Array<Array<Sprite>>;
	
	private var players			: Array<Player>;
	private var lastPositions	: Array <{ x : Int, y: Int }>;	
	private var collisionMap	: Array<Array<Bool>>;

	public function new(tileHeight: Int, tileWidth: Int, nbWidth: Int, nbHeight: Int, players: Array<Player>, collisionMap: Array<Array<Bool>>) 
	{
		super();
		
		shadowsTiles = new Array<Array<Sprite>>();
		shadowsLevel = new Array<Array<Int>>();
		for (y in 0...nbHeight) {
			var shadowsTilesRow = new Array<Sprite>();
			var shadowsLevelRow = new Array<Int>();
			for (x in 0...nbWidth) {
				shadowsLevelRow.push(9);
				var shadowTile = new Sprite();	
				shadowTile.graphics.beginFill(0x000000);
				shadowTile.graphics.drawRect(tileWidth * x, tileHeight * y, tileWidth, tileHeight);
				shadowTile.graphics.endFill();
				shadowTile.alpha = 1;
				this.addChild(shadowTile);
				shadowsTilesRow.push(shadowTile);
			}
			shadowsTiles.push(shadowsTilesRow);
			shadowsLevel.push(shadowsLevelRow);
		}
		this.players = players;
		this.lastPositions = new Array<{x:Int, y:Int}>();
		this.collisionMap = collisionMap;
		this.filters = [new BlurFilter(65,65)];
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		for (i in 0...players.length) {
			var position = players[i].getCurrentTile();
			if (lastPositions.length > i) {
				var lastPosition = lastPositions[i];
				if (position.x != lastPosition.x || position.y != lastPosition.y) {
					updateLightFor(position, lastPosition);
					lastPositions[i] = position;
				}
			} else {
				updateLightFor(position, null);
				lastPositions.push(position);
			}
		}
	}
	
	private function updateLightFor(newPosition: {x: Int, y: Int} , lastPosition: {x: Int, y: Int} ) {
		//Reset total
		if (lastPosition != null) {
			for (j in (lastPosition.y - 10)...(lastPosition.y + 10)) {
				for (i in (lastPosition.x - 10)...(lastPosition.x + 10)) {
					if (i >= 0 && j >= 0 && i <= (5 * 6) && j <= (7 * 6)) {
						shadowsTiles[j][i].alpha = 1;
					}
				}
			}
		}
		
		///On applique le patern
		//On recupere tous les points
		var circlePts = Bresenham.getCircle(newPosition.x, newPosition.y, 8);
		//On recupere les points en prenant en compte les obstacles
		var pts = []; 
		for (i in 0...circlePts.length) {
			var tempPts : Array<{x:Int, y:Int}> = Bresenham.getLineBeforeCollision(newPosition.x, newPosition.y, circlePts[i].x, circlePts[i].y, collisionMap);
		
			//On dedoublonne
			for (k in 0...tempPts.length) { 
				var ok = true; 
				for (j in 0...pts.length) { 
					if (tempPts[k].x == pts[j].x  
						&& tempPts[k].y == pts[j].y) { 
						ok = false; 
						break; 
					} 
				}
				if (ok) { 
					pts.push({x:tempPts[k].x, y:tempPts[k].y}); 
				} 
			}
		}
		
		//On aplique le niveau de luminosite
		for (i in 0...pts.length) { 
			var strengh = ((Math.abs(newPosition.x - pts[i].x) + Math.abs(newPosition.y - pts[i].y)) / 9); 
			if (pts[i].x >= 0 && pts[i].y >= 0 && pts[i].x <= (5 * 6 ) && pts[i].y <= (7 * 6)) {
				shadowsTiles[pts[i].y][pts[i].x].alpha = strengh;
			}
		}
	}
}