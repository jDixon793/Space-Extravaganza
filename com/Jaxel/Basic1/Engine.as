package com.Jaxel.Basic1
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import com.senocular.utils.KeyObject;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
 
 
	public class Engine extends MovieClip
	{
		private var paus=0;
		private var shotSpeed:Number;
		private var speed:Number;
		private var rate:Number;
 		private var eBulletTimer:Timer;
		private var eSpeedTimer:Timer;
		private var rateTimer:Timer;
		private var numStars:int = 80;
		public static var enemyList:Array = new Array();
		private var ourShip:Ship;
 		private var scoreHUD:ScoreHUD;
		private var lB:LifeBar;
		private var control=0;
		private var pAgain:PlayAgain;
		private var key:KeyObject;
		private var sScreen:StartScreen;
		public function Engine() : void
		{
			shotSpeed=8;
			speed=4;
			rate=100;
			sScreen= new StartScreen(stage);
			eBulletTimer = new Timer(20000, 100);
			eBulletTimer.addEventListener(TimerEvent.TIMER, shotFaster, false, 0, true);
			eBulletTimer.start();
			eSpeedTimer = new Timer(20000, 100);
			eSpeedTimer.addEventListener(TimerEvent.TIMER, goFaster, false, 0, true);
			eSpeedTimer.start();
			rateTimer = new Timer(20000, 100);
			rateTimer.addEventListener(TimerEvent.TIMER, moreEnemy, false, 0, true);
			rateTimer.start();
			key = new KeyObject(stage)
			ourShip = new Ship(stage);
			stage.addChild(ourShip);
			ourShip.x = stage.stageWidth / 2;
			ourShip.y = stage.stageHeight / 2;
			lB = new LifeBar(stage);
			scoreHUD = new ScoreHUD(stage,lB);
			pAgain = new PlayAgain(stage,scoreHUD);
			stage.addChild(scoreHUD);
			stage.addChild(pAgain);
			stage.addChild(lB);
			stage.addChild(sScreen);
			lB.addEventListener("gameover", gameOver, false, 0, true); 
 
			for (var i:int = 0; i < numStars; i++)
			{
				stage.addChild(new Star(stage));
			}
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			ourShip.addEventListener("hit",shipHit,false,0,true);
			ourShip.addEventListener("life",shipLife,false,0,true);
 
		}
		private function loop(e:Event) : void
		{
			
			/*if(key.isDown(Keyboard.SPACE)&&(control==3)){
				for (var o:int = 0; o < Engine.enemyList.length; o++)
				{
					trace(Engine.enemyList[o].paus=0);
					control=1;
				}
				
			}
			else if(key.isDown(Keyboard.SPACE)&&(control!=2||control!=0)){
				for (var i:int = 0; i < Engine.enemyList.length; i++)
				{
					trace("boo");
					trace(Engine.enemyList[i].paus=1);
					control=3;
				}
				
			}*/
			
			if (key.isDown(Keyboard.SPACE)&&control==2){
				shotSpeed=8;
				speed=4;
				rate=100;
				stage.removeChild(lB);
				stage.removeChild(scoreHUD);
				stage.removeChild(pAgain);
				control=1;
				lB = new LifeBar(stage);
				lB.addEventListener("gameover", gameOver, false, 0, true); 
				scoreHUD = new ScoreHUD(stage,lB);
				pAgain = new PlayAgain(stage,scoreHUD);
				stage.addChild(scoreHUD);
				stage.addChild(lB);
				stage.addChild(pAgain);
				ourShip.resetShot();
				ourShip.resetSpeed();
			}
			if (key.isDown(Keyboard.SPACE)&&control==0){
				control=1;
				sScreen.unShow();
			}
			if(control==1){
				game();
			}
			if(control==2){
				playAgain();
			}
			if(control==3){
				pScreen();
			}
			
		}
		private function pScreen(): void
		{
			trace("Paused");
		}
		private function game() : void
		{
			if (Math.floor(Math.random() * rate) == 1||Math.floor(Math.random() * rate) == 2||Math.floor(Math.random() * rate) == 3)
			{
				var enemy:Enemy = new Enemy(stage, ourShip,shotSpeed,speed);
				enemy.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy, false, 0, true);
				enemy.addEventListener("killed", enemyKilled, false, 0, true); 
				enemyList.push(enemy);
				stage.addChild(enemy);
			}
		}
		private function playAgain() :void
		{
			if(pAgain.x!=10){
			pAgain.show();
			}
		}
		private function enemyKilled(e:Event) : void
		{
			
			scoreHUD.updateKills(1);
		}
 
		private function removeEnemy(e:Event) : void
		{
			enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
		}
 
		private function shipHit(e:Event) : void
		{
			scoreHUD.updateHits(1); 
			lB.takeHit(2);
		}
		private function shipLife(e:Event) : void
		{
			lB.addHealth(4);
		}
		private function gameOver(e:Event){
			trace("you killed "+scoreHUD.s_kills);
			
			control=2;
			
			trace("dead");
		}
		private function shotFaster(e:TimerEvent) : void
		{
			shotSpeed= shotSpeed+1;
			trace(shotSpeed);
		}
		private function goFaster(e:TimerEvent) : void
		{
			speed= speed+1;
			trace(speed);
		}
		private function moreEnemy(e:TimerEvent) : void
		{
			rate= rate-5;
			trace("Rate of get:"+rate);
		}
 
	}
 
}