/*
*	this is going to minimalist bar
*/

package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class ScrollBar extends Sprite
	{
		private var thumb:Sprite;
		private var _thumbHeight:Number;
		private var _height:Number;
		private var _range:Number;
		
		public function ScrollBar(height:Number, thumbHeight:Number,range:Number, barColour:uint = 0xffffff , thumbColour:uint = 0x000000)
		{
			_height = height;
			_thumbHeight = thumbHeight;
			_range = range;
			
			//bar
			var rect:Sprite = new Sprite();
			
			rect.graphics.lineStyle(0.5,0x000000);
			rect.graphics.beginFill(barColour);
			rect.graphics.drawRect(0,0,10,height);
			rect.graphics.endFill();
			addChild(rect);
			
			//thumb
			thumb = new Sprite;
			thumb.graphics.lineStyle(0.5,0x000000);
			thumb.graphics.beginFill(thumbColour);
			thumb.graphics.drawRect(-5,0,20,thumbHeight);
			thumb.graphics.endFill();
			addChild(thumb);
			
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, moveScroll);
		}
		
		public function moveScroll(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME,stillScrolling);
			stage.addEventListener(MouseEvent.MOUSE_UP, finScroll);
		}
		
		
		//the stage.mouse is working with absolute positioning while the scroll bar is relative that why it may look a little werid
		public function stillScrolling(e:Event):void
		{
			if( stage.mouseY + 4 < this.y) thumb.y = 0;
			else if(stage.mouseY  > this.y  + _height - _thumbHeight) thumb.y = _height - _thumbHeight;
			else
			{
				thumb.y = stage.mouseY - this.y;
			}
			
		    dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function finScroll(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,finScroll);
			removeEventListener(Event.ENTER_FRAME,stillScrolling);	
		}
		
		//this function just figures out what value the scrollbar is giving based on its position
		public function getValue():Number{
			return (thumb.y/(_height - _thumbHeight))*(_range) ;
		}
		
		
	}
}