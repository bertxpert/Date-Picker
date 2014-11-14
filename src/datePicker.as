//Date Picker
//copyright 2012
//By Milbert Cuevas Cale
package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Milbert_C @ Playware Studios Pte Ltd
	 */
	public class datePicker extends MovieClip 
	{
		private const dateWeek:Array = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
		private const month:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		private var headerMC:MovieClip;
		private var headerText:TextField;
		private var bodyBgMC:MovieClip;
		private var i:int;
		private var j:int;
		private var k:int;
		private var textField:TextField;
		private var dateWeekHolder:MovieClip;
		private var dayHolder:MovieClip;
		private var days:int;
		private var daysAr:Array;
		private var mc:MovieClip;
		private var previousMC:MovieClip;
		private var nextMC:MovieClip;
		private var numMonth:int;
		private var numYear:int;
		private var _date:Date;
		private var numDate:int;
		public function datePicker()
		{
			numMonth = new Date().getMonth();
			numYear = new Date().getFullYear();
			numDate = new Date().getDate();
			_date = new Date();
			headerMC = new MovieClip();
			headerMC.graphics.lineStyle(1, 0xC0C0C0);
			headerMC.graphics.beginFill(0xC7DEFA);
			headerMC.graphics.drawRect(0, 0, 45 * 7, 30);
			headerMC.graphics.endFill();
			addChild(headerMC);
			headerText = createTF(month[new Date().getMonth()] + " " + new Date().getFullYear().toString(), 18, true, "center", headerMC.width, headerMC.height - 5);
			headerText.y = 2.5;
			headerText.selectable = false;
			addChild(headerText);
			
			previousMC = new MovieClip();
			previousMC.graphics.lineStyle(1, 0x808080);
			previousMC.graphics.beginFill(0x0E80F1);
			previousMC.graphics.moveTo(0, (headerMC.height) / 2);
			previousMC.graphics.lineTo((headerMC.height - 10), 5);
			previousMC.graphics.lineTo((headerMC.height - 10), headerMC.height - 5);
			previousMC.graphics.lineTo(0, (headerMC.height) / 2);
			previousMC.x = 5;
			previousMC.buttonMode = true;
			previousMC.addEventListener(MouseEvent.CLICK, previousDate,false,0,true);
			addChild(previousMC);
			
			nextMC = new MovieClip();
			nextMC.graphics.lineStyle(1, 0x808080);
			nextMC.graphics.beginFill(0x0E80F1);
			nextMC.graphics.moveTo(0, 5);
			nextMC.graphics.lineTo(headerMC.height - 10, (headerMC.height) / 2);
			nextMC.graphics.lineTo(0, headerMC.height - 5);
			nextMC.graphics.lineTo(0, 5);
			nextMC.x = headerMC.width - nextMC.width - 5;
			nextMC.buttonMode = true;
			nextMC.addEventListener(MouseEvent.CLICK, nextDate,false,0,true);
			addChild(nextMC);
			
			dateWeekHolder = new MovieClip();
			for (i = 0; i < dateWeek.length; i++) {
				textField = createTF(dateWeek[i], 14, true, "center", 45, 25);
				textField.x = dateWeekHolder.width;
				textField.selectable = false;
				dateWeekHolder.addChild(textField);
			}
			dateWeekHolder.y = headerMC.height;
			addChild(dateWeekHolder);
			
			dayHolder = new MovieClip();
			daysAr = new Array();
			j = 0;
			k = 0;
			for (i = 0; i < 7 * 6; i++) {
				mc = new MovieClip();
				mc.mouseEnabled = false;
				mc.mouseChildren = false;
				textField = createTF("", 12, true, "center", 20, 20);
				mc.addChild(textField);
				mc.name = i.toString();
				mc.addEventListener(MouseEvent.CLICK, selectDate, false, 0, true);
				mc.addEventListener(MouseEvent.ROLL_OVER, rollOverDate);
				mc.addEventListener(MouseEvent.ROLL_OUT, rollOutDate);
				daysAr.push(mc);
				textField.backgroundColor = 0xC0C0C0;
				if (i % 7 == 0 && i != 0) {
					j++;
					k = 0;
					textField.textColor = 0xFF0000;
					mc.x = (45 - mc.width) / 2;
					mc.y = dayHolder.height+10;
				}
				else {
					if (i != 0) k++;
					else {
						textField.textColor = 0xFF0000;
					}
					mc.x = k * 45 + (45 - mc.width) / 2;
					mc.y = j * (mc.height+10);
				}
				textField.selectable = false;
				dayHolder.addChild(mc);
			}
			dayHolder.y = dateWeekHolder.y+dateWeekHolder.height;
			addChild(dayHolder);
			this.date = new Date();
			this.graphics.lineStyle(1, 0x808080);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, headerMC.width, headerMC.height + dateWeekHolder.height + dayHolder.height);
		}
		
		private function previousDate(e:MouseEvent):void {
			numMonth--;
			if (numMonth < 0) {
				numYear--;
				numMonth = 11;
			}
			this.date = new Date(numYear, numMonth, new Date().getDate());
		}
		
		private function nextDate(e:MouseEvent):void {
			numMonth++;
			if (numMonth >= 12) {
				numYear++;
				numMonth = 0;
			}
			this.date = new Date(numYear, numMonth, new Date().getDate());
		}
		
		private function selectDate(e:MouseEvent):void {
			numDate = int(e.currentTarget.getChildAt(0).text);
			_date = new Date(numYear, numMonth, numDate);
			this.dispatchEvent(new Event("Select"));
		}
		
		private function rollOverDate(e:MouseEvent):void {
			TextField(e.currentTarget.getChildAt(0)).background = true;
		}
		
		private function rollOutDate(e:MouseEvent):void {
			TextField(e.currentTarget.getChildAt(0)).background = false;
		}
		
		public function set date($date:Date):void {
			numMonth = $date.getMonth();
			numDate = $date.getDate();
			numYear = $date.getFullYear();
			var dayWeek:int = 0;
			var yearMonth:Date = new Date($date.getFullYear(), $date.getMonth(), 1);
			var ctr:int = 0;
			for (i = 0; i < daysAr.length; i++) {
				daysAr[i].mouseEnabled = false;
				daysAr[i].mouseChildren = false;
				daysAr[i].getChildAt(0).htmlText = "";
				daysAr[i].graphics.clear();
			}
			for (i = yearMonth.getDay(); i < getNumberOfDays($date.fullYear, $date.month) + yearMonth.getDay(); i++) {
				ctr++;
				if (new Date().toDateString() == $date.toDateString()) {
					if (ctr == $date.getDate()) {
						daysAr[i].graphics.beginFill(0x8EC4F9);
						daysAr[i].graphics.drawRect(0, 0, daysAr[i].width, daysAr[i].height);
						daysAr[i].graphics.endFill();
					}
				}
				daysAr[i].mouseEnabled = true;
				daysAr[i].mouseChildren = true;
				daysAr[i].getChildAt(0).htmlText = "<font size='12'><b>" + ctr.toString() + "</b></font>";
			}
			headerText.htmlText = "<font size='16'><b>" + month[$date.getMonth()] + " " + $date.getFullYear().toString() + "</b></font>";
		}
		
		public function get date():Date {
			return _date;
		}
		
		private function getNumberOfDays($year:int, $month:int):int
		{
			var month:Date = new Date($year, $month + 1, 0);
			return month.date;
		}
		
		private function createTF(txt:String = "Sample", size:int = 12, bold:Boolean = false, _align:String="left",_width:Number=100,_height:Number=15):TextField {
			var tf:TextField = new TextField();
			tf.width = _width;
			tf.height = _height;
			var TF:TextFormat = new TextFormat();
			TF.align = _align;
			TF.font = "arial";
			TF.kerning = true;
			if (bold) tf.htmlText = "<font size='" + size + "'><b>" + txt + "</b></font>";
			else tf.htmlText = "<font size='" + size + "'>" + txt + "</font>";
			tf.setTextFormat(TF);
			tf.defaultTextFormat = TF;
			return tf;
		}
	}
}