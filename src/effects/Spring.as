/*
*	this cause an object to spring to cerain location
*/

package effects
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Spring extends EventDispatcher implements IEffect
	{
		
		private var _sprite:Sprite;
		//the speed of the spring
		private var _spring:Number;
		//the target position
		private var _targetY:Number;
		//the velocitiy
		private var _vy:Number = 0;
		//the friction value (how fast it slows down by)
		private var _friction:Number;
		
		private var _wait:int;
		
		public function Spring(sprite:Sprite , targetY:Number, speed:Number = 0.1, friction:Number = 0.95, wait:int = 0)
		{
			_wait = wait;
			_sprite = sprite;
			_targetY = targetY;
			_spring = speed;
			_friction = friction;
		}
		
		
		
		//this method should be called from an enter frame
		public function drawEffect():void
		{
			//im using wait so I can add multiple springs but they wont all act at the same time
			if(0 < _wait)
			{
				_wait--;
				return;
			}
			var dy:Number = _targetY - _sprite.y;
			var ay:Number = dy * _spring;
			_vy += ay;
			_vy *= _friction;
			_sprite.y += _vy;
			
			
			//if vy is very low then the ball must at rest , it because im using multiplication its a little dodgy
			if(_vy <= 0.1 && _vy >= -0.1)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		

	}
}