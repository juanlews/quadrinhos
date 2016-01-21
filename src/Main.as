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
	import caurina.transitions.Tweener;
	
	
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
		
		private var _contador:Contador = new Contador();
	    	
		public function Main()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			pg = new Pagina();
			
			envio = new URLVariables();
			
			_urlLoader = new URLLoader();
			_request = new URLRequest("http://192.168.25.159/appserver/listaimgs.php");
			
			
			
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
			
			
			envio['nomepasta'] = 'quadrinhos';
			envio['valida'] = 'asdfg';
		
			_request.data = envio;
			
			_urlLoader.load(_request);
			
			stage.addEventListener(Event.RESIZE, virou);
		
			_botoes.y = stage.stageHeight;
			
			Tweener.addTween(_botoes, { y:stage.stageHeight - _botoes.height, time:3 } );
			
			pg.addEventListener("carregou", anima);
			
			trace ('contador', _contador.valor);
			
			Tweener.addTween(_contador, { valor:10, time:5, onComplete:fimContador } );
			
		}
		
		private function fimContador():void {
			trace ('contador terminou', _contador.valor)
		}
		
		private function anima(evento:Event):void {
			var xfinal:Number = 0;
			var yfinal:Number = pg.y;
			var wFinal:Number = pg.width;
			var hFinal:Number = pg.height;
			
			pg.y = stage.stageHeight / 2;
			pg.x = stage.stageWidth / 2;
			pg.rotation = 30;
			
		    pg.width = 0;
			pg.height = 0;
			
			Tweener.addTween(pg, { width:wFinal, height:hFinal, x:xfinal, y:yfinal, rotation:0, time:0.5, transition:"easeInOutBack" } );
			
			
			trace ('carregado:', pg.nomedaAtual());
		}
		private function recebeu(evento:Event):void
		{
			
			_urlLoader.removeEventListener(Event.COMPLETE, recebeu);
			
			var variaveis:URLVariables = new URLVariables(_urlLoader.data);
		
			if (variaveis['erro'] == null)
			{
				trace('resposta do servidor mal formatada');
			}
			else
			{
				if (variaveis['erro'] == '-1')
				{
					trace('erro de validação no servidor');
				}
				else if (variaveis['erro'] == '1')
				{
					trace('pasta não encontrada no servidor');
				}
				else
				{
					var arquivos:Array = String(variaveis['nomes']).split(',');
				//	trace('arquivos encontrados:');
					
				    trace("fora da funçao" + arquivos);
					
					trace ('carregando: ' + 'http://192.168.25.159/appserver/' + envio['nomepasta'], arquivos);
					
					pg.load('http://192.168.25.159/appserver/'+envio['nomepasta']+'/', arquivos);

					
					
				}
			}
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
				envio = new URLVariables();
				
				_request.url = 'http://192.168.25.159/appserver/salvaxml.php';
				
			trace(	envio['nomearquivo'] = pg.nomedaAtual().substr(0,-4));
				envio['xmlconteudo'] = pg.criarXML();
				
				_request.data = envio;
				
				_urlLoader.addEventListener(Event.COMPLETE, terminou);
				_urlLoader.load(_request);
				
				pg.proxima();
				
			
			}
			
			private function terminou(evento:Event):void {
				_urlLoader.removeEventListener(Event.COMPLETE, terminou);
				trace ('salvou o xml no servidor');
			}
			
			private function deactivate(e:Event):void
			{
			
			}
		
		}
	
	}