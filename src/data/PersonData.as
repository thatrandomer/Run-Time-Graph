/*
*	This is just a storage class
*/

package data
{
	import flash.display.Loader;
	
	public class PersonData implements IData
	{
		private var _name:String;
		private var _image:Loader;
		private var _data:Array;
		
		public function PersonData()
		{
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function getImage():Loader
		{
			return _image;
		}
		
		public function setName(name:String):void
		{
			_name = name;
		}
		
		public function setImage(image:Loader):void
		{
			_image = image;
		}
		
		public function setLapData(data:Array):void
		{
			_data = data;
		}
		
		public function getLapData():Array
		{
			return _data;
		}

	}
}