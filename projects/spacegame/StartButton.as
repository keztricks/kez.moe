package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	//Manages the button to start the game.
	public class StartButton extends MovieClip{

		public function StartButton() {
			MovieClip(this).addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			MovieClip(this).addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			MovieClip(this).addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseOverHandler(evt:MouseEvent) {
			MovieClip(this).gotoAndStop(2);
		}
		
		private function mouseOutHandler(evt:MouseEvent) {
			MovieClip(this).gotoAndStop(1);
		}
		
		private function mouseDownHandler(evt:MouseEvent) {
			MovieClip(this.parent).gotoAndStop(2);

		}

	}
	
}
