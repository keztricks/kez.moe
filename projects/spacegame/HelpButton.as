package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class HelpButton extends MovieClip{

		public function InformationButton() {
			stage.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			stage.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseOverHandler(evt:MouseEvent) {
			MovieClip(this).gotoAndStop(2);
		}
		
		private function mouseOutHandler(evt:MouseEvent) {
			MovieClip(this).gotoAndStop(1);
		}
		
		private function mouseDownHandler(evt:MouseEvent) {
			MovieClip(this.parent).gotoAndStop(4);
		}
	
}
