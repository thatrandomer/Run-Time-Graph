/*
*	this causes the object to get bigger and smaller in a pulsing fasion
*/

package effects
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;

	public class Pulse extends EventDispatcher implements IEffect
	{
		private var _parent:Sprite;
		private var _speed:Number;
		private var _range:Number;
		private var _angle:Number;
		
		public function Pulse(parent:Sprite,speed:Number,range:Number,startSize:Number = 0)
		{
			_parent = parent;
			_speed = speed;
		    _range = range;
		    _angle = startSize;
		
		}

		public function drawEffect():void
		{
			
			_parent.scaleX = _parent.scaleY = 1 + Math.sin(_angle) * _range;
			_angle += _speed;
		}
		
		
		
	}
}