
/*
*	this class stores all the xml but doesn't process it until its needed
*
*	This is very useful for the image as it will reduce the amount of unnessary loading
*/

package data
{
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	
	
	public class XMLDataProxy implements IData
	{
		
		private var _data:XML;
		private var _personData:PersonData;
		
		public function XMLDataProxy(data:XML)
		{
			this._data = data;
		    _personData = new PersonData();
		}
		
		public function getName():String{
			if(_personData.getName() == null){
				_personData.setName(_data.@name);
			}
			return _personData.getName();
		}
		
		public function getImage():Loader{
			if(_personData.getImage() == null){
				var imageLoader:Loader = new Loader;
				//setUpaHandler in case of an error
				imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , loadStandardImage);
				
				try {
        			imageLoader.load( new URLRequest(_data.image));
    			} catch (error:Error) {
        			loadStandardImage(null);
			    }

				
				
				_personData.setImage(imageLoader);
			}
			return _personData.getImage();
		}
		
		
		//this gives all the lap data in nice list
		public function getLapData():Array
		{
			if(_personData.getLapData() == null){
				var lapData:Array = new Array();
				for each(var lap:XML in _data.data.elements())
				 lapData.push(new LapData(lap));
				 
				_personData.setLapData(lapData);
			}
			return _personData.getLapData();
		}
		
		
		//this is here in case there is a broken link
		public function loadStandardImage(e:ErrorEvent):void
		{
				var imageLoader:Loader = _personData.getImage();
				imageLoader.load( new URLRequest("img/person.png"));
		}
		

	}
}