package nid.ui.controls
{
	
	import fl.core.InvalidationType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
    import flash.display.SimpleButton;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.system.TouchscreenType;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;	
	import caurina.transitions.Tweener;
	import nid.events.CalendarEvent;
	import nid.ui.controls.datePicker.CalendarSkin;
	import nid.ui.controls.datePicker.DateField;
	import nid.ui.controls.datePicker.iconSprite;
	import nid.ui.controls.datePicker.MonthPicker;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class DatePicker extends CalendarSkin {
		
		public function get selectedDate():Date { return _selectedDate; }		
		public function set selectedDate(value:Date):void 
		{ 
			_selectedDate = value;
			if (value == null)
			{
				_prompt = _prompt_bkp;
				dateField.text = _prompt_bkp;
				
				_selectedDate = new Date();
				currentmonth = _selectedDate.getMonth();
				currentyear  = _selectedDate.getFullYear();
				constructCalendar();
				_selectedDate = null;
			}
			else
			{
				currentmonth = _selectedDate.getMonth();
				currentyear  = _selectedDate.getFullYear();
				constructCalendar();
				setDateField(); 
				_prompt = dateField.text;
			}
		}		
		
		public function set font(value:String):void
		{
			_font = value;
			if (currentDateLabel != null)
			{
				var format:TextFormat = currentDateLabel.getTextFormat();
				format.font = _font;
				currentDateLabel.defaultTextFormat = format;
				currentDateLabel.text = currentDateLabel.text;
				constructWeekNames();
				constructCalendar();
			}
		}
		
		public function set months(value:Array):void 
		{
			_months = value;
			if (currentDateLabel != null) currentDateLabel.text	=	_months[currentmonth] + " - " + currentyear;
		}		
		
		public function set days(value:Array):void 
		{ 
			weekdisplay = value; 
			constructWeekNames();
		}
		
		public final function DatePicker() {
			construct();
			dateField = new DateField();
			addChild(dateField);
			calendarIcon = new iconSprite();
			calendarIcon.addEventListener(CalendarEvent.LOADED, update);
			calendarIcon.configIcon(new default_icon());
			addChild(calendarIcon);
			addEventListener(CalendarEvent.UPDATE, update);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			if (_selectedDate == null) {
				_selectedDate = new Date();
			}
			addContextMenuItems();
			construct();
			update(null);
		}
		
		protected function update(e:CalendarEvent):void {
			redraw();
			isHidden = true;
			alwaysShowCalendar = _alwaysShowCalendar;
			
			if (Capabilities.touchscreenType == TouchscreenType.NONE)
			{
				calendarIcon.addEventListener(MouseEvent.CLICK,showHideCalendar);
				calendar.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				calendar.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				calendar.addEventListener(MouseEvent.CLICK, onClick);
			}
			else
			{
				calendar.addEventListener(TouchEvent.TOUCH_TAP, onClick);
				calendarIcon.addEventListener(TouchEvent.TOUCH_TAP, showHideCalendar);
				calendar.addEventListener(TouchEvent.TOUCH_OVER, onOver);
				calendar.addEventListener(TouchEvent.TOUCH_OUT, onOut);
			}
			isInited = true;
		}
		override protected function draw():void 
		{
			redraw();
			super.draw();
		}
		/**
		 * Flash IDE properties
		 */
		/**
		 * Prompt string
		 */
		[Inspectable(defaultValue="Select Date")]
		public function get prompt():String {
			return _prompt;
		}
		public function set prompt(value:String):void {
			if (value == "") {
				_prompt = null;
			} else {
				_prompt = value;
				_prompt_bkp = value;
			}
			invalidate(InvalidationType.STATE);
		}
		/**
		 * Date format
		 */
		[Inspectable(enumeration = "D/M/YY,M/D/YY,YY/M/D,YY/D/M,DD/MM/YYYY,MM/DD/YYYY,YYYY/MM/DD,YYYY/DD/MM", defaultValue = "DD/MM/YYYY", name = "dateFormat")]
		public function set dateFormat(value:String):void
		{
			_dateFormat = value;
			invalidate(InvalidationType.SIZE);
		}
		public function get dateFormat():String
		{
			return _dateFormat;
		}
		/**
		 * Icon Placement 
		 */
		[Inspectable(enumeration="left,right", defaultValue="right", name="iconPlacement")]
		public function set iconPlacement(value:String):void
		{
			_iconPosition = value;
			invalidate(InvalidationType.SIZE);
		}
		public function get iconPlacement():String
		{
			return _iconPosition;
		}
		/**
		 * calendar Placement
		 */
		[Inspectable(enumeration = "left,right,top,bottom,top-left,top-right,bottom-left,bottom-right,manual",
		defaultValue="right", name="calendarPlacement")]
		public function set calendarPlacement(value:String):void
		{
			_calendarPosition = value;
			invalidate(InvalidationType.SIZE);
		}
		public function get calendarPlacement():String
		{
			return _calendarPosition;
		}
		public function set calendarPoint(point:Point):void {
			_calendarPoint = point;
		}
		/**
		 * 
		 */
		protected function redraw():void 
		{
			dateField.text	=	_prompt == null?_prompt_bkp:_prompt;
			relocate();
		}
		protected function relocate():void
		{
			if (iconPlacement == "right")
			{
				dateField.x 	= 0;
				calendarIcon.x 	= dateField.width + 5;
				switch(calendarPlacement)
				{
					case "right":
					{
						_calendarPoint.x = calendarIcon.x + calendarIcon.width + 5;
						_calendarPoint.y = 0;
					}
					break;
					
					case "left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = 0;
					}
					break;
					
					case "top":
					{
						_calendarPoint.x = 0;
						_calendarPoint.y = -(calendar.height + 5);
					}
					break;
					
					case "bottom":
					{
						_calendarPoint.x = 0;
						_calendarPoint.y = dateField.height + 5;
					}
					break;
					
					case "top-left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = -(calendar.height + 5);
					}
					break;
					
					case "top-right":
					{
						_calendarPoint.x = calendarIcon.x + calendarIcon.width + 5;
						_calendarPoint.y = -(calendar.height + 5);
					}
					break;
					
					case "bottom-left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = dateField.height + 5;
					}
					break;
					
					case "bottom-right":
					{
						_calendarPoint.x = calendarIcon.x + calendarIcon.width + 5;
						_calendarPoint.y = dateField.height + 5;
					}
					break;
				}
			}
			else
			{
				calendarIcon.x 	= 0;
				dateField.x 	= calendarIcon.width + 5;
				
				switch(calendarPlacement)
				{
					case "right":
					{
						_calendarPoint.x = dateField.x + dateField.width + 5;
						_calendarPoint.y = 0;
					}
					break;
					
					case "left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = 0;
					}
					break;
					
					case "top":
					{
						_calendarPoint.x = 0;
						_calendarPoint.y = -(calendar.height + 5);
					}
					break;
					
					case "bottom":
					{
						_calendarPoint.x = 0;
						_calendarPoint.y = dateField.height + 5;
					}
					break;
					
					case "top-left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = -(calendar.height + 5);
					}
					break;
					
					case "top-right":
					{
						_calendarPoint.x = dateField.x + dateField.width + 5;
						_calendarPoint.y = dateField.height + 5;
					}
					break;
					
					case "bottom-left":
					{
						_calendarPoint.x = - (calendar.width - 5);
						_calendarPoint.y = dateField.height + 5;
					}
					break;
					
					case "bottom-right":
					{
						_calendarPoint.x = dateField.x + dateField.width + 5;
						_calendarPoint.y = dateField.height + 5;
					}
					break;
				}
			}	
			var pt:Point  = this.localToGlobal(_calendarPoint);
			calendar.x = pt.x;
			calendar.y = pt.y;
		}
		/*
		 *	CONTEXT MENU 
		 * 
		 */
        private function addContextMenuItems():void {
			if(Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn"){
				_contextMenu = new ContextMenu();
				_contextMenu.hideBuiltInItems();
				var menu1:ContextMenuItem;
				var menu2:ContextMenuItem;
				menu1 = null;
				menu1 = new ContextMenuItem("An iGi Lab Production");
				menu2 = new ContextMenuItem("Follow us");			
				menu1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, navigateToSite);
				menu2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, navigateToSite);
				_contextMenu.customItems.push(menu1);
				_contextMenu.customItems.push(menu2);
				this.contextMenu = _contextMenu;
			}
            return;
        }	
        private function navigateToSite(e:ContextMenuEvent):void
        {
           	navigateToURL(new URLRequest("http://www.infogroupindia.com/blog"), "_blank");
            return;
        }
		/**
		 *  Click Handler
		 */
		public function showHideCalendar(e:Event):void {
			if (_alwaysShowCalendar) return;
			if (e.currentTarget == stage) {
				//trace(e.target.name);
				if (e.target.name == "hit" || 
					e.target.name == "currentDateLabel" || 
					e.target.name == "NextButton" || 
					e.target.name == "PrevButton" || 
					e.target == calendarIcon ){					
					//trace(e.currentTarget);				
					return;
				}
			}
			if (isHidden) {
				relocate();
				stage.addChild(calendar);
				Tweener.addTween(calendar, { alpha:1, time:1, transition:"easeOutExpo" } );
				isHidden	=	false;
				try{
					if (hideOnFocusOut) stage.addEventListener(MouseEvent.MOUSE_UP, showHideCalendar);
				}catch (e:Error) {}
			}else {
				Tweener.addTween(calendar, { alpha:0, time:0.5, transition:"easeOutExpo",onComplete:function ():void{ stage.removeChild(calendar); } } );
				isHidden	=	true;
				try{
					if (hideOnFocusOut) stage.removeEventListener(MouseEvent.MOUSE_UP, showHideCalendar);
				}catch (e:Error) {}				
			}
		}
		public function set alwaysShowCalendar(value:Boolean):void
		{
			_alwaysShowCalendar  = value;
			if (value && isHidden)
			{
				isHidden	=	false;
				if (stage != null) stage.addChild(calendar);
				Tweener.addTween(calendar, { alpha:1, time:1, transition:"easeOutExpo" } );
			}
			else if(!value && !isHidden)
			{
				isHidden	=	true;
				if(stage != null && stage.contains(calendar))
					stage.removeChild(calendar);
				calendar.alpha = 0;
			}
		}
		public function onOver(e:Event):void {
			if(!isHidden){
			if(e.target.name == "hit"){
				if(!e.target.parent.hitted)
				changeColor(e.target.parent,mouseOverCellColor);
			}else{
				return;
			}
			}
		}
		public function onOut(e:Event):void {
			if(!isHidden){
			if(e.target.name == "hit"){
				if(!e.target.parent.hitted)
				changeColor(e.target.parent,e.target.parent.color);
			}else{
				return;
			}
			}
		}
		public function onClick(e:Event):void {
			if(!isHidden){
				if (e.target.name == "hit") {
					
					if (e.target.parent.parent.parent is MonthPicker) {
						pickState = DAY;
						weekname.visible = true;
						changeColor(e.target.parent, e.target.parent.color);
						currentmonth = e.target.parent.serial;
						var d:Date 		= 	new Date();
						_selectedDate	=	new Date(currentyear, currentmonth, _selectedDate.date, d.hours, d.minutes, d.seconds, d.milliseconds);
						
						if (calendar.contains(monthPicker)) {
							calendar.removeChild(monthPicker);
						}
						constructCalendar();
						setDateField();
						dispatchEvent(new CalendarEvent(CalendarEvent.CHANGE, _selectedDate));
					}else {
						e.target.parent.hitted		=	true;
						isHitted.status 			=	true;
						isHitted.num				=	e.target.parent.serial;
						if(oldHit){
							cellArray[oldHit].hitted 	= 	false;
							changeColor(cellArray[oldHit],cellArray[oldHit].color);
						}
						oldHit			=	e.target.parent.serial;
						//selectedDate	=	new Date(e.target.parent.date.getDate()+ "/" + (currentmonth + 1) + "/" + currentyear;
						d	= 	new Date();
						_selectedDate	=	new Date(currentyear, currentmonth, e.target.parent.date.getDate(), d.hours, d.minutes, d.seconds, d.milliseconds);
						
						setDateField();
						showHideCalendar(e);
						if(!e.target.parent.isToday){ changeColor(e.target.parent,mouseOverCellColor); }
						dispatchEvent(new CalendarEvent(CalendarEvent.CHANGE, _selectedDate));
					}
					
				}else{
					return;
				}
			}
		}
		public function getDateString():String
		{
			return dateField.text;
		}
		private function setDateField():void
		{
			dateField.text	= "";
			var format:Array = _dateFormat.split("/");
			for (var i:int = 0 ; i < format.length; i++ )
			{
				switch(format[i])
				{
					case "D":format[i] = _selectedDate.getDate(); break;
					case "M":format[i] = (_selectedDate.getMonth() + 1); break;
					case "YY":format[i] = _selectedDate.getFullYear().toString().substr(2,2); break;
					case "DD": {
						format[i] = _selectedDate.getDate().toString();
						format[i] = format[i].length == 1?"0" + format[i]:format[i];
						break;
					}
					case "MM":{
						format[i] = Number(_selectedDate.getMonth() + 1).toString(); 
						format[i] = format[i].length == 1?"0" + format[i]:format[i];
						break;
					}
					case "YYYY":format[i] = _selectedDate.getFullYear(); break;
				}
			}
			for (i = 0 ; i < format.length; i++ )
			{
				dateField.appendText(format[i] + (i < format.length - 1?"/":""));
			}
		}
	}
}