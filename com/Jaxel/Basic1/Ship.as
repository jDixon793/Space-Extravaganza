package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import com.senocular.utils.KeyObject;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
 
	public class Ship extends MovieClip
	{
 
		private var stageRef:Stage;
		private var key:KeyObject;
		private var speed:Number = 0.9;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.93;
		private var maxspeed:Number = 10;
 		private var fireSpeed:Number=150;
		//fire related variables
		private var fireTimer:Timer; //causes delay between fires
		private var canFire:Boolean = true; //can you fire a laser
 
		public function Ship(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
 
			//setup your fireTimer and attach a listener to it.
			fireTimer = new Timer(fireSpeed, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		public function loop(e:Event) : void
		{
			//keypresses
			if (key.isDown(Keyboard.LEFT))
				vx -= speed;
			else if (key.isDown(Keyboard.RIGHT))
				vx += speed;
			else
				vx *= friction;
 
			if (key.isDown(Keyboard.UP))
				vy -= speed;
			else if (key.isDown(Keyboard.DOWN))
				vy += speed;
			else
				vy *= friction;
 
			if (key.isDown(Keyboard.CAPS_LOCK))
				fireBullet();
 
			//update position
			x += vx;
			y += vy;
 
			//speed adjustment
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
 
			if (vy > maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed;
 
			//ship appearance
			rotation = vx;
			scaleX = (maxspeed - Math.abs(vx))/(maxspeed*4) + 0.75;
 
			//stay inside screen
			if (x > stageRef.stageWidth)
			{
				x = 0;
				vx = vx;
			}
			else if (x < 0)
			{
				x = stageRef.stageWidth;
				
			}
 
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}
 
		}
 
		private function fireBullet() : void
		{
			//if canFire is true, fire a bullet
			//set canFire to false and start our timer
			//else do nothing.
			if (canFire)
			{
				//fire noise
				
				stageRef.addChild(new LaserBlue(stageRef, x + vx, y - 10));
				canFire = false;
				fireTimer.start();
				//fireTimer.delay=10;
			}
 
		}
 
		//HANDLERS
 
		private function fireTimerHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			canFire = true;
		}
		public function takeHit() : void
		{
			dispatchEvent(new Event("hit"));
		}
		public function lifePower() : void
		{
			dispatchEvent(new Event("life"));
		}
		public function resetShot() :void
		{
			fireSpeed=150;
			trace("Reset"+ fireSpeed);
			fireTimer = new Timer(fireSpeed, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
		}
		public function shotPower() : void
		{
			if(fireSpeed>60){
			fireSpeed=fireSpeed-25;
			trace("Fast Shot"+ fireSpeed);
			fireTimer = new Timer(fireSpeed, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
			}
		}
		public function resetSpeed() :void
		{
			maxspeed = 10;
			speed=.9;
		}
		public function speedPower() :void
		{
			maxspeed+=2;
			speed+=.2;
		}
 
	}
 
}