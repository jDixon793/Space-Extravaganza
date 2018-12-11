package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
 
	public class ScoreHUD extends MovieClip
	{
 
		private var stageRef:Stage;
		private var lB:LifeBar;
		public var s_hits:Number = 0;
		public var s_kills:Number = 0;
 
		public function ScoreHUD(stageRef:Stage, lB:LifeBar)
		{
 
			this.stageRef = stageRef;
			kills.text = "0";
			hits.text = "0";
 			this.lB=lB;
			x = 10;
			y = stageRef.stageHeight - height - 10;
 
		}
 
		public function updateKills(value:Number) : void
		{
			s_kills += value;
			kills.text = String(s_kills);
		}
 
		public function updateHits(value:Number) : void
		{
			s_hits += value;
			hits.text = String(s_hits);
		}
 

 
	}
 
}