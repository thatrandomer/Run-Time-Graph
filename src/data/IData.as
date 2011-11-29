package data
{
	import flash.display.Loader;
	
	public interface IData
	{
		function getName():String;
		function getImage():Loader;
		function getLapData():Array;
	}
}