package nid.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class CalendarEvent extends Event 
	{
		public static const CHANGE:String = "change";
		public static const LOADED:String = "loaded";
		static public const UPDATE:String = "update";
		
		private var date:Date;
		
		public function get selectedDate():Date { return date;}
		
		public function CalendarEvent(type:String,_date:Date=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			date = _date;
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CalendarEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}