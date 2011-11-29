/*
*	this class is used to display IData data and using an custom enum
*/

package components
{
	import data.IData;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class ListBox extends Sprite
	{
		private var _data:IData;
		private var _name:TextField;
		private var _image:Loader;
		private var _loaded:Boolean;
		private var _fadeBox:Shape;
		private var _hoverBox:Shape;
		private var _display:int;
		
		public function ListBox(data:IData)
		{
			super();
			_data = data;
			_fadeBox = new Shape();
			_fadeBox.alpha = 0;
			_display = LISTBOX_ENUM.CLEARED;
		}
		
		public function display():void
		{
			// I want to differ the cost of drawing and loading objects until te user can actually see them on the page
			if(_loaded == false){
				_loaded = true;
				
				//name text
				var formatter:TextFormat = new TextFormat;
				formatter.font = "Arial";
				formatter.size = 36;
		
			
				_name = new TextField();
				_name.selectable = false;
				_name.text = _data.getName();
				_name.x = 150;
				_name.y = 10;
				_name.setTextFormat(formatter);
				addChild(_name);
			
				//line under text
				var line:Shape = new Shape();
				line.graphics.lineStyle(2,0xFF3333);
				line.graphics.lineTo(200,0);
				line.x = 150;
				line.y = 50;
				addChild(line);
			
			
				//profile pic
				_image = _data.getImage();
				_image.x = 10;
				_image.y = 10;
				addChild(_image);
				
				
				//this box tell you how much is faded
				
				//this is cheating but it will work for the time being
				//I hade to do it this way because actionscript kept distorting the images when I tried to alpha it out
				
				_fadeBox.graphics.beginFill(0xffffff);
				_fadeBox.graphics.drawRect(0,0,500,110);
				_fadeBox.graphics.endFill();
				addChild(_fadeBox);
				
				
				//this is the yellow box when you hover over an image
				_hoverBox = new Shape();
				_hoverBox.graphics.beginFill(0xFFE303,0.1);
				_hoverBox.graphics.drawRect(0,5,500,110);
				_hoverBox.graphics.endFill();
				
				
				//set up event listeners
				addEventListener(MouseEvent.CLICK , personSelected);
				addEventListener(MouseEvent.MOUSE_OVER, hover);
				addEventListener(MouseEvent.MOUSE_OUT, notHovering);
			}
		}
		
		
		//when someone is selected tell the parent
		public function personSelected(e:Event):void
		{
			dispatchEvent(new Event("SELECTED"));
		}
		
		//this to pass along data to the next screen
		public function getData():IData
		{
			return _data;
		}
		
		//add hover box
		public function hover(e:Event):void
		{
			addChild(_hoverBox);	
		}
		
		public function notHovering(e:Event):void
		{
			removeChild(_hoverBox);
		}
		
		//this is for fading the listbox out (it just covers it in a white box)
		public function fade(value:Number):void
		{
			_fadeBox.alpha = 1 - value;
		}
		
		
		//this is the function that determines if the parent has to add it to the screen
		public function isDisplaying():Boolean{
			_display = LISTBOX_ENUM.DISPLAY;
			
			if(parent== null)return false;
			return true;
		}
		
		//this function checks all if a box needs to be removed from the screen
		public function clearDisplay():Boolean{
			
			//if the alpha is really high the user will get a hover box with no name or picture in it
			if(_display == LISTBOX_ENUM.CLEAR || _fadeBox.alpha >= 0.9){
				_display = LISTBOX_ENUM.CLEARED;
				_fadeBox.alpha = 0;
				return true;
			}
			
			if(_display == LISTBOX_ENUM.DISPLAY)
				_display = LISTBOX_ENUM.CLEAR;
			
			return false;
		}
		
		
		//this removes the functionality of the listbox
		public function disable():void
		{
			removeEventListener(MouseEvent.CLICK , personSelected);
		}
		
		
	}
}
//this is just a simple enum
internal class LISTBOX_ENUM
{
		internal static const CLEARED:int = 0;
		internal  static const CLEAR:int = 1;
		internal static const DISPLAY:int = 2;
}