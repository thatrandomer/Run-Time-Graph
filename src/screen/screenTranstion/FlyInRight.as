package screen.screenTranstion
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import screen.AbstractScreenState;

	public class FlyInRight extends EventDispatcher implements IScreenTranstion
	{
		private var _screen:AbstractScreenState;
		
		public function FlyInRight()
		{
			super();
			
			
		}
		
		public function addScreen(screen:AbstractScreenState):void
		{
			_screen = screen;
			_screen.x = 800;
		}
		
		public function start():void
		{
			
			_screen.addEventListener(Event.ENTER_FRAME , onEnterFrame);
		}
		
		public function onEnterFrame(e:Event):void
		{
			_screen.x -= 5;
			if(_screen.x <= 0)
			{
				_screen.removeEventListener(Event.ENTER_FRAME , onEnterFrame);
			 		dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}