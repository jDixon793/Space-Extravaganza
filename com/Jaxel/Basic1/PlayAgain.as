package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class PlayAgain extends MovieClip
	{
 
		private var stageRef:Stage;
		private var sHUD:ScoreHUD;
 
		public function PlayAgain(stageRef:Stage, sHUD:ScoreHUD)
		{
			this.stageRef = stageRef;
 			this.sHUD=sHUD;
			
			x = 1000;
			y = 1000;
		}
 
		public function show() : void
		{
			final_score.text=String(sHUD.s_kills);
			x=25;
			y=100;
 
		}
		public function unShow() : void
		{
			final_score.text="";
			x=1000;
			y=1000;
 
		}
 
	}
}