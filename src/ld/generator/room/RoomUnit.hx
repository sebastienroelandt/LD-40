package ld.generator.room;

/**
 * ...
 * @author Sebastien roelandt
 */
class RoomUnit
{
	private var id					: Int;
	
	private var connectedUpTo		: RoomUnit;
	private var connectedDownTo		: RoomUnit;
	private var connectedLeftTo		: RoomUnit;
	private var connectedRightTo	: RoomUnit;

	public function new(id : Int) 
	{
		this.id = id;
		this.connectedUpTo = null;
		this.connectedDownTo = null;
		this.connectedLeftTo = null;
		this.connectedRightTo = null;
	}
	
	public function setId(id : Int) {
		this.id = id;
	}

	public function getId() : Int {
		return this.id;
	}

	public function setConnectedUpTo(connectedUpTo : RoomUnit) {	
		this.connectedUpTo = connectedUpTo;
	}	
		
	public function getConnectedUpTo() : RoomUnit {	
		return this.connectedUpTo;
	}	

	public function setConnectedDownTo(connectedDownTo : RoomUnit) {	
		this.connectedDownTo = connectedDownTo;
	}	
		
	public function getConnectedDownTo() : RoomUnit {	
		return this.connectedDownTo;
	}	

	public function setConnectedLeftTo(connectedLeftTo : RoomUnit) {	
		this.connectedLeftTo = connectedLeftTo;
	}	
		
	public function getConnectedLeftTo() : RoomUnit {	
		return this.connectedLeftTo;
	}	

	public function setConnectedRightTo(connectedRightTo : RoomUnit) {	
		this.connectedRightTo = connectedRightTo;
	}	
		
	public function getConnectedRightTo() : RoomUnit {	
		return this.connectedRightTo;
	}	
}