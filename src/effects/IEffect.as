/*
*	these effects should work with any sprites but I'm using them just for the display in the chart
*/

package effects
{
	import flash.events.IEventDispatcher;
	
	public interface IEffect extends IEventDispatcher
	{
	  function drawEffect():void;
	  
	}
}