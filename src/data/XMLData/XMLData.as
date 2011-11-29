/*
*	this is the data class because of the lack of private constructors in actionscript im going to create a singleton in this way
*	using internal to stop someone trying to hack it
*
*	the class can give parent an event of "LOADED" or use the funtion id isLoaded()
*
*	This is important because it will cause errors trying to use this before its ready  
*/

package data.XMLData
{
	import data.XMLDataProxy;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLData extends EventDispatcher
	{
		private static var _instance:XMLData;
		private var _data:XML;
	    private var _peopleData:Array;
	    private var loaded:Boolean = false;
		
		public static function getInstance():XMLData{			
			if(_instance == null)
				_instance = new XMLData(new SingletonEnforcer());
				
			return _instance;
		}
		
		public function isLoaded():Boolean
		{
			return loaded;
		}
		
		public function XMLData(s:SingletonEnforcer)
		{
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(Event.COMPLETE, xmlLoaded);
			loader.load((new URLRequest("running.xml")));
		}
		
		
		
		private function xmlLoaded(e:Event):void{
			_data = new XML(e.target.data);
			loaded = true;
			dispatchEvent(new Event("LOADED"));
		}
		
		//this returns a list of XMLDataProxy classes
		public function getDataList():Array
		{
			if(_peopleData == null){
				_peopleData	 = new Array
				for each( var element:XML in _data.elements())
				{
					_peopleData.push(new XMLDataProxy(element));
				}
			}
					
			return _peopleData;
		}

	}
	
} internal class SingletonEnforcer{}