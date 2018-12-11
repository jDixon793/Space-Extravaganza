package com.Jaxel.Basic1
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class StartScreen extends MovieClip
	{
 
		private var stageRef:Stage;
 
		public function StartScreen(stageRef:Stage)
		{
			this.stageRef = stageRef;
			x = 0;
			y = 0;
		}
		public function unShow() : void
		{
			x=1000;
			y=1000;
 
		}
 
	}
}