package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author colaboa
	 */
	public class Botoes extends Sprite
	{
		
		[Embed(source = "botoes/bt_comecar.png")]
		private var bt_comecar:Class;
		
		[Embed(source = "botoes/bt_terminar.png")]
		private var bt_terminar:Class;
		
		[Embed(source = "botoes/bt_exportar.png")]
		private var bt_exportar:Class;
		
		public var botao:Sprite = new Sprite();
		public var botao2:Sprite = new Sprite();
		public var botao3:Sprite = new Sprite();
		
		public function Botoes() 
		{
			
			var btBitmap:Bitmap = new bt_comecar() as Bitmap;
			var btBitmap2:Bitmap = new bt_terminar() as Bitmap;
			var btBitmap3:Bitmap = new bt_exportar() as Bitmap;
			
			btBitmap.smoothing = true;
			btBitmap2.smoothing = true;
			btBitmap3.smoothing = true;
			
		
		botao.addChild(btBitmap);	
		addChild(botao);
		botao.x = 0; 
		botao.y = 100;
		botao.addEventListener(MouseEvent.CLICK, clique);
			
			
		botao2.addChild(btBitmap2);
		addChild(botao2);
		botao2.x = 200;
		botao2.y = 100;
		botao2.addEventListener(MouseEvent.CLICK, clique2);
		
		botao3.addChild(btBitmap3);
		addChild(botao3);
		botao3.x = 300;
		botao3.y = 100;
		botao3.addEventListener(MouseEvent.CLICK, clique3);
		
		
		}
		
		public function clique(evento:MouseEvent):void {
		trace('clicou');
		dispatchEvent(new Event("começar"));
		}
		public function clique2(evento:MouseEvent):void {
		trace('aqui tambem');	
		dispatchEvent(new Event("terminar"));
		}
		public function clique3(evento:MouseEvent):void {
		trace('e aqui');
		dispatchEvent(new Event("exportar"));
		}
		public function reposicione():void{ 
			botao.width = stage.stageWidth / 3;
			botao.scaleY = botao.scaleX;
			botao.x = 0; 
			botao.y = 0;
			
			
			botao2.width = stage.stageWidth / 3;
			botao2.scaleY = botao2.scaleX;
			botao2.x = botao.x + botao.width;
			botao2.y=0;
			
			
			botao3.width = stage.stageWidth / 3;
			botao3.scaleY = botao3.scaleX;
			botao3.x = botao2.x + botao2.width;
			botao3.y = 0;
			
			
		}
		
	}


}