/*
*	This class acts as a window manager deciding what screenstate should be displayed and checking to see what transtion should be played 
*
*/


package screen
{
	import screen.screenTranstion.IScreenTranstion;
	import screen.screenTranstion.FlyInLeft;

	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Screen extends Sprite
	{
		
		private var _state:AbstractScreenState;
		private var _oldState:AbstractScreenState;
		
		//when this class is first started it starts in start state with a fly in transtion
		public function Screen()
		{
			_state = new StartState(this);
			_state.addInTranstion(new FlyInLeft());
			_state.startTranstion();
			addChild(_state);
		}

		//this sets up the next transtion and sets up an event listener for when the transtion is complete
		public function setState(state:AbstractScreenState , transtionIn:IScreenTranstion ,transtionOut:IScreenTranstion):void
		{
			removeChild(_state);
			_oldState = _state;
			_state = state;
			
			addChild(_state);
			addChild(_oldState);
			
			
			_oldState.addEventListener(Event.COMPLETE , onTranstionOutComplete);
			
			
			_oldState.addOutTranstion(transtionOut);
			_oldState.startTranstion();
			
			_state.addInTranstion(transtionIn);
			_state = state;

			
			
		}
		
	
		
		//this means the old transtion is complete so we can remove it
		public function onTranstionOutComplete(e:Event):void
		{
			
			_oldState.removeEventListener(Event.COMPLETE,onTranstionOutComplete);
			removeChild(_oldState);
			_state.startTranstion();
			
		}
	}
}