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
		
		protected var iconURL:String;
		protected var iconLoader:Loader;
		protected var iconWidth:Number = 18;
		protected var iconHeight:Number = 18;
		protected var _smooth:Boolean = true;
		protected var iconBitmap:Bitmap;
		protected var isEmbeded:Boolean;
		
		public function set icon(u:String):void { iconURL = u; }
		public function set smooth(s:Boolean):void { _smooth = s; }
		public function get embededIcon():Boolean { return isEmbeded;}
		public function set setBitmap(m:Bitmap):void { configIcon(m); }
		public function set Width(w:Number):void { this.width = w; }
		public function set Height(h:Number):void { this.height = h; }
		
		public function iconSprite():void {
		}
		public function configIcon(bitmap:Bitmap):void {
			iconBitmap = bitmap;
			if (iconURL == null) {				
				if (iconBitmap == null) {
					trace("ERROR!! Please provide a Bitmap for calendar icon");
					return;
				}
				isEmbeded = true;
				iconBitmap.smoothing = _smooth;
				iconBitmap.addEventListener(Event.ADDED, drawHitArea);
				addChild(iconBitmap);
				this.buttonMode = true;
				return;
			}else {
				if (iconURL == null) {
					trace("ERROR!! Please provide a Bitmap URL for calendar icon");
					return;
				}
				isEmbeded = false;
				iconLoader = new Loader();
				iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawHitArea);
				iconLoader.load(new URLRequest(iconURL));
				addChild(iconLoader);
				this.buttonMode = true;
				return;
			}
		}
		protected function drawHitArea(e:Event):void {
			var w:Number;
			var h:Number;
			if (iconURL != null) {
				var b:Bitmap = Bitmap(e.currentTarget.content);
				b.smoothing = _smooth;
				w = e.target.content.width;
				h = e.target.content.height;				
			}else {
				w = e.currentTarget.width;
				h = e.currentTarget.height;
			}
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			dispatchEvent(new CalendarEvent(CalendarEvent.LOADED));
			return;
		}
		
	}

}