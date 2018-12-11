package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Power_Speed extends MovieClip
	{
 		private var stageRef:Stage;
		private var target:Ship;
		private var vy:Number;
		private var speed:Number;
		
 
		public function Power_Speed(stageRef:Stage, target:Ship, speed:Number) : void
		{
			this.stageRef = stageRef;
			this.target = target;
			this.x = Math.floor(Math.random() * 10);
			this.y = 0;
			this.vy = speed;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.stageRef = stageRef;
			this.target = target;
 
			x = Math.random() * stageRef.stageWidth;
			y = -5;
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		private function loop(e:Event) : void
		{
			y += vy;
 
			
 
			if (hitTestObject(target.hit))
			{
				target.speedPower();
				removeSelf();
			}
		}
		private function removeSelf() : void {
 
			removeEventListener(Event.ENTER_FRAME, loop);
 
			if (stageRef.contains(this))
				stageRef.removeChild(this);
 
		}
 
		
 
	}
 
}