/*
*	All transtions work the same they have constructor which they can do what you want with the screen hide it off on the side or keep it faded out
*   then the transtion will start 
*	
*/

package screen.screenTranstion
{
	import flash.events.IEventDispatcher;
	import screen.AbstractScreenState;

	public interface IScreenTranstion extends IEventDispatcher
	{
		 function start():void;
		 function addScreen(screen:AbstractScreenState):void;
	}
}