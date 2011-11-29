//	This class is the visual representation of a node in bar chart
//


package view
{
	import effects.IEffect;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class AbstractNodeView extends Sprite
	{
		//a text area
		private var _effects:Array;
		protected var label:TextField
		
		public function AbstractNodeView()
		{
			
			//set up the array
			_effects = new Array();
			//text setup
			label = new TextField();
			addChild(label);
		}

		
		public final function addEffect(effect:IEffect):void
		{
			 _effects.push(effect);	
			 effect.addEventListener(Event.COMPLETE,onEventDone);
		}
		
		public final  function drawEffects():void
		{
			for(var i:int; i < _effects.length ; i++){
				 _effects[i].drawEffect();
			}
		}
		
		
		//when the effect is complete i want to remove it from the list
		private function onEventDone(e:Event):void
		{
			for(var i:int; i < _effects.length ; i++){
				 if(_effects[i] == e.target)
				 {
				 		_effects.splice(i,1);
				 		break;
				 }
			}
			dispatchEvent(new Event("TRANSITION_FINISHED"));
			
		}
		
		

	}
}