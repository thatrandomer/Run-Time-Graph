//this was just used for testing as transtions can get tedious

package screen.screenTranstion
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import screen.AbstractScreenState;

	public class None extends EventDispatcher implements IScreenTranstion
	{
		private var _screen:AbstractScreenState;
	
		
		public function None()
		{	
			super();	
		}
		
		public function addScreen(screen:AbstractScreenState):void
		{
			_screen = screen;
		}
		

	   //the reason why I did it this way is because flash is sensitive to too many events happening all at once
		public function start():void
		{
			_screen.addEventListener(Event.ENTER_FRAME, load);
				
		}
		
		private function load(e:Event):void
		{
		 _screen.removeEventListener(Event.ENTER_FRAME , load);

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}