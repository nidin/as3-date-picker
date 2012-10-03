package  nid.ui.controls.datePicker
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import nid.events.CalendarEvent;

	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class iconSprite extends Sprite
	{
		
		[Event(name="loaded",type="nid.events.CalendarEvent")]
		[Event(name="change",type="nid.events.CalendarEvent")]
		
		private var iconLoader:Loader;
		
		private var iconURL:String;
		private var _smooth:Boolean = true;
		private var iconBitmap:Bitmap;
		private var isEmbeded:Boolean;
		
		public function set smooth(s:Boolean):void { _smooth = s; if (iconBitmap) iconBitmap.smoothing = s; }
		public function get embededIcon():Boolean { return isEmbeded;}
		
		public function iconSprite():void {
			this.buttonMode = true;
		}
		public function configIcon(bitmap:Object):void {
			if (bitmap == null)
			{
				trace("ERROR!! Please provide a Bitmap for calendar icon");
				return;
			}
			
			if (iconBitmap != null && this.contains(iconBitmap))
			{
				removeChild(iconBitmap);
				iconBitmap = null;
			}
			
			if (bitmap is Bitmap) 
			{
				iconURL = null;
				iconBitmap = bitmap as Bitmap;
				isEmbeded = true;
				iconBitmap.smoothing = _smooth;
				addChild(iconBitmap);
				drawHitArea();
				return;
			}else if (bitmap is String) 
			{
				iconURL = bitmap as String;
				isEmbeded = false;
				if (iconLoader == null) iconLoader = new Loader();
				iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawHitArea);
				iconLoader.load(new URLRequest(iconURL));
				return;
			}
		}
		protected function drawHitArea(e:Event=null):void {
			if (iconURL != null) {
				iconBitmap = Bitmap(e.currentTarget.content);
				iconBitmap.smoothing = _smooth;
				addChild(iconBitmap);
			}
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, iconBitmap.width, iconBitmap.height);
			this.graphics.endFill();
			dispatchEvent(new CalendarEvent(CalendarEvent.LOADED));
			return;
		}
		
	}

}