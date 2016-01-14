package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author
	 */
	public class Main extends Sprite
	{
		public var quadrinho1:Pagina;
		
		public function Main()
		{   
			quadrinho1 = new Pagina();
			quadrinho1.load();
			
			addChild(quadrinho1);
						
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				
		}
		
		private function deactivate(e:Event):void
		{
		
		}
	
	}

}