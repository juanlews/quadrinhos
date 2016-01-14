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
		private var p:Shape;
		private var ponto:Vector.<Point>
		public var caminho:String;
		private var _loader:Loader;
		
		public function Pagina()
		{
			super();
			p = new Shape();
			ponto = new Vector.<Point>();
			
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
			_loader.addEventListener(MouseEvent.CLICK, marcador);
			
			addChild(_loader);
			addChild(p);
			this.ajuste();
		
		}
		
		private function marcador(evento:MouseEvent):void
		{
			p.graphics.lineStyle(3, 0xFF9900);
			
			if (ponto.length == 0) {
				
				p.graphics.moveTo(evento.localX, evento.localY);
				
			}
			else
			{
				p.graphics.lineTo(evento.localX, evento.localY);
				
			}
			ponto.push(new Point(evento.localX, evento.localY));
			
			
		
		}
		
		private function ajuste():void
		{
			
			if (stage != null)
			{
				
				this.width = stage.stageWidth;
				this.scaleY = this.scaleX;
				if (height > stage.stageHeight)
				{
					height = stage.stageHeight;
					this.scaleX = this.scaleY;
				}
				x = (stage.stageWidth - width) / 2;
				y = (stage.stageHeight - height) / 2;
			}
		}
	
	}

}