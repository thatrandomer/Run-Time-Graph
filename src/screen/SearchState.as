/*
*	this class shows all the various people which you can choose
*/

package screen
{
	import components.ListBox;
	import components.Panel;
	import components.ScrollBar;
	
	import data.XMLData.XMLData;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import screen.screenTranstion.*;
	
	internal class SearchState extends AbstractScreenState
	{
		private var dataX:XMLData;
		private var _scrollBar:ScrollBar;
		private var _listBoxs:Array;
		private var lastOffset:Number;
		private var loaded:Boolean;
		
		public function SearchState(screen:Screen)
		{
			super(screen);
			var panel:Panel = new Panel();
			addChild(panel);
			
			
			_listBoxs = new Array();
			
			dataX = XMLData.getInstance();
			
			//we need to check if the xml has been loaded or not
			//if it as been loaded skip to the load method if it hasn't been wait for it to load
			if(dataX.isLoaded())
				onLoad(null);
			else
				dataX.addEventListener("LOADED", onLoad);
		}
		
		private function onLoad(e:Event):void
		{
			var people:Array;
			people = dataX.getDataList();
			for(var i:int; i < people.length ; i++ )
			{
				if(people[i] == null)break;
				_listBoxs.push(new ListBox(people[i]));
				_listBoxs[i].x  = 100;
				_listBoxs[i].y  = 200 + i * 110;				
			}
			
			
			_scrollBar = new ScrollBar(300,10,(_listBoxs.length - 2)*110);
			_scrollBar.x = 720;
			_scrollBar.y = 150;
			
			
			addChild(_scrollBar);
			_scrollBar.addEventListener(Event.CHANGE, scrolling);
			
			
			displayProfiles();
			loaded = true;
		}
		
		private function wait(e:Event):void
		{
			if(loaded)
			{
				enable(null);
				removeEventListener(Event.ENTER_FRAME , wait);
			}
		}
	
		
		
		protected override function disable():void
		{
			removeChild(_scrollBar);
			
			for(var i:int = 0; i <  _listBoxs.length ; i++)
			{
				_listBoxs[i].disable();
				
			}
			
		}
		
		//this to let the button do things
		protected override function enable(e:Event):void
		{
			if(loaded)
			for(var i:int; i < _listBoxs.length ; i++ )
			{
				_listBoxs[i].addEventListener("SELECTED",personSelected);
			}
			else 
			addEventListener(Event.ENTER_FRAME , wait);
		}
		
		private function personSelected(e:Event):void
		{
			
			var s:AbstractScreenState = new ChartDisplay(_parentScreen,e.target.getData());
			_parentScreen.setState( s, new FlyInRight(), new FlyOutRight());
			
		}
		
		private function displayProfiles():void
		{
			//dont want to do it this way but i can't know how far the scroll bar skips
			
			
//			var i:Number = _scrollBar.getValue()/150;
	//		var len:Number = i + 2;
			var offset:Number = _scrollBar.getValue()%110;
			var start:int = _scrollBar.getValue()/110;
			
			
			
			for(var i:int; i < 3 ; i++ )
			{
				
				if(_listBoxs[i + start] == null)break;
				
				if(!_listBoxs[i + start].isDisplaying())addChild(_listBoxs[i + start]);
				
				if(i == 0)
				{
					 _listBoxs[i + start].fade(1 - offset/100);
				}
				else if(i == 2)
				{
					_listBoxs[i + start].fade(offset/100);
				}
				else
				{
					 _listBoxs[i + start].fade(1);
				}
				
				_listBoxs[i + start].y  = 200 + i * 110 - offset;
				_listBoxs[i + start].display();
				lastOffset = offset;
			}
			
			
			for(var index:int = 0; index <  _listBoxs.length ; index++)
			{
				
				if(_listBoxs[index].clearDisplay())
					removeChild(_listBoxs[index]);
				
			}
			
		}
		
		private function scrolling(e:Event):void
		{
			
			displayProfiles();
				
		}
		
		private function stopEveryThing(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
		}
		
	}
}