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
		
		public function Quadro()
		{
			
			pontos = new Vector.<Point>();
		}
		
		public function getPonto(p:Point):void
		{
			pontos.push(p);
		
		}
	}

}