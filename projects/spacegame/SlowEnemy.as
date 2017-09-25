package  {
	
	import flash.display.MovieClip;
	
	//COntrolls one of the games enemies.
	public class SlowEnemy extends MovieClip {
		
		private var verticalChange:int;
		private var pointsValue:int;
		private var multiplier:Number;

		public function SlowEnemy(speedMultiplier:Number) {
			this.x = 600;
			this.y = Math.floor(Math.random() * 400) + 13;
			pointsValue = 50;
			multiplier = speedMultiplier;
		}
		
		//Updates the location and points alue of the enemy.
		public function UpdatePosition() {
			verticalChange = Math.floor(Math.random() * 10) - 5;
			this.x -= 3 * multiplier;
			this.y += verticalChange;
			if (pointsValue > 25) {
				pointsValue -= 1;
			}
		}
		
		//Returns the enemies points value.
		public function getValue():int {
			return pointsValue;
		}

	}
	
}
