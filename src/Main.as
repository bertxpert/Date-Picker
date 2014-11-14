package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Milbert_C @ Playware Studios Pte Ltd
	 */
	public class Main extends Sprite 
	{
		private var header:datePicker;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			header = new datePicker();
			header.scaleX = header.scaleY = 1;
			addChild(header);
			//header.date = new Date(100, 11, 25);
			header.addEventListener("Select", Select);
		}
		
		private function Select(e:Event):void {
			trace(e.currentTarget.date);
		}
		
	}
	
}