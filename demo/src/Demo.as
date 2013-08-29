package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import nid.events.CalendarEvent;
	import nid.ui.controls.DatePicker;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Demo extends Sprite 
	{
		[Embed(source = "calendar_day.png")]
		private var icon_img:Class;
		
		private var datePicker:DatePicker;
		
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
			
			datePicker = new DatePicker();
			datePicker.icon = new icon_img();
			datePicker.hideOnFocusOut = true;
			datePicker.dateFormat = "DD/MM/YYYY"
			datePicker.WeekStart = "monday";
			datePicker.days = ["MTWTFSS", "SMTWTFS"];
			datePicker.months	= 	["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			//datePicker.fontSize(20, 20, 20);
			//datePicker.selectedDate = new Date(2013,2,3,12,2,2,2);
			datePicker.addEventListener(CalendarEvent.CHANGE, getdate);
			datePicker.x = 25;
			datePicker.y = 25;
			
			datePicker.alwaysShowCalendar = false;
			holder.addChild(datePicker);
			
			datePicker.setLabelColor = 0xffffff
			datePicker.setButtonColor = 0xffffff
			datePicker.setBackgroundColor = [0x3D3D3D, 0x333333];
			datePicker.setEnabledCellColor = 0x666666;
			datePicker.setDisabledCellColor = 0xCCCCCC;
			
			//datePicker.
			
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
			datePicker.selectedDate = null;
			
		}
		private function getdate(e:CalendarEvent):void {
			trace("Date:" + e.selectedDate);
			trace(datePicker.getDateString());
			var d:Date = datePicker.selectedDate;
			trace(d.month +"/"+ d.day +"/"+ d.fullYear);
		}
	}
	
}