/*
*	nothing special in this class just a simple button
*/

package components
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class Button extends SimpleButton
	{
		private var _label:String;
		private var _fillColour:uint;
		private var _strokeColour:uint;
		private var _width:int , _height:int;
		
		public function Button(label:String, fillColour:uint = 0x888888, strokeColour:uint = 0x999999,width:int = 150, height:int = 40)
		{
			_label = label;
			_fillColour = fillColour;
			_strokeColour = strokeColour;
			_width = width;
			_height = height;
			
			//set up states
			upState = createUpState();
			overState = createOverState();
			downState = createDownState();
			hitTestState = upState;
		}
		
		
		private function createUpState():Sprite{
			var sprite:Sprite = new Sprite();
			
			sprite.addChild(drawRect(_fillColour,_strokeColour));
			sprite.addChild(drawText());
			return sprite;
		} 
		
		private function createOverState():Sprite{
			var sprite:Sprite = new Sprite();
			sprite.addChild(drawRect(_fillColour - 0x111111,_strokeColour + 0x222222));
			sprite.addChild(drawText());
			return sprite;
		} 
		
		private function createDownState():Sprite{
			var sprite:Sprite = new Sprite();
			sprite.addChild(drawRect(_fillColour - 0x333333,_strokeColour + 0x222222));
			sprite.addChild(drawText());
			return sprite;
		} 
		
		private function drawRect(fillColour:uint , strokeColour:uint):Shape
		{
			var rect:Shape = new Shape();
			
			rect.graphics.lineStyle(0.5,strokeColour);
			rect.graphics.beginFill(fillColour);
			rect.graphics.drawRoundRectComplex(0,0,_width,_height,5,5,5,5);
			rect.graphics.endFill();
			return rect;
		}
		
		
		//this the text within the button
		private function drawText():TextField
		{
			var text:TextField = new TextField();
			text.text = _label;
			text.width = _width;
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 20;
			format.color = 0xffffff;
			text.setTextFormat(format);
			
			text.x = 3;
			text.y = 0;
			return text;
		}		
		
	}
}