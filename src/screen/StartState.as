/*
*	this state just stats the deescription and prints my name
*/

package screen
{
	import components.Button;
	import components.Panel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import screen.screenTranstion.FadeIn;
	import screen.screenTranstion.FadeOut;
	
    internal class StartState extends AbstractScreenState
	{
		private var _button:Button;
		private var _text:TextField;
		
		public function StartState(screen:Screen)
		{
			super(screen);
			
			var sp:Panel = new Panel();
			addChild(sp);
			
			_button = new Button("start");
			_text = new TextField();
		
			
			//written by 
			_text.x = 305;
			_text.y = 300;
			_text.width = 500;
			_text.textColor = 0x111111;
/*final*/	_text.text = "Written by Kevin Farrell";
			addChild(_text);
			
			
			var description:TextField = new TextField();
			description.x = 245;
			description.y = 250;
			description.width = 500;
			description.text = "This program shows the visualization of 3 mile run times";
			addChild(description);
		}
		
		
		protected override function enable(e:Event):void
		{
			addChild(_button);	
			_button.x = 300;
			_button.y = 500;
			
			
			_button.addEventListener(MouseEvent.CLICK, startNextState);
		}
		
		
		protected override function disable():void
		{
			removeChild(_button);
		}
		
		
		private function startNextState(e:Event):void
		{
			var s:AbstractScreenState = new SearchState(_parentScreen);
			_parentScreen.setState( s,  new FadeIn(),new FadeOut());
		}
	}
}