package nid.ui.controls.datePicker
{

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.display.BlendMode;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.geom.Matrix;
	import flash.filters.ColorMatrixFilter;
	import nid.events.CalendarEvent;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public dynamic class CalendarSkin extends UIProperties {
		
		/*
		 *	GET SET METHODS
		 * 
		 */
		public function set WeekStart(s:String):void 
		{ 
			_startDay = s.toLowerCase();
			constructWeekNames();
			constructCalendar();
		}
		public function set icon(b:Object):void { calendarIcon.configIcon(b); }
		public function set setBackgroundColor(color:Array):void { backgroundColor = color; re_construct();}
		public function set setBackgroundGradientType(value:String):void { backgroundGradientType = value; re_construct(); }
		public function set setBackgroundStrokeColor(color:int):void { backgroundStrokeColor = color; re_construct();}
		public function set setLabelColor(color:int):void { labelColor = color; re_construct();}
		public function set setButtonColor(color:int):void { buttonColor = color; re_construct();}
		public function set setDisabledCellColor(color:int):void { disabledCellColor = color; constructCalendar();}
		public function set setEnabledCellColor(color:int):void { enabledCellColor = color; constructCalendar();}
		public function set setTodayCellColor(color:int):void { TodayCellColor = color; changeColor(todayDateBox, color); }
		public function set setMouseOverColor(color:int):void { mouseOverCellColor = color;}
		public function set setDateColor(color:int):void { entryTextColor = color; constructCalendar();}
		
		public function set calendarWidth(w:Number):void { 
			_calendarWidth = w;
			cellWidth = ((w  - (10 + (cellGap * 6))) / 7);
			re_construct();
		}
		public function set calendarHeight(h:Number):void { 
			_calendarHeight = h;
			cellHeight = ((h - (yOffset + 8) + cellGap) / 6) - cellGap;
			re_construct();
		}
		
		/*
		 * SET FONT SIZE
		 * 
		 */
		public function fontSize(MonthAndYear:Number = 12, WeekName:Number = 12, Day:Number = 10):void {			
			monthAndYearFontSize = MonthAndYear;
			weekNameFontSize = WeekName;
			dayFontSize = Day;
			if (stage)
			{
				constructWeekNames();
				constructCalendar();
			}
		}
		/*
		 * SET GLOW FILTER OF CALENDAR
		 * 
		 */
		public function setGlow(color:uint=0,alpha:Number=0.2,blurX:Number=6,blurY:Number=6,strength:Number=2,quality:int=1,inner:Boolean=false,knockout:Boolean=false):void {
			var filter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
			calendar.filters = new Array(filter);
		}
		/*
		 *	MAIN
		 * 
		 */
		public function CalendarSkin() {
			
		}
		protected function re_construct():void { 
			if (stage)
			{
				construct();
				dispatchEvent(new CalendarEvent(CalendarEvent.UPDATE));
			}
		}
		protected function construct():void 
		{
			flush();
			calendar = new Sprite();
			isHitted = new Object();
			calendar.alpha 	= 0;
			calendar.cacheAsBitmap = true;
			setGlow();
			/*
			 *  DRAW CALENDAR BACKGROUND
			 */
			var bg						:Sprite 	= 	new Sprite();
			var type					:String 	= 	backgroundGradientType;
			var colorArray				:Array 		= 	backgroundColor;	
			var alphaArray				:Array 		=	[1,1];					
			var ratioArray				:Array		=	[0, 255];				
			var colorMatrix				:Matrix		=	new Matrix();			
			var spreadMethod			:String 	= 	SpreadMethod.PAD;		
			var interpolationMethod		:String		=	InterpolationMethod.LINEAR_RGB;
			var focalPointRatio			:Number		=	0;
			var bgStrokeColor			:int		=	backgroundStrokeColor;
			var bgStrokeThickness		:Number		=	1;
			var bgWidth					:Number		=	_calendarWidth;
			var bgHeight				:Number		=	_calendarHeight;
			
			colorMatrix.createGradientBox(bgWidth,bgHeight,0,0,0);
			
			bg.name 	= 	"background";
			
			bg.graphics.lineStyle(bgStrokeThickness, bgStrokeColor);			
			bg.graphics.beginGradientFill(
			  type,
			  colorArray,
			  alphaArray,
			  ratioArray,
			  colorMatrix,
			  spreadMethod,
			  interpolationMethod,
			  focalPointRatio
			  );
			  
			bg.graphics.drawRect(0,0,_calendarWidth,_calendarHeight);
			bg.graphics.endFill();
			
			calendar.addChild(bg);
			
			/*
			 *	MAKE CURRENT DATE DISPLAY
			 *
			 */
				currentDateLabel		 		= 	new TextField();
				currentDateLabel.embedFonts 	=	embedFonts;
				currentDateLabel.name 			= 	"currentDateLabel";
				currentDateLabel.selectable 	=	false;
				currentDateLabel.width			=	_calendarWidth - (cellWidth * 2) - 10;
				currentDateLabel.height			=	monthAndYearFontSize + 8;
				currentDateLabel.x				=	xOffset + cellWidth;				
				currentDateLabel.y				=	6;
				
			var format:TextFormat 	= 	new TextFormat();
				format.font			=	_font;
				format.color		=	labelColor;
				format.size			=	monthAndYearFontSize;
				format.bold			=	true;
				format.align		= 	"center";
				
			currentDateLabel.defaultTextFormat	=	format;
			currentDateLabel.addEventListener(MouseEvent.CLICK, handleMonthAndYear);
			currentDateLabel.text				=	"";
			
			calendar.addChild(currentDateLabel);
		 
			/**
			 * MAKE WEEK DISPLAY
			 */
			constructWeekNames();
			
			
		/*
		 *	MAKE MONTH CHANGER BUTTONS
		 */
			var nextBtn:Sprite 	= 	makeBtn(90);
				nextBtn.name 	= 	"NextButton";
				nextBtn.x 		= 	_calendarWidth - xOffset;
				nextBtn.y 		= 	3 + currentDateLabel.height / 2;
			var prevBtn:Sprite 	= 	makeBtn(270);
				prevBtn.name 	= 	"PrevButton";
				prevBtn.x 		= 	xOffset; 
				prevBtn.y 		=	10 + currentDateLabel.height / 2;
				
				nextBtn.buttonMode 	= 	true;
				prevBtn.buttonMode	=	true;
				
			nextBtn.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			prevBtn.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			
			calendar.addChild(nextBtn);
			calendar.addChild(prevBtn);
			
			
		/*
		 *	MAKE CALENDAR ENTRIES
		 */	
			prevDate		 =	undefined;
			today			 = 	new Date();
			todaysday		 =	today.getDay();
			currentyear		 =	today.getFullYear();
			currentmonth	 =	today.getMonth();
			_daysInMonth		 =	[31, isLeapYear(currentyear)?29:28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			
			currentDateLabel.text	=	_months[currentmonth]+" - "+currentyear;
			
			constructCalendar();
			
		}
		private function handleMonthAndYear(e:MouseEvent):void 
		{
			e.stopPropagation();
			
			switch(pickState) {
				case DAY:
					currentDateLabel.text = currentyear.toString();
					pickState = MONTH;
					weekname.visible = false;
					removeEntry();
					if (monthPicker==null) {
						monthPicker = new MonthPicker(enabledCellColor, _calendarWidth - 10 - cellGap, _calendarHeight - yOffset - 8);
						monthPicker.addEventListener(Event.CHANGE, setMonth);
						monthPicker.x = xOffset;
						monthPicker.y = yOffset;
						monthPicker.months = _months;
					}
					calendar.addChild(monthPicker);
					break;
					
				case MONTH:
					return;
					//Not completed
					if (calendar.contains(monthPicker)) {
						calendar.removeChild(monthPicker);
					}
					pickState = YEAR;
					weekname.visible = false;
					currentDateLabel.text = currentyear.toString();
					if (yearPicker==null) {
						yearPicker = new YearPicker(_calendarWidth - 10, _calendarHeight - yOffset - 5);
						yearPicker.addEventListener(Event.CHANGE, setYear);
						yearPicker.x = xOffset;
						yearPicker.y = yOffset;
					}
					calendar.addChild(yearPicker);
					break;
					
				case YEAR:
					//Not implemented
					break;
			}
		}
		
		protected function setDay():void {
			
		}
		private function setMonth(e:Event):void 
		{
			
		}
		
		private function setYear(e:Event):void 
		{
			
		}
		
		protected function constructWeekNames():void 
		{
			var format:TextFormat 	= 	new TextFormat();
				format.font			=	_font;
				format.color		=	labelColor;
				format.size			=	monthAndYearFontSize;
				format.bold			=	true;
				format.align		= 	"center";
				format.size			=	weekNameFontSize;
			
			if (weekname && calendar.contains(weekname)) {
				calendar.removeChild(weekname);
			}
			
			weekname	= 	new Sprite();
			weekname.x 	=	xOffset;
			weekname.y 	=	currentDateLabel.y + currentDateLabel.height + xOffset;
			
			if (_startDay == "monday") {
				_startID = 0;
			}else if (_startDay == "sunday") {
				_startID = 1;
			}
			
			var weekNames:Array = weekdisplay[_startID].split("");
			
			for (var i:int = 0; i < 7; i++) {
				var t:TextField = new TextField();
				t.embedFonts  			=	embedFonts;
				t.blendMode     		=	BlendMode.LAYER;
				t.selectable			=	false;				
				t.antiAliasType			= 	AntiAliasType.ADVANCED;
				t.defaultTextFormat		=	format;
				t.text					=	weekNames[i];
				t.width 				=	cellWidth;
				t.height 				=	weekNameFontSize + 6;
				t.x 					=	(cellWidth + cellGap) * i;
				weekname.addChild(t);
			}
			
			calendar.addChild(weekname);
			
			yOffset = weekname.y + weekname.height + xOffset;
			//re-calculate cell height
			cellHeight = ((_calendarHeight - (yOffset + 8) + cellGap) / 6) - cellGap;
		}
		
		public function flush():void 
		{
			if (this.stage != null && calendar != null && this.stage.contains(calendar))
			{
				stage.removeChild(calendar);
			}
			calendar = null;
		}
		public function clickHandler(e:MouseEvent):void{
			
			var factor:int = e.target.name == "PrevButton"? -1:1;
			
			switch(pickState) {
				case DAY:
					changeMonth(factor);
					break;
				case MONTH:
					changeYear(factor);
					currentDateLabel.text = currentyear.toString();
					break;
				case YEAR:
					changeYearGroup(factor);
					currentDateLabel.text = currentyear.toString();
					break;
			}
			
			return;
			
		}
		/*
		 * 	MONTH CHANGER FUNCTION
		 */
		public function changeMonth(factor:int):void {
			if (factor!=1) {
				if (currentmonth > 0) {
					currentmonth = (currentmonth - 1);
				} else {
					changeYear(-1);
				}
			} else {
				if (currentmonth < 11) {
					currentmonth = currentmonth+1;
				} else {
					changeYear(1);
				}
			}
			constructCalendar();
			return;
		}
		/*
		 * 	CHANGE YEAR
		 */
		public function changeYear(factor:int):void {
			currentyear = currentyear + factor;
			if (factor != 1) { currentmonth = 11; } else { currentmonth = 0; }
			_daysInMonth[1] = isLeapYear(currentyear)?29:28;
			return;
		}
		/**
		 * CHANGE YEAR GROUP
		 */
		private function changeYearGroup(factor:int):void {
			
		}
		private function isLeapYear(currentyear:Number):Boolean 
		{
			var yearDev:Number = currentyear / 4;
			var yearDevLength:Number = yearDev.toString().split(".").length;
			return yearDevLength != 1?false:true;
		}
		/*
		 *	CALENDAR CONSTRUCTOR
		 */
		public function constructCalendar():void{
			if(inited){
				removeEntry();				
			}
			
			var dateBox		:DateCell;
			 	cellArray				= 	new Vector.<DateCell>();
			var xpos		:Number		=	xOffset;
			var ypos		:Number		=	yOffset;
			var weekCount	:Number		=	0;
			var endDate		:Date 		=	new Date(currentyear,currentmonth,_startID);			
			var endDay		:Number		=	endDate.getDay();
			var locDate		:Date		=	new Date();
			isToday						=	false;	
			inited 						= 	true;
			
			if ((locDate.getMonth() == currentmonth) && (locDate.getFullYear() == currentyear)) {
				isToday		=	true;
			}
			/*
			 *	CONSTRUCT FIRST SET OF DESABLED CELLS
			 */
			if (endDay > 0) {
				var inc_1:Number = 0;
				while (inc_1 < endDay) {
					dateBox 		= 	createDateCell(disabledCellColor,inc_1,false);
					dateBox.isToday	=	false;
					dateBox.name	=	"D"+inc_1;
					dateBox.x		=	xpos + cellGap;
					dateBox.y		=	ypos + cellGap;
					cellArray.push(dateBox);
				
					calendar.addChild(dateBox);
				
					if (weekCount == 6) {
						weekCount = 0;
						ypos += cellHeight + cellGap;
						xpos = xOffset;
					} else {
						weekCount++;
						xpos += cellWidth + cellGap;
					}					
					inc_1++;
				}
			}
			/*
			 *	CONSTRUCT DATE ENTRY CELLS
			 */			
			var entryNum:int 		= 	1;
			currentDateLabel.text	=	_months[currentmonth]+" - "+currentyear;
			
			var restNum:int = endDay;

			while (restNum < 42) {
				if (entryNum <= _daysInMonth[currentmonth]) {
					if (locDate.getDate()== entryNum && isToday == true) {
						dateBox 		= 	createDateCell(TodayCellColor,entryNum,true);
						dateBox.hitted	=	false;
						dateBox.serial	=	restNum;
						dateBox.date	=	new Date(currentyear,currentmonth,entryNum);
						dateBox.isToday	=	true;
						todayDateBox  	= dateBox;
					}else{
						/*if(dateBox.hitted){
							dateBox 		= 	createDateCell(mouseOverCellColor,entryNum,true);
							dateBox.hitted	=	true;
						}else{*/
							dateBox 		= 	createDateCell(enabledCellColor,entryNum,true);
							dateBox.hitted	=	false;
						//}
						
						dateBox.serial	=	restNum;
						dateBox.date	=	new Date(currentyear,currentmonth,entryNum);
						dateBox.isToday	=	false;
					}
				} else {
			/*
			 *	CONSTRUCT SECOND SET OF DESABLED DATE CELLS 
			 */			
					dateBox 		= 	createDateCell(disabledCellColor,entryNum,false);
					dateBox.isToday	=	false;
				}
				dateBox.name	=	"D"+(restNum + inc_1);
				dateBox.x		=	xpos + cellGap;
				dateBox.y		=	ypos + cellGap;
				cellArray.push(dateBox);
				
				calendar.addChild(dateBox);
				
				if (weekCount == 6) {
					weekCount = 0;
					ypos += cellHeight + cellGap;
					xpos = xOffset;
				} else {
					weekCount++;
					xpos += cellWidth + cellGap;
				}
				restNum++;
				entryNum++;
			}
		}
		public function removeEntry():void {
			if (cellArray && cellArray.length > 0) { 
				for(var i:int=0;i<42;i++){
					if (calendar.contains(cellArray[i])) calendar.removeChild(cellArray[i]);
				}
			}
			cellArray = new Vector.<DateCell>();
		}
		/*
		 *	DATE CELL CONSTRUCTOR FUNCTION [RETURNS MOVIECLIP] 
		 */
		public function createDateCell(cellColor:int, day:int, isEntry:Boolean):DateCell {
			
			var dateCell:DateCell	= 	new DateCell(cellColor, cellWidth, cellHeight);
			
			dateCell.day_txt.embedFonts     = bitmapFonts?true:embedFonts;
			
			var format:TextFormat 			
			
			if (bitmapFonts)
			{
				format			= new BitmapFont().txt.defaultTextFormat;
			}else
			{
				format			=	new TextFormat();
				format.font 	=	_font;
				format.bold 	=	false;
				format.size 	=	dayFontSize;
			}
			
			format.color 		=	entryTextColor;
			format.align		=	"center";
			
			dateCell.day_txt.defaultTextFormat 	=	format;
			
			if(isEntry){
				dateCell.day_txt.text 		=	String(day);
				dateCell.hit.name 	 		= 	"hit";
				dateCell.hit.buttonMode 	=	true;
			}
			
			dateCell.day_txt.x 				= (cellWidth - dateCell.day_txt.width) / 2;
			dateCell.day_txt.y 				= (cellHeight - dateCell.day_txt.height) / 2;
			
			return (dateCell);
		}	
		/*
		 *	CELL COLOR CHANGER 
		 */
		public function changeColor(mc:Sprite,color:uint):void{			
			DateCell(mc).changeColor(color);
		}
		/*
		 * BUTTON GRAPHICS CONSTRUCTOR
		 */
		private function makeBtn(rot:Number):Sprite
		{
			var triangleHeight:uint=6;
			var triangleShape:Sprite = new Sprite();
			var w:Number = cellWidth;
			var h:Number = cellHeight;
			triangleShape.graphics.clear();
			triangleShape.graphics.beginFill(0xffffff, 0);
			triangleShape.graphics.drawRect(-7, 0, w, h);
			triangleShape.graphics.endFill();
			triangleShape.graphics.lineStyle(1,buttonColor);
			triangleShape.graphics.beginFill(buttonColor);
			triangleShape.graphics.moveTo(triangleHeight/2, 5);
			triangleShape.graphics.lineTo(triangleHeight, triangleHeight+5);
			triangleShape.graphics.lineTo(0, triangleHeight+5);
			triangleShape.graphics.lineTo(triangleHeight/2, 5);
			triangleShape.rotation = rot;			
			return(triangleShape);
		}
	}

}
