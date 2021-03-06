package
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author
	 */
	
	 
			
	public class Quadro
	{
		
		private var pontos:Vector.<Point>;
		
		public function Quadro() {
			
			pontos = new Vector.<Point>();
		}
		
		public function getPonto(p:Point):void
		{
			pontos.push(p);
		
		}
		
		// uma função pra exportar o xml desse quadro
		public function exportaXML():String
		{
			
			
			var retorno:String = '<quadro>';
			for (var i:int = 0; i < pontos.length; i++)
			{
				retorno += '<ponto>' + pontos[i].x + ',' + pontos[i].y + '</ponto>';
			}
			retorno += '</quadro>';
			
			return (retorno);
		}
	}

}