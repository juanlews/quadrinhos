package
{
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.geom.Point;
	
	
	/**
	 * ...
	 * @author
	 */
	public class Pagina extends Sprite
		{  
		public var xmlcompleto:String;
 		public var contquadros:int;		
		private var p:Shape;
		private var ponto:Vector.<Point>;
		private var quadro:Vector.<Quadro>;
		public var caminho:String;
		private var _loader:Loader;
		public var areaUtil:Number;
		
		public function Pagina()
		{
			
			super();
			contquadros = 0;
			p = new Shape();
			xmlcompleto = "";
			ponto = new Vector.<Point>();
			quadro = new Vector.<Quadro>();
			_loader = new Loader();
		
		}
		
		public function load():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.INIT, imagemCarregada);
			//_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, erroImagem);
			
			_loader.load(new URLRequest('87.jpg'));
		}
		
		private function imagemCarregada(evento:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, imagemCarregada);
			//_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, erroImagem);
			
			addChild(_loader);
			addChild(p);
			this.ajuste();
		
		}
		
		private function marcador(evento:MouseEvent):void {
			
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
			trace(xmlcompleto);
			_loader.addEventListener(MouseEvent.CLICK, marcador);
			while (ponto.length > 0)
			{
				
				ponto.shift();
			}
		}
		
		public function termina():void
		{    contquadros += 1;
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
		
		public function criarXML():void
		{
			if (quadro.length == 0)
			{
				
				trace("não há quadros");
			}
			else {
				
				while( quadro.length > 0 )
				{
					
					trace("há quadros");
					
					
					xmlcompleto += quadro.shift().exportaXML(contquadros);
				}
			}
		
		}
	
	}
}