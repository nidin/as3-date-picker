﻿package nid.ui.controls.datePicker
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import fl.core.UIComponent;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class UIProperties extends UIComponent
	{
		[Embed(source = "./asset/icon.png")]
			private var icon:Class;
		
		public var isInited				:Boolean;
		public var isHidden				:Boolean;
		public var calendarIcon			:iconSprite;		
		public var dateField			:DateField;
		public var myMenu			 	:ContextMenu;
		public var oldHit		 		:* = undefined;	
		public var _font				:String = "Tahoma";		
		public var embedFonts			:Boolean = false;
		public var bitmapFonts			:Boolean = true;
		public var letterSpacing		:Number = 13;
		public var MonthAndYearFontSize	:Number = 12;
		public var WeekNameFontSize		:Number = 12;
		public var DayFontSize			:Number = 10;
		
		protected var _prompt			:String;
		protected var _prompt_bkp		:String = "Select Date";
		protected var _dateFormat		:String = "D/M/Y";
		protected var weekdisplay		:Array;
		protected var weekname			:TextField;
		protected var Days				:Array;
		protected var Months			:Array	= 	["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		protected var _iconPosition		:String = "right";
		protected var _calendarPosition	:String = "right";
		protected var Calendar			:MovieClip;
		protected var CalendarPoint		:Point = new Point();
		protected var _icon				:Bitmap;
		protected var inited			:Boolean	=	false;
		protected var isHitted			:Object;
		protected var cellArray			:Array;
		protected var isToday			:Boolean	=	false;
		protected var DaysinMonth		:Array;
		protected var prevDate			:Number;
		protected var today				:Date;
		protected var todaysday			:Number;
		protected var currentyear		:Number;
		protected var currentmonth		:Number;
		protected var currentDateLabel	:TextField;
		protected var _selectedDate		:Date;
		protected var day_bg			:MovieClip;
		protected var hit				:Sprite;
		protected var day_txt			:TextField;
		protected var _startDay			:String = "sunday";
		protected var _startID			:int = 1;

		/*
		 * COLOR VARIABLES
		 */		
		protected var backgroundColor			:Array	=	[0xFFFFFF,0xDDDDDD];
		protected var backgroundStrokeColor		:int	=	0xA9A9C2;
		protected var labelColor				:int	=	0x000000;
		protected var buttonColor				:int	=	0x000000;
		protected var DesabledCellColor			:int	=	0x999999;
		protected var EnabledCellColor			:int	=	0x000000;
		protected var TodayCellColor			:int	=	0xFF0000;
		protected var mouseOverCellColor		:int	=	0x0099FF;
		protected var entryTextColor			:int	=	0xffffff;

		/*
		 *	CALENDAR DIAMENSIONS VARIABLES		 
		 */	
		protected var calendarWidth			:Number		= 165;
		protected var calendarHeight		:Number		= 178;
		protected var cellWidth				:Number		= 20
		protected var cellHeight			:Number		= 20
		protected var labelWidth			:Number		= 8;
		
		public function UIProperties() 
		{
			_icon = new icon();
		}
		
	}

}