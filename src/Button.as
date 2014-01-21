package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Button extends Sprite 
	{
		
		public function Button() 
		{
			this.mouseChildren = false;
			this.buttonMode = true;
			
			graphics.beginFill(0x62C8FF);
			graphics.drawRect(0, 0, 100, 25);
			graphics.endFill();
			
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat("Tahoma", 12, 0x000000, true, null, null, null, null, "center");
			t.text = "Reset";
			t.width = 100;
			t.height = 25;
			addChild(t);
		}
		
	}

}