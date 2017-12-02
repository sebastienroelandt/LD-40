package ld.generator.room;

/**
 * ...
 * @author Sebastien roelandt
 */
class SpecificRoom
{
	private var width 		: Int;
	private var height		: Int;
	private var x			: Int;
	private var y			: Int;

	public function new(width : Int, height: Int, x: Int, y: Int) 
	{
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
	}

	public function setWidth(width : Int) {	
		this.width = width;
	}	
		
	public function getWidth() : Int {	
		return this.width;
	}	

	public function setHeight(height : Int) {	
		this.height = height;
	}	
		
	public function getHeight() : Int {	
		return this.height;
	}	

	public function setX(x : Int) {	
		this.x = x;
	}	
		
	public function getX() : Int {	
		return this.x;
	}	

	public function setY(y : Int) {	
		this.y = y;
	}	
		
	public function getY() : Int {	
		return this.y;
	}	

}