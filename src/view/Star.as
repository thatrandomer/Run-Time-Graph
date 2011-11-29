/*
*	this creates a nice star for the text node, it would be better if I used maths 
*/

package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextLineMetrics;
	
	
	public class Star extends AbstractNodeView
	{
		private var _star:Sprite;
		
		public function Star(labelText:String)
		{
						
			
			
			_star = new Sprite();
			addChild(_star);
			_star.graphics.beginFill(0x0);
			_star.graphics.lineTo(15,45);
			_star.graphics.lineTo(60,45);
			_star.graphics.lineTo(30,75);
			_star.graphics.lineTo(50,120);
			_star.graphics.lineTo(0,90);
			
			_star.graphics.lineTo(-50,120);
			_star.graphics.lineTo(-30,75);
			_star.graphics.lineTo(-60,45);
			_star.graphics.lineTo(-15,45);
			_star.graphics.lineTo(0,0);
			_star.graphics.endFill();
			
			_star.y -= 60;
			
			super();
			
			
			var formatter:TextFormat = new TextFormat();
			formatter.align = TextFormatAlign.LEFT;
			formatter.size = 20;
			formatter.color = 0xffffff;
			formatter.font = "Arial";
			
			label.text = labelText;
			label.setTextFormat(formatter);
			findTextCenter();
			label.x  += 0;
			label.y += 0;
			
			addEventListener(Event.ENTER_FRAME,draw);
		}
		
		private function findTextCenter():void
		{
			var lineMetrics : TextLineMetrics = label.getLineMetrics(0);

			label.x -= lineMetrics.width/2;
			label.y -= lineMetrics.height/2;
		}
		
		
		
        public function draw(e:Event):void{
			drawEffects();
		}
	}
}