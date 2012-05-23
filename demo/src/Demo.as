package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nid.events.CalendarEvent;
	import nid.ui.controls.DatePicker;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Demo extends Sprite 
	{
		private var dataPicker:DatePicker;
		
		public function Demo():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var holder:Sprite = new Sprite();
			addChild(holder);
			
			dataPicker = new DatePicker();
			dataPicker.hideOnFocusOut = false;
			dataPicker.WeekStart = "monday";
			dataPicker.months	= 	["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			
			//dataPicker.selectedDate = new Date(2013,2,3,12,2,2,2);
			dataPicker.addEventListener(CalendarEvent.CHANGE, getdate);
			dataPicker.x = 25;
			dataPicker.y = 25;
			
			holder.addChild(dataPicker);
			
			var resetBtn:Button = new Button();
			resetBtn.x = 25;
			resetBtn.y = 100;
			resetBtn.addEventListener(MouseEvent.CLICK, reset);
			addChild(resetBtn);
			
			
			holder.x = 150;
			holder.y = 150;
			
		}
		private function reset(e:MouseEvent):void
		{
			/** reset date picker **/
			dataPicker.selectedDate = null;
			trace(dataPicker.selectedDate);
		}
		private function getdate(e:CalendarEvent):void {
			trace("Date:" + e.selectedDate);
			trace(dataPicker.getDateString());
		}
	}
	
}