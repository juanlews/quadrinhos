package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author
	 */
	
	public class Main extends Sprite
	{
		private var pg:Pagina;
		private var _botoes:Botoes;
		private var cl:Number;
		private var _request:URLRequest;
		private var _urlLoader:URLLoader;
		private var envio:URLVariables;
		
		public function Main()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			pg = new Pagina();
			
			envio = new URLVariables();
			
			_urlLoader = new URLLoader();
			_request = new URLRequest("http://192.168.25.159/appserver/salvaxml.php");
			_request.method = 'POST';
			_urlLoader.addEventListener(Event.COMPLETE, recebeu);
			
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
		
		private function recebeu(evento:Event):void
		{
			trace("carregou");
		}
		
		private function virou(evento:Event):void
		{
			
			_botoes.reposicione();
			pg.areaUtil = stage.stageHeight - _botoes.height;
			pg.ajuste();
		}
		
		private function comecaQuadro(evento:Event):void
		{
			trace('começando a desenhar o quadro');
			pg.comeca();
		}
		
		private function terminaquadro(evento:Event):void
		{
			trace('termina quadro');
			pg.termina();
		}
		
		private function exportarXML(evento:Event):void
		{
			trace('exportando xml');
			
			envio['nomearquivo'] = "87";
			envio['xmlconteudo'] = pg.criarXML();
			
			_request.data = envio;
			_urlLoader.load(_request);
		
		}
		
		private function deactivate(e:Event):void
		{
		
		}
	
	}

}