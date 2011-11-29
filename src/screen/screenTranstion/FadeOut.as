package screen.screenTranstion
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import screen.AbstractScreenState;

	public class FadeOut extends EventDispatcher implements IScreenTranstion
	{
		private var _screen:AbstractScreenState;
		
		public function FadeOut()
		{
			super();
		    
		}
		
		public function addScreen(screen:AbstractScreenState):void
		{
			_screen = screen;
			_screen.alpha = 1;
		}
		
		public function start():void
		{
			
			_screen.addEventListener(Event.ENTER_FRAME , onEnterFrame);
		}
		
		public function onEnterFrame(e:Event):void
		{
			_screen.alpha -= .005;
			if(_screen.alpha <= 0.1)
			{
				_screen.removeEventListener(Event.ENTER_FRAME , onEnterFrame);
			 		dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
	
		
	}
}