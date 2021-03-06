﻿package nid.ui.controls.datePicker
{
	import fl.core.UIComponent;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class UIProperties extends UIComponent
	{
		[Embed(source = "./asset/icon.png")]
		protected var default_icon:Class;
		
		protected const DAY:String 		= "DAY";
		protected const MONTH:String 	= "MONTH";
		protected const YEAR:String 	= "YEAR";
		
		public var isInited				:Boolean;
		public var isHidden				:Boolean;
		public var calendarIcon			:iconSprite;		
		public var dateField			:DateField;
		public var _contextMenu		 	:ContextMenu;
		public var oldHit		 		:int;	
		public var _font				:String = "Tahoma";
		public var embedFonts			:Boolean = false;
		public var bitmapFonts			:Boolean = true;
		public var letterSpacing		:Number = 13;
		public var monthAndYearFontSize	:Number = 12;
		public var weekNameFontSize		:Number = 12;
		public var dayFontSize			:Number = 10;
		public var hideOnFocusOut		:Boolean = true;
		public var _alwaysShowCalendar	:Boolean = false;
		
		protected var _prompt			:String;
		protected var _prompt_bkp		:String = "Select Date";
		protected var _dateFormat		:String = "DD/MM/YYYY";
		protected var weekname			:Sprite;
		protected var _days				:Array;
		protected var weekdisplay		:Array	=	["MTWTFSS","SMTWTFS"]
		protected var _months			:Array	= 	["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		protected var _iconPosition		:String = "right";
		protected var _calendarPosition	:String = "right";
		protected var calendar			:Sprite;
		protected var _calendarPoint	:Point = new Point();
		protected var inited			:Boolean	=	false;
		protected var isHitted			:Object;
		protected var cellArray			:Vector.<DateCell>;
		protected var isToday			:Boolean	=	false;
		protected var _daysInMonth		:Array;
		protected var prevDate			:Number;
		protected var today				:Date;
		protected var todaysday			:Number;
		protected var currentyear		:Number;
		protected var currentmonth		:Number;
		protected var currentDateLabel	:TextField;
		protected var _selectedDate		:Date;
		protected var _startDay			:String = "sunday";
		protected var _startID			:int = 1;
		protected var todayDateBox		:DateCell;
		protected var pickState			:String = DAY;
		protected var monthPicker		:MonthPicker;
		protected var yearPicker		:YearPicker;
		
		/*
		 * COLOR VARIABLES
		 */		
		protected var backgroundColor			:Array	=	[0xFFFFFF,0xDDDDDD];
		protected var backgroundGradientType	:String	=	GradientType.RADIAL;
		protected var backgroundStrokeColor		:int	=	0xA9A9C2;
		protected var labelColor				:int	=	0x000000;
		protected var buttonColor				:int	=	0x000000;
		protected var disabledCellColor			:int	=	0x999999;
		protected var enabledCellColor			:int	=	0x000000;
		protected var TodayCellColor			:int	=	0xFF0000;
		protected var mouseOverCellColor		:int	=	0x0099FF;
		protected var entryTextColor			:int	=	0xffffff;

		/*
		 *	CALENDAR DIAMENSIONS VARIABLES		 
		 */	
		protected var _calendarWidth		:int		= 165;
		protected var _calendarHeight		:int		= 178;
		protected var cellWidth				:int		= 20;
		protected var cellHeight			:int		= 20;
		protected var xOffset				:int		= 5;
		protected var yOffset				:int		= 40;
		protected var cellGap				:int		= 2;
		protected var labelWidth			:int		= 8;
		
		public function UIProperties() 
		{
			
		}
	}

}