/*
*	this class is the chart class
*/

package screen
{
	import components.Button;
	import components.TopPanel;
	
	import data.IData;
	
	import effects.*;
	
	import screen.screenTranstion.FlyOutRight;
	
	import screen.screenTranstion.None;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import view.Circle;
	import view.Star;
	
	
	
	internal class ChartDisplay extends AbstractScreenState
	{
		private var _person:IData;
		private var _laps:Array;
		private var _nodes:Array;
		private var _textNodes:Array;
		private var _next:Button , _prev:Button, _back:Button;
		
		public function ChartDisplay(screen:Screen , person:IData)
		{
			super(screen);
			
			_person = person;
			person.getLapData();
			var panel:TopPanel = new TopPanel();
			addChild(panel);
			
			//draw axis lines
			//line under text
				var line:Shape = new Shape();
				line.graphics.lineStyle(2,0x999999);
				line.graphics.lineTo(600,0);
				line.x = 100;
				line.y = 550;
				addChild(line);
				
				
				//times
				var formatter:TextFormat = new TextFormat;
				formatter.font = "Arial";
				formatter.size = 36;
				formatter.color = 0x0;
				
				var name:TextField = new TextField();
				name.selectable = false;
				name.text = "Time in Minutes";
				name.x = 150;
				name.y = 20;
				name.width = 500;
				name.setTextFormat(formatter);
				addChild(name);
		}
		
		
		protected override function disable():void
		{
			
		}
		
		public function goBack(e:Event):void
		{

			var s:AbstractScreenState = new SearchState(_parentScreen);
			_parentScreen.setState( s,  new None(), new FlyOutRight());
			
		}
		
		
		//this to let the button do things
		protected override function enable(e:Event):void
		{
			_nodes = new Array();	
			_textNodes = new Array();
			_laps = _person.getLapData();
			
		
			
			_prev = new Button("Prev",0x0,0x0,80,25);
			_prev.x = 490;
			_prev.y = 30;
			addChild(_prev);
			
			_next = new Button("Next",0x0,0x0,80,25);
			_next.x = 600;
			_next.y = 30;
			addChild(_next);
			_next.addEventListener(MouseEvent.CLICK , drawNextTimes);
			
				_back = new Button("Back",0x0,0x0,60,25);
			_back.x = 650;
			_back.y = 570;
			addChild(_back);
			_back.addEventListener(MouseEvent.CLICK , goBack);
			
			var formatter:TextFormat = new TextFormat;
				formatter.font = "Arial";
				formatter.size = 20;
				formatter.color = 0x0;
				formatter.align = TextFormatAlign.CENTER;
			
			//set up text feilds
			
			
			
			for(var index:int; index  <4 ; index++)
			{
				var label:TextField = new TextField();
				label.selectable = false;
				label.x = 130 + 150*index;
				label.y = 550;
				label.width = 50;
				label.height = 20;
				label.setTextFormat(formatter);
				addChild(label);
				_textNodes.push(label);
			}
			
			
			var next:Boolean = true;
			
			//set up the nodes
			for(var i:int ; i <4 && i < _laps.length ; i++)
			{
				var circle:Circle = new Circle(String(_laps[i].getTime()));
				circle.y = -100;
				circle.x = 150 + 150*i;
				circle.addEffect(new Spring(circle,500 - _laps[i].getTime()*5,0.09,0.7, i*30));
				addChild(circle);
				_nodes.push(circle);
				_textNodes[i].text = _laps[i].getDate().day + "/"+ _laps[i].getDate().month + "/" + _laps[i].getDate().fullYear;
			}
			
			//this is to clear the labels
			for(;i<4;i++){
				_textNodes[i].text = "";
				next = false;
			}
			
			if(!next)
			 _next.removeEventListener(MouseEvent.CLICK , drawNextTimes);
			
		}
		
		private var curPos:int = 0;
		
		//draw all the next nodes
		//i use stars for forward mainly to show off how easy it is to change the shape
		private function drawNextTimes(e:Event):void
		{
			
			var next:Boolean = true;
			for(var i:int = 0; i <4 && i + curPos < _laps.length ; i++)
			{
				removeChild(_nodes.pop());
			}
		
			curPos += 4;
			for(var i:int = 0; i <4 && i +curPos < _laps.length ; i++)
			{
				var star:Star = new Star(String(_laps[i + curPos].getTime()));
				star.y = -100;
				star.x = 150 + 150*i;
				star.addEffect(new Spring(star,500 - _laps[i + curPos].getTime()*5,0.09,0.7, i*30));
				addChild(star);
				_nodes.push(star);
				_textNodes[i].text = _laps[i].getDate().day + "/"+ _laps[i].getDate().month + "/" + _laps[i].getDate().fullYear;
			}
			for(;i<4;i++)
			{
				_textNodes[i].text = "";
				next = false;
			}
			
			if(!next)
			 _next.removeEventListener(MouseEvent.CLICK , drawNextTimes);
			 
			 if(curPos == 4)
			 _prev.addEventListener(MouseEvent.CLICK , drawPrevTimes);
		}
		
		private function drawPrevTimes(e:Event):void
		{
			
			for(var i:int = 0; i <4 && i  + curPos < _laps.length ; i++)
			{
				removeChild(_nodes.pop());
			}
		
			curPos -= 4;
			for(var i:int = 0; i <4 && i +curPos < _laps.length ; i++)
			{
				var circle:Circle = new Circle(String(_laps[i + curPos].getTime()));
				circle.y = -100;
				circle.x = 150 + 150*i;
				circle.addEffect(new Spring(circle,500 - _laps[i + curPos].getTime()*5,0.09,0.7, i*30));
				addChild(circle);
				_nodes.push(circle);
				_textNodes[i].text = _laps[i].getDate().day + "/"+ _laps[i].getDate().month + "/" + _laps[i].getDate().fullYear;
			}
			for(;i<4;i++)_textNodes[i].text = "";
			
			if(!_next.hasEventListener(MouseEvent.CLICK))
			{
				 _next.addEventListener(MouseEvent.CLICK , drawNextTimes);
			}
			 
			 if(curPos == 0)
			 _prev.removeEventListener(MouseEvent.CLICK , drawPrevTimes);
		}
		
	}
}