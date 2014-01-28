package nid.ui.controls.datePicker 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DateCell extends Sprite 
	{
		internal var hit:Sprite;
		internal var day_txt:TextField;
		public var id:int;
		public var isToday:Boolean;
		public var hitted:Boolean;
		public var serial:int;
		public var date:Date;

		public function DateCell(cellColor:int, cellWidth:int, cellHeight:int) {
			hit				= 	new Sprite();
			day_txt			=	new TextField();
			
			name	= 	"bg";
			day_txt.name 	= 	"txt";
			
			graphics.beginFill(cellColor,1);
			graphics.drawRect(0,0,cellWidth,cellHeight);
			graphics.endFill();
			
			hit.graphics.beginFill(0x000000,0);
			hit.graphics.drawRect(0, 0, cellWidth, cellHeight);
			hit.graphics.endFill();	
			
			day_txt.autoSize 		= TextFieldAutoSize.CENTER;
			day_txt.multiline		= false;
			day_txt.selectable 		= false;
			
			addChild(day_txt);
			addChild(hit);
		}
		
	}

}