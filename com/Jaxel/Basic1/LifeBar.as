package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class LifeBar extends MovieClip
	{
 		private var hits:Number;
		private var stageRef:Stage;
 
		public function LifeBar(stageRef:Stage)
		{
			stop();
			hits =1;
			x = 10;
			y = stageRef.stageHeight - height - 10;
		}
		public function takeHit(value:Number) : void
		{
			width= width-(value)*20;
			if(width-20<=0){
				dispatchEvent(new Event("gameover"));
			}
		}
		public function addHealth(value:Number) : void
		{
			width= width+(value)*20;
		}
 
	}
}