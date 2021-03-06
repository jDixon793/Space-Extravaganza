﻿package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class LaserBlue extends MovieClip
	{
 
		private var stageRef:Stage;
		private var bulletSpeed:Number = 16;
 
		public function LaserBlue (stageRef:Stage, x:Number, y:Number) : void
		{
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		private function loop(e:Event) : void
		{
			//move bullet up
			y -= bulletSpeed;
 
			if (y < 0)
				removeSelf();
			for (var i:int = 0; i < Engine.enemyList.length; i++)
			{
				if (hitTestObject(Engine.enemyList[i].hit))
				{
					trace("hitEnemy");
					Engine.enemyList[i].takeHit();
					removeSelf();
				}
			}
		}
 	
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
 
			if (stageRef.contains(this))
					stageRef.removeChild(this);
		}
		
 
	}
 
}