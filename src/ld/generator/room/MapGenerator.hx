package ld.generator.room;
import ld.generator.room.RoomUnit;
import ld.generator.room.SpecificRoom;



/**
 * ...
 * @author Sebastien roelandt
 */
class MapGenerator
{
	public static function initMap() : Array<Array<Int>> {
		//Generation
		var roomUnitMap = new Array<Array<RoomUnit>>();
		
		for (j in 0...7) {
			var roomUnitRow = new Array<RoomUnit>();
			for (i in 0...5) {
				var roomUnit = new RoomUnit(i + j * 5);
				roomUnitRow.push(roomUnit);
			}
			roomUnitMap.push(roomUnitRow);
		}
		
		//Connexion
		var nbConnexion = 0;
		while (nbConnexion < 7 * 5 - 1) {
			var x = Std.random(5); //Entre 0 et 4 inclu
			var y = Std.random(7); //Entre 0 et 6 inclu
			var direction = Std.random(4);
			var roomUnitA = roomUnitMap[y][x];
			if (direction == 0) { //Up
				y--;
			} else if (direction == 1) { //Down
				y++;
			} else if (direction == 2) { //Left
				x--;
			} else if (direction == 3) { //Right
				x++;
			}
			if (0 <= x && x < 5
				&& 0 <= y && y < 7) {
				
				var roomUnitB = roomUnitMap[y][x];
				if (roomUnitA.getId() != roomUnitB.getId()) {
					if (direction == 0) { //Up
						roomUnitA.setConnectedUpTo(roomUnitB);
						roomUnitB.setConnectedDownTo(roomUnitA);
					} else if (direction == 1) { //Down
						roomUnitA.setConnectedDownTo(roomUnitB);
						roomUnitB.setConnectedUpTo(roomUnitA);
					} else if (direction == 2) { //Left
						roomUnitA.setConnectedLeftTo(roomUnitB);
						roomUnitB.setConnectedRightTo(roomUnitA);
					} else if (direction == 3) { //Right
						roomUnitA.setConnectedRightTo(roomUnitB);
						roomUnitB.setConnectedLeftTo(roomUnitA);
					}
					//update all ids
					var newId = roomUnitA.getId();
					var oldId = roomUnitB.getId();
					for (a in 0...7) {
						for (b in 0...5) {
							var otherRoom = roomUnitMap[a][b];
							if (otherRoom.getId() == oldId) {
								otherRoom.setId(newId);
							}
						}
					}
					nbConnexion ++;
				}
			}
		}
		
		//Genere all walls
		var roomMap = new Array<Array<Int>>();
		
		for (j in 0...(7 * 6 + 1)) {
			var row = new Array<Int>();
			for (i in 0...(5 * 6 + 1)) {
				var tile = 1;
				if (i % 6 == 0 || j % 6 == 0) {
					tile = 0;
				}
				
				row.push(tile);
			}
			roomMap.push(row);
		}
		
		//On fait les portes de connexion simple
		for (j in 0...7) {
			for (i in 0...5) {
				var centrej = 3 + j * 6;
				var centrei = 3 + i * 6;
				var roomUnit = roomUnitMap[j][i];
				if (roomUnit.getConnectedUpTo() != null) {
					roomMap[centrej - 3][centrei] = 1;
				}
				if (roomUnit.getConnectedLeftTo() != null) {
					roomMap[centrej][centrei - 3] = 1;
				}
				if (roomUnit.getConnectedRightTo() != null) {
					roomMap[centrej][centrei + 3] = 1;
				}
				if (roomUnit.getConnectedLeftTo() != null) {
					roomMap[centrej + 3][centrei] = 1;
				}
			}
		}
		
		//On créé des grandes salles
		var bigRooms = new Array<SpecificRoom>();
		addRooms(bigRooms, Std.random(2) + 2, 2, 2);
		addRooms(bigRooms, Std.random(2) + 3, 1, 2);
		addRooms(bigRooms, Std.random(2) + 3, 2, 1);
		for (i in 0...bigRooms.length) {
			var newBigRoom = bigRooms[i];
			for (y in (newBigRoom.getY() * 6 + 1 )...((newBigRoom.getY() + newBigRoom.getHeight()) * 6)) {
				for (x in (newBigRoom.getX() * 6 + 1 )...((newBigRoom.getX() + newBigRoom.getWidth()) * 6)) {
					roomMap[y][x] = 1;
				}
			}
		}
		
		//On créé le mur exterieur
		for (x in 0...roomMap[0].length) {
			roomMap[0][x] = 0;
			roomMap[roomMap.length - 1][x] = 0;
		}
		
		for (y in 0...roomMap.length) {
			roomMap[y][0] = 0;
			roomMap[y][roomMap[0].length - 1] = 0;
		}
		
		return roomMap;
	}
	
	private static function addRooms(bigRooms: Array<SpecificRoom>, nbBigRoom : Int, width : Int, height : Int) {
		var initialNbRooms = bigRooms.length;
		var maxTry = 0;
		while (bigRooms.length - initialNbRooms < nbBigRoom && maxTry < 50) {
			var x = Std.random(4); //Entre 0 et 3 inclu
			var y = Std.random(6); //Entre 0 et 5 inclu
			var newBigRoom = new SpecificRoom(width, height, x, y);
			if (!isRoomCollision(newBigRoom, bigRooms)) {
				bigRooms.push(newBigRoom);
			}
			maxTry ++;
		}
	}
	
	private static function isRoomCollision(newRoom : SpecificRoom, all: Array<SpecificRoom>) {
		var ptsNewRoom = new Array<{x:Int, y:Int}>();
		
		for (y in newRoom.getY()...(newRoom.getY() + newRoom.getHeight())) {
			for (x in newRoom.getX()...(newRoom.getX() + newRoom.getWidth())) {
				ptsNewRoom.push( { x: x, y: y } );
			}
		}
		
		for (i in 0...all.length) {
			var oneRoom = all[i];
			var ptsOneRoom = new Array<{x:Int, y:Int}>();
			for (y in oneRoom.getY()...(oneRoom.getY() + oneRoom.getHeight())) {
				for (x in oneRoom.getX()...(oneRoom.getX() + oneRoom.getWidth())) {
					for (p in 0...ptsNewRoom.length) {
						if (ptsNewRoom[p].x == x && ptsNewRoom[p].y == y) {
							return true;
						}
					}
				}
			}
		}
		return false;
	}
	
}