package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Enemy extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vy:Number;
		private var ay:Number = .2;
		private var target:Ship;
		private var speed:Number;
 		public var paus:Number;
		public function Enemy(stageRef:Stage, target:Ship, shotSpeed:Number, speed:Number) : void
		{
			stop();
			this.paus=0;
			this.vy=speed;
			this.speed=shotSpeed;
			this.stageRef = stageRef;
			this.target = target;
 
			x = Math.random() * stageRef.stageWidth;
			y = -5;
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		private function loop(e:Event) : void
		{
			if (currentLabel != "destroyed") //ship isn't be destroyed
			{
				if(paus!=1){
				vy += ay;
				y += vy;
				}
				if (y > stageRef.stageHeight)
					removeSelf();
 
				if (y - 15 < target.y && y + 15 > target.y)
					fireWeapon();
			}	
 
			if (currentLabel == "destroyedComplete"){
				if (Math.floor(Math.random() * 6) == 1){
					var powerPick:Number = Math.floor(Math.random() * 8)+1;
					if (powerPick == 1||powerPick == 2||powerPick == 3){
						var lP:Power_Life = new Power_Life(stageRef,target,6);
						trace("PowerUP");
						stageRef.addChild(lP);
					}
					else if (powerPick == 4|| powerPick==5){
						trace("Power Shot");
						var sP:Power_Shot = new Power_Shot(stageRef,target,6);
						stageRef.addChild(sP);
					}
					else if (powerPick == 6|| powerPick==7|| powerPick==8){
						trace("Power Speed");
						var spP:Power_Speed = new Power_Speed(stageRef,target,6);
						stageRef.addChild(spP);
					}
				}
				removeSelf();
			}
		}
 
		private function fireWeapon() : void
		{
			stageRef.addChild(new LaserRed(stageRef, target, x, y, -speed));
			stageRef.addChild(new LaserRed(stageRef, target, x, y, speed));
		}
 
		private function removeSelf() : void {
 
			removeEventListener(Event.ENTER_FRAME, loop);
 
			if (stageRef.contains(this))
				stageRef.removeChild(this);
 
		}
		public function pausE() :void
		{
			this.paus=1;
		}
		public function unPausE() :void
		{
			paus=0;
		}
 
		public function takeHit() : void
		{
			if (currentLabel != "destroyed") //insure we can't keep killing the enemy ship... over and over
			{
				dispatchEvent(new Event("killed")); //our new ship killed event
				rotation = Math.random() * 360;
				gotoAndPlay("destroyed");
			}
		}
 
	}
 
}