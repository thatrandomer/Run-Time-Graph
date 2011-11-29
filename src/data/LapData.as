/*	This class processing all the information straight awawy
*
*
*/ 
package data
{
	public class LapData
	{
		private var _time:Number;
		private var _length:Number;
		private var _date:Date;
		
		public function LapData(run:XML)
		{
			_time = run.time;
			_length = run.length;
			var date:Array = run.date.split("/")
			//actionscript goes year-month-day-hour - etc    but I give the date in the format dd/mm/yyyy
			////              year - month - day
			_date = new Date(date[2],date[1],date[0]);
		}
		
		public function getTime():Number
		{
			return _time;
		}
		
		
		public function getLength():Number
		{
			return _length;
		}


		public function getDate():Date
		{
			return _date;
		}


	}
}