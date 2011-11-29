/*
*	this an abstract class that deals with screen states, it's main function is to manage transtions   
*/

package screen
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screen.screenTranstion.IScreenTranstion;

	

	public class AbstractScreenState extends Sprite
	{
		protected var _parentScreen:Screen;
		protected var _transtion:IScreenTranstion;
		
		public function AbstractScreenState(screen:Screen)
		{
			super();
			_parentScreen = screen;
		}
		
	
		
		public final function addOutTranstion(transtion:IScreenTranstion):void
		{
			_transtion  = transtion;
			disable();
			_transtion.addScreen(this);
			_transtion.addEventListener(Event.COMPLETE , finish);
			
		}
		
		public final function addInTranstion(transtion:IScreenTranstion):void
		{
			_transtion  = transtion;
			_transtion.addScreen(this);
			_transtion.addEventListener(Event.COMPLETE , enable);
			
		}
		
		public function startTranstion():void
		{
			_transtion.start();
		}
		
		//this is for disabling buttons and control features
		protected function disable():void
		{
			throw new Error("abstract method");
		}
		
		
		//this to let the button do things
		protected function enable(e:Event):void
		{
			throw new Error("abstract method");
		}
		
		protected function finish(e:Event):void
		{
			_transtion.removeEventListener(Event.COMPLETE , finish);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}