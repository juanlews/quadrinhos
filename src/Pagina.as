package
{
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author
	 */
	public class Pagina extends Sprite
	{
		
		private var p:Shape;
		private var ponto:Vector.<Point>;
		private var quadro:Vector.<Quadro>;
		public var caminho:String;
		private var _loader:Loader;
		public var areaUtil:Number;
		private var _imagens:Array;
		private var _server:String;
		private var indice:int = 0;
		
		public function Pagina()
		{
			
			super();
			
			p = new Shape();
			ponto = new Vector.<Point>();
			quadro = new Vector.<Quadro>();
			_loader = new Loader();
			
		
		}
		
		public function load(server:String, img:Array):void
		{
			this._imagens = img;
			this._server = server;
			
			trace("dentro da função" + img + img.length);
			
			this._loader.load((new URLRequest(server + img[0] as String)));
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, falha);
			this._loader.contentLoaderInfo.addEventListener(Event.INIT, imagemCarregada);
			
		}
		public function nomedaAtual():String{
			return(this._imagens[this.indice]);
		}
		
		private function falha(evento:IOErrorEvent):void{
			trace('imagem não pode ser carregada');
		}
		public function imagemCarregada(evento:Event):void
		{
			//_loader.contentLoaderInfo.removeEventListener(Event.INIT, imagemCarregada);
			//_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, erroImagem);
			
			addChild(_loader);
			addChild(p);
			this.ajuste();
			dispatchEvent(new Event("carregou"));
		
		}
		
		public function proxima():void {
			indice++;
			if (indice < _imagens.length) {
				this._loader.load((new URLRequest(_server + _imagens[indice] as String)));
			} else {
				trace ('TODAS AS IMAGENS JA FORAM CARREGADAS');
			}
		}
		
		private function marcador(evento:MouseEvent):void
		{
			
			p.graphics.lineStyle(3, 0xFF9900);
			
			if (ponto.length == 0)
			{
				
				p.graphics.moveTo(evento.localX, evento.localY);
				
			}
			else
			{
				p.graphics.lineTo(evento.localX, evento.localY);
				
			}
			
			ponto.push(new Point(evento.localX, evento.localY));
		
		}
		
		public function comeca():void
		{
			trace("comecou mesmo");
			
			_loader.addEventListener(MouseEvent.CLICK, marcador);
			while (ponto.length > 0)
			{
				
				ponto.shift();
			}
		}
		
		public function termina():void
		{
			_loader.removeEventListener(MouseEvent.CLICK, marcador);
			trace("terminou mesmo");
			quadro.push(new Quadro());
			while (ponto.length > 0)
			{
				
				quadro[quadro.length - 1].getPonto(ponto.shift());
			}
			
		}
		
		public function ajuste():void
		{
			
			if (stage != null)
			{
				
				this.width = stage.stageWidth;
				this.scaleY = this.scaleX;
				if (height > this.areaUtil)
				{
					height = this.areaUtil;
					this.scaleX = this.scaleY;
				}
				x = (stage.stageWidth - width) / 2;
				y = (this.areaUtil - height) / 2;
			}
		}
		
		public function criarXML():String
		{
			var xmlcompleto:String;
			xmlcompleto = '<?xml version="1.0" encoding="utf-8"?> <pagina>';
			
			if (quadro.length == 0)
			{
				
				trace("não há quadros");
			}
			else
			{
				
				while (quadro.length > 0)
				{
					
					trace("há quadros");
					
					xmlcompleto += quadro.shift().exportaXML();
				}
				
				xmlcompleto += "</pagina>";
				
			}
			trace(xmlcompleto);
			p.graphics.clear();
			return (xmlcompleto);
		}
	
	}
}