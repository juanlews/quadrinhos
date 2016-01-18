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
		private var  pg:Pagina;
		private var _botoes:Botoes;
		private var cl:Number;
		
		public function Main() 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			pg = new Pagina(); 
			
			_botoes = new Botoes();
			_botoes.addEventListener("começar", comecaQuadro);
			_botoes.addEventListener("terminar", terminaquadro);
			_botoes.addEventListener("exportar", exportarXML);
			
			addChild(pg);
			addChild(_botoes);
			
			_botoes.reposicione();
			
			pg.areaUtil = stage.stageHeight - _botoes.height;
			pg.load();
			
			stage.addEventListener(Event.RESIZE, virou);
							
		}
		
		private function virou(evento:Event):void{
			
			_botoes.reposicione();
			pg.areaUtil = stage.stageHeight - _botoes.height;
			pg.ajuste();
		}
		private function comecaQuadro(evento:Event):void {
			trace ('começando a desenhar o quadro');
			pg.comeca();
		}
		private function terminaquadro(evento:Event):void{
			trace('termina quadro');
			pg.termina();
		}
		private function exportarXML(evento:Event):void{
			trace('exportando xml');
			pg.criarXML();
			
		}
		
		private function deactivate(e:Event):void 
		{
			
		}
		
	}
	
}