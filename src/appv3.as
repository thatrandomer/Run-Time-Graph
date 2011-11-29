package {
	
	import flash.display.Sprite;
	import screen.Screen;
	
	
	//background information for flex builder
	[SWF(backgroundColor = "0x000000",width = "800",height = "600", frameRate = "31")]

	
	public class appv3 extends Sprite
	{
		
		public function appv3()
		{
			var screen:Screen = new Screen();
			addChild(screen);
		}
	}
}