package nid.ui.controls.datePicker
{

	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.MovieClip;
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
			_startDay = s; 
			if (_startDay == "monday") _startID = 0;
			else if (_startDay == "sunday")_startID = 1;
			weekname.text =	weekdisplay[_startID];
			ConstructCalendar();
		}
		public function set icon(b:Bitmap):void { _icon = b; }		
		public function set setBackgroundColor(color:Array):void { backgroundColor = color; }
		public function set setBackgroundStrokeColor(color:int):void { backgroundStrokeColor = color; }
		public function set setLabelColor(color:int):void { labelColor = color; }
		public function set setButtonColor(color:int):void { buttonColor = color; }
		public function set setDesabledCellColor(color:int):void { DesabledCellColor = color; }
		public function set setEnabledCellColor(color:int):void { EnabledCellColor = color; }
		public function set setTodayCellColor(color:int):void { TodayCellColor = color; }
		public function set setMouseOverColor(color:int):void { mouseOverCellColor = color; }
		public function set setDateColor(color:int):void { entryTextColor = color; }
		
		public function set setCalendarWidth(w:Number):void { calendarWidth = w; }
		public function set setCalendarHeight(h:Number):void { calendarHeight = h; }			
		
		/*
		 * SET FONT SIZE
		 * 
		 */
		public function fontSize(MonthAndYear:Number = 12, WeekName:Number = 12, Day:Number = 10):void {			
			MonthAndYearFontSize = MonthAndYear;
			WeekNameFontSize = WeekName;
			DayFontSize = Day;
		}
		/*
		 * SET GLOW FILTER OF CALENDAR
		 * 
		 */
		public function setGlow(color:uint=0,alpha:Number=0.2,blurX:Number=6,blurY:Number=6,strength:Number=2,quality:int=1,inner:Boolean=false,knockout:Boolean=false):void {
			var filter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
			Calendar.filters = new Array(filter);
		}
		/*
		 *	MAIN
		 * 
		 */
		public function CalendarSkin() {
			
		}
		protected function Construct():void {
			Calendar = new MovieClip();
			isHitted = new Object();
			Calendar.alpha 	= 0;
			Calendar.cacheAsBitmap = true;
			setGlow();
		/*
		 *
		 *  DRAW CALENDAR BACKGROUND
		 *
		 */
			var bg						:Sprite 	= 	new Sprite();
			var type					:String 	= 	GradientType.RADIAL;
			var colorArray				:Array 		= 	backgroundColor;	
			var alphaArray				:Array 		=	[1,1];					
			var ratioArray				:Array		=	[0, 255];				
			var colorMatrix				:Matrix		=	new Matrix();			
			var spreadMethod			:String 	= 	SpreadMethod.PAD;		
			var interpolationMethod		:String		=	InterpolationMethod.LINEAR_RGB;
			var focalPointRatio			:Number		=	0;
			var bgStrokeColor			:int		=	backgroundStrokeColor;
			var bgStrokeThickness		:Number		=	1;
			var bgWidth					:Number		=	calendarWidth;
			var bgHeight				:Number		=	calendarHeight;
			
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
			  
			bg.graphics.drawRect(0,0,calendarWidth,calendarHeight);
			bg.graphics.endFill();
			
			Calendar.addChild(bg);
			
		/*
		 *	MAKE CURRENT DATE DISPLAY
		 *	
		 *
		 */
				currentDateLabel		 		= 	new TextField();
				currentDateLabel.embedFonts 	=	embedFonts;
				currentDateLabel.name 			= 	"currentDateLabel";
				currentDateLabel.autoSize		=	TextFieldAutoSize.CENTER;
				currentDateLabel.selectable 	=	false;
				currentDateLabel.width			=	66;
				currentDateLabel.y				=	6;				
				
			var format:TextFormat 	= 	new TextFormat();
				format.font			=	_font;
				format.color		=	labelColor;
				format.size			=	MonthAndYearFontSize;
				format.bold			=	true;
				
			currentDateLabel.defaultTextFormat	=	format;
			currentDateLabel.text				=	"";
			
		 
		/**
		 * MAKE WEEK DISPLAY
		 */
				format.letterSpacing 			=	letterSpacing;
				format.size						=	WeekNameFontSize;
				weekdisplay						=	["MTWTFSS","SMTWTFS"]
				weekname	 					= 	new TextField();
				weekname.embedFonts  			=	embedFonts;
				weekname.blendMode     			=	BlendMode.LAYER;
				weekname.selectable				=	false;				
				weekname.antiAliasType			= 	AntiAliasType.ADVANCED;
				weekname.defaultTextFormat		=	format;
				if (_startDay == "monday") {
					_startID = 0;
				}else if (_startDay == "sunday") {
					_startID = 1;
				}
				weekname.text					=	weekdisplay[_startID];
				weekname.width					=	165;					
				weekname.x						=	11;
				weekname.y 						=	23;
			
			Calendar.addChild(currentDateLabel);
			Calendar.addChild(weekname);
			
		/*
		 *	MAKE MONTH CHANGER BUTTONS
		 */
			var nextBtn:Sprite 	= 	makeBtn(90);
				nextBtn.name 	= 	"NextButton";
				nextBtn.x 		= 	160; 
				nextBtn.y 		= 	11;
			var prevBtn:Sprite 	= 	makeBtn(270);
				prevBtn.name 	= 	"PrevButton";
				prevBtn.x 		= 	5; 
				prevBtn.y 		=	18;
				
				nextBtn.buttonMode 	= 	true;
				prevBtn.buttonMode	=	true;
				
			nextBtn.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			prevBtn.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			
			Calendar.addChild(nextBtn);
			Calendar.addChild(prevBtn);
			
			
		/*
		 *	MAKE CALENDAR ENTRIES
		 */	
			prevDate		 =	undefined;
			today			 = 	new Date();
			todaysday		 =	today.getDay();
			currentyear		 =	today.getFullYear();
			currentmonth	 =	today.getMonth();
			DaysinMonth		 =	[31, isLeapYear(currentyear)?29:28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			
			currentDateLabel.text	=	Months[currentmonth]+" - "+currentyear;
			
			ConstructCalendar();
			
		}
		public function clickHandler(e:MouseEvent):void{
			switch (e.target.name) {
				case "PrevButton" :
					{
						changeMonth(-1);
						break;
					}
				case "NextButton" :
					{
						changeMonth(1);
						break;
					}
			}
			return;
			
		}
		/*
		 * 	MONTH CHANGER FUNCTION
		 */
		public function changeMonth(monthNum:Number):void {
			if (monthNum!=1) {
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
			ConstructCalendar();
			return;
		}
		/*
		 * 	YEAR CHANGER FUNCTION
		 */
		public function changeYear(yearNum:Number):void {
			currentyear = currentyear + yearNum;
			if (yearNum != 1) { currentmonth = 11; } else { currentmonth = 0; }
			DaysinMonth[1] = isLeapYear(currentyear)?29:28;
			return;
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
		public function ConstructCalendar():void{
			if(inited){
				removeEntry();				
			}
			
			var dateBox		:MovieClip;
			 	cellArray				= 	new Array();
			var xpos		:Number		=	5;
			var ypos		:Number		=	40;
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
					dateBox 		= 	Construct_Date_Element(DesabledCellColor,inc_1,false);
					dateBox.id 		= 	DesabledCellColor;
					dateBox.isToday	=	false;
					dateBox.name	=	"D"+inc_1;
					dateBox.x		=	xpos+2;
					dateBox.y		=	ypos+2;
					cellArray.push(dateBox);
				
					Calendar.addChild(dateBox);
				
					if (weekCount == 6) {
						weekCount = 0;
						ypos += 22;
						xpos = 5;
					} else {
						weekCount++;
						xpos += 22;
					}					
					inc_1++;
				}
			}
			/*
			 *	CONSTRUCT DATE ENTRY CELLS
			 */			
			var entryNum:int 		= 	1;
			currentDateLabel.text	=	Months[currentmonth]+" - "+currentyear;
			
			var restNum:int = endDay;

			while (restNum < 42) {
				if (entryNum <= DaysinMonth[currentmonth]) {
					if (locDate.getDate()== entryNum && isToday == true) {
						dateBox 		= 	Construct_Date_Element(TodayCellColor,entryNum,true);
						dateBox.id 		= 	TodayCellColor;
						dateBox.hitted	=	false;
						dateBox.serial	=	restNum;
						dateBox.date	=	new Date(currentyear,currentmonth,entryNum);
						dateBox.isToday	=	true;						
					}else{
						/*if(dateBox.hitted){
							dateBox 		= 	Construct_Date_Element(mouseOverCellColor,entryNum,true);
							dateBox.hitted	=	true;
						}else{*/
							dateBox 		= 	Construct_Date_Element(EnabledCellColor,entryNum,true);
							dateBox.hitted	=	false;
						//}						
						dateBox.id 		= 	EnabledCellColor;
						
						dateBox.serial	=	restNum;
						dateBox.date	=	new Date(currentyear,currentmonth,entryNum);
						dateBox.isToday	=	false;
					}
				} else {
			/*
			 *	CONSTRUCT SECOND SET OF DESABLED DATE CELLS 
			 */			
					dateBox 		= 	Construct_Date_Element(DesabledCellColor,entryNum,false);
					dateBox.id 		= 	DesabledCellColor;
					dateBox.isToday	=	false;
				}
				dateBox.name	=	"D"+(restNum + inc_1);
				dateBox.x		=	xpos+2;
				dateBox.y		=	ypos+2;
				cellArray.push(dateBox);
				
				Calendar.addChild(dateBox);
				
				if (weekCount == 6) {
					weekCount = 0;
					ypos += 22;
					xpos = 5;
				} else {
					weekCount++;
					xpos += 22;
				}
				restNum++;
				entryNum++;
			}
		}
		public function removeEntry():void{
			for(var i:int=0;i<42;i++){
				Calendar.removeChild(cellArray[i]);
			}
			cellArray = [];
		}
		/*
		 *	DATE CELL CONSTRUCTOR FUNCTION [RETURNS MOVIECLIP] 
		 */
		public function Construct_Date_Element(cellColor:int,day:int,isEntry:Boolean):MovieClip {
				day_bg			= 	new MovieClip();
				hit				= 	new Sprite();
				day_txt			=	new TextField();
				
				day_bg.name	 	= 	"bg";
				day_txt.name 	= 	"txt";
			
			day_bg.graphics.beginFill(cellColor,1);
			day_bg.graphics.drawRect(0,0,cellWidth,cellHeight);
			day_bg.graphics.endFill();
			
			hit.graphics.beginFill(0x000000,0);
			hit.graphics.drawRect(0,0,cellWidth,cellHeight);
			hit.graphics.endFill();				
			
			day_txt.autoSize 		= TextFieldAutoSize.CENTER;
			day_txt.embedFonts      = bitmapFonts?true:embedFonts;
			//day_txt.blendMode      	=	BlendMode.LAYER;
			//day_txt.antiAliasType	= AntiAliasType.ADVANCED;
			day_txt.multiline		= false;
			day_txt.selectable 		= false;
			day_txt.width 			= cellWidth;
			day_txt.x 				= 9;
			day_txt.y 				= 1;
			
			var format:TextFormat 			
			
			if (bitmapFonts)
			{
				format					= new BitmapFont().txt.defaultTextFormat;
			}else
			{
				format					=	new TextFormat();
				format.font 				=	_font;
				format.bold 				=	false;
				format.size 				=	DayFontSize;
			}
			
			format.color 				=	entryTextColor;
			format.align				=	"center";
			
			day_txt.defaultTextFormat 	=	format;
			
			if(isEntry){
				day_txt.text 				=	String(day);
				hit.name 	 				= 	"hit";
				hit.buttonMode 				=	true;
			}
			
			day_bg.addChild(day_txt);
			day_bg.addChild(hit);
			
			return (day_bg);
		}	
		/*
		 *	CELL COLOR CHANGER 
		 */
		public function changeColor(mc:Sprite,color:uint):void{			
			mc.graphics.clear();
			mc.graphics.beginFill(color);
			mc.graphics.drawRect(0,0,20,20);
			mc.graphics.endFill();
		}
		/*
		 * BUTTON GRAPHICS CONSTRUCTOR
		 */
		private function makeBtn(arg2:Number):Sprite
		{
			var triangleHeight:uint=6;
			var triangleShape:Sprite = new Sprite();
			var w:Number = 20;
			var h:Number = 20;
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
			triangleShape.rotation = arg2;			
			return(triangleShape);
		}
	}

}