/*
*	This is just a while box but I liked the idea of having its own class because I could put a logo in it
*/

package components
{
	import flash.display.Sprite;
	
	public class Panel extends Sprite
	{
		public function Panel()
		{
			this.addChild(drawRect());
		}
	
		private function drawRect():Sprite
		{
			var rect:Sprite = new Sprite();
			
			rect.graphics.lineStyle(0.5,0x00000);
			rect.graphics.beginFill(0xffffff);
			rect.graphics.drawRoundRect(50,50,700,500,30);
			rect.graphics.endFill();
			
			return rect;
		}
	}
}