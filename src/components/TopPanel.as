/*
*	this is the pretty much te same as the panel class but has more space
*/

package components
{
		import flash.display.Sprite;

	
	public class TopPanel extends Sprite
	{
		public function TopPanel()
		{
			this.addChild(drawRect());
		}
	
		private function drawRect():Sprite
		{
			var rect:Sprite = new Sprite();
			
			rect.graphics.lineStyle(0.5,0x00000);
			rect.graphics.beginFill(0xffffff);
			rect.graphics.drawRoundRect(50,0,700,600,30);
			rect.graphics.endFill();
			
			return rect;
		}
	}
}