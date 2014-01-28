package nid.ui.controls.datePicker 
{
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class MonthPicker extends Sprite 
	{
		private var holder:Sprite;
		private var _width:Number;
		private var _height:Number;
		private var cellGap:int = 2;
		private var cellWidth:int;
		private var cellHeight:int;
		private var cellColor:uint;
		
		public function MonthPicker(cellColor:uint = 0, _width:Number=0, _height:Number=0)
		{
			this.cellColor = cellColor;
			this._height = _height;
			this._width = _width;
			cellWidth = (_width  - cellGap) / 4;
			cellHeight = (_height  - cellGap) / 3;
		}
		
		public function set months(value:Array):void 
		{
			if (holder && this.contains(holder)) {
				removeChild(holder);
			}
			
			holder = new Sprite();
			
			var _x:int = 0;
			var _y:int = 0;
			
			for (var i:int = 0; i < value.length; i++) {
				var dateCell:DateCell = new DateCell(cellColor, cellWidth, cellHeight);
				dateCell.serial = i;
				_x = (i % 4) * (cellWidth + cellGap);
				_y = Math.floor(i / 4) * (cellHeight + cellGap);
				
				dateCell.x = _x;
				dateCell.y = _y;
				
				var format:TextFormat=	new TextFormat();
					format.font 	=	"Tahoma";
					format.bold 	=	false;
					format.size 	=	12;
					format.color 		=	0xffffff;
					format.align		=	"center";
				
				dateCell.day_txt.defaultTextFormat 	=	format;
				
				dateCell.day_txt.text 		=	String(value[i]).substr(0,3);
				dateCell.hit.name 	 		= 	"hit";
				dateCell.hit.buttonMode 	=	true;
				
				dateCell.day_txt.x 				= (cellWidth - dateCell.day_txt.width) / 2;
				dateCell.day_txt.y 				= (cellHeight - dateCell.day_txt.height) / 2;
				
				holder.addChild(dateCell);
			}
			
			addChild(holder);
		}
		
	}

}