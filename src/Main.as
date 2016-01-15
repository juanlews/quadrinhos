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
		private var _botoes:Botoes;
		
		public function Main() 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_botoes = new Botoes();
			_botoes.addEventListener("começar", comecaQuadro);
			_botoes.addEventListener("terminar", terminaquadro);
			_botoes.addEventListener("exportar", exportarXML);
			addChild(_botoes);
			_botoes.reposicione();
				
		}
		
		private function comecaQuadro(evento:Event):void {
			trace ('começando a desenhar o quadro');
		}
		private function terminaquadro(evento:Event):void{
			
			trace('termina quadro');
		}
		private function exportarXML(evento:Event):void{
			trace('exportando xml');
			
		}
		
		private function deactivate(e:Event):void 
		{
			
		}
		
	}
	
}