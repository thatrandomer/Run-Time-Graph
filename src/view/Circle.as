package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextLineMetrics;
	
	public class Circle extends view.AbstractNodeView
	{
		private var circle:Sprite; 
		
		
		public function Circle(labelText:String)
		{
			
			
			
			circle = new Sprite();
			addChild(circle);
			circle.graphics.beginFill(0x0);
			circle.graphics.drawCircle(0,0,40);
			circle.graphics.endFill();
			
			super();
			
			
			var formatter:TextFormat = new TextFormat();
			formatter.align = TextFormatAlign.LEFT;
			formatter.size = 20;
			formatter.color = 0xffffff;
			formatter.font = "Arial";
			
			label.text = labelText;
			label.setTextFormat(formatter);
			findTextCenter();
			
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