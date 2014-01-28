package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import nid.events.CalendarEvent;
	import nid.ui.controls.DatePicker;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class TestDatePicker extends Sprite 
	{
		//[Embed(source = "calendar_day.png")]
		//private var icon_img:Class;
		
		private var datePicker:DatePicker;
		
		public function TestDatePicker():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var holder:Sprite = new Sprite();
			addChild(holder);
			
			datePicker = new DatePicker();
			//datePicker.calendarWidth = 300;
			//datePicker.calendarHeight = 300;
			//datePicker.icon = new icon_img();
			datePicker.hideOnFocusOut = true;
			datePicker.dateFormat = "DD/MM/YYYY"
			datePicker.WeekStart = "monday";
			datePicker.days = ["MTWTFSS", "SMTWTFS"];
			//datePicker.months	= 	["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			//datePicker.embedFonts = true;
			datePicker.bitmapFonts = true;
			//datePicker.fontSize(20, 20, 20);
			datePicker.selectedDate = new Date(2013,2,3,12,2,2,2);
			datePicker.addEventListener(CalendarEvent.CHANGE, getdate);
			datePicker.x = 25;
			datePicker.y = 25;
			
			//datePicker.calendarPlacement = "manual";
			//datePicker.calendarPoint = new Point(-100, -100);
			datePicker.alwaysShowCalendar = false;
			holder.addChild(datePicker);
			
			datePicker.tabChildren = false;
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