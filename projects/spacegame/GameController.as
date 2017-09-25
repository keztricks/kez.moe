package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	//Main game logic, also controlls some logic for player character.
	public class GameController extends MovieClip{
		
		private var player:Player;
		private var playerScore:int;
		
		private var xMovement, yMovement:Number;
		
		private var bullets:Array;
		private var lastTime:Number;
		private var firing:Boolean;
		
		private var enemies:Array;
		
		private var backgroundOne:Background;
		private var backgroundTwo:Background;
		
		private var level:int;
		private var nextLevelUp;int;
		private var spawnRate:Number;
		private var speedMultiplier:Number;
		
		private var explosionSound:BombSound;
		

		public function GameController() {

		}
		
		// Sets initial variables and starts game, also can reset game (if run after gameOver()).
		public function StartGame() {
			player = new Player();
			player.x = 69;
			player.y = 237.15;
			parent.addChild(player);
			
			firing = false;
			lastTime = getTimer();
			bullets = new Array();
			
			enemies = new Array();
			
			backgroundOne = new Background();
			backgroundTwo = new Background();
			backgroundTwo.x = backgroundOne.width;
			
			parent.addChildAt(backgroundOne, 0);
			parent.addChildAt(backgroundTwo, 0);
			
			level = 1;
			nextLevelUp = 1000;
			spawnRate = 0.05;
			speedMultiplier = 1;
			playerScore = 0;
			
			explosionSound = new BombSound();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			parent.addEventListener(Event.ENTER_FRAME,update);
		}
		
		// Handles key down events for main game.
		private function keyDownHandler(evt:KeyboardEvent):void {
			if (evt.keyCode == 32) {
				firing = true;
			} else if ((evt.keyCode == 37) || (evt.keyCode == 65)) {
				xMovement = -1;
			} else if ((evt.keyCode == 39) || (evt.keyCode == 68)) {
				xMovement = 1;
			}
			
			if ((evt.keyCode == 38) || (evt.keyCode == 87)) {
				yMovement = -1;
			} else if ((evt.keyCode == 40) || (evt.keyCode == 83)) {
				yMovement = 1;
			}
		}
		
		// Handles key up events for main game.
		private function keyUpHandler(evt:KeyboardEvent):void {
			
			if ((evt.keyCode == 37) || (evt.keyCode == 65)) {
				xMovement = 0;
			} else if ((evt.keyCode == 39) || (evt.keyCode == 68)) {
				xMovement= 0;
			} else if ((evt.keyCode == 38) || (evt.keyCode == 87)) {
				yMovement = 0;
			} else if ((evt.keyCode == 40) || (evt.keyCode == 83)) {
				yMovement = 0;
			}
		}
		
		// Runs on every frame, important events for game;
		private function update(evt:Event) {
			
			//************************
			//Player Control
			//************************
			//Updates player location and animation depending on x/yMovement.
			if (xMovement > 0) {
				if (player.x <= 519)
					player.x += 8;
			} else if (xMovement < 0) {
				if (player.x > 32)
					player.x -= 8;	
			} if (yMovement > 0) {
				if (player.y <= 384)
					player.y += 8;
					MovieClip(player).gotoAndStop(2);
			} else if (yMovement < 0) {
				if (player.y > 15)
					player.y -= 8;
					MovieClip(player).gotoAndStop(3);
			} else {
				MovieClip(player).gotoAndStop(1);
			}
			
			//************************
			//Enemy Generation
			//************************
			//Generates new enemies depending on spawn rate.
			
			if (Math.random() < spawnRate / 2) {
				var newEnemy = new QuickEnemy(speedMultiplier);
				enemies.push(newEnemy);
				parent.addChild(newEnemy);
				newEnemy = new SlowEnemy(speedMultiplier);
				enemies.push(newEnemy);
				parent.addChild(newEnemy);
			}
			
			
			//************************
			//Bullet Generation
			//************************
			//Creates new bullets at players location.
			if (firing) {
				var currentTime = getTimer();
	
				if ((currentTime - lastTime) > 300) {
					
					var newBullet = new Bullet(player.x, player.y);
					bullets.push(newBullet);
					parent.addChild(newBullet);
				}
				
				firing = false;
			}
			
			//************************
			//Bullet Updates
			//************************
			//Updates bullets location and removes bullets off screen.
			for (var i = bullets.length - 1; i >= 0; i--) {
				bullets[i].updatePosition();
				
				if (bullets[i].bulletGone()) {
					parent.removeChild(bullets[i]);
					bullets.splice(i,1);
				}
			}
			
			//************************
			//Enemy Update
			//************************
			//Updates enemies location.
			for (i = enemies.length - 1; i >= 0; i--) {
				enemies[i].UpdatePosition();
			}
			
			//************************
			//Background
			//************************
			//Updates location of background for scrolling.
			backgroundOne.x -= 10 * speedMultiplier;
			backgroundTwo.x -= 10 * speedMultiplier;
			if (backgroundOne.x <= -backgroundOne.width) {
				backgroundOne.x = backgroundTwo.x + backgroundTwo.width;
			} else if (backgroundTwo.x <= -backgroundTwo.width) {
				backgroundTwo.x = backgroundOne.x + backgroundOne.width;
			}
			
			txtScore.text = String(playerScore);
			levelUp();
			
			//************************
			//Collision Control
			//************************
			//Checks for collisions.
			
			//Bullet Collision.
			for (var a = bullets.length - 1; a >= 0; a--) {
				for (var b = enemies.length - 1; b >= 0; b--) {
					if (bullets[a].hitTestObject(enemies[b])) {
						playerScore += enemies[b].getValue();
						
						parent.removeChild(bullets[a]);
						parent.removeChild(enemies[b]);
						bullets.splice(a,1);
						enemies.splice(b,1);

						
						break;
					}
				}
			}
			
			//Enemy Collisions.
			for (a = enemies.length - 1; a >= 0; a--) {
				if (player.hitTestObject(enemies[a])) {
					
					explosionSound.play();
					parent.removeChild(player);
					parent.removeChild(enemies[a]);
					
					enemies.splice(a,1);
					
					for (b = enemies.length - 1; b >= 0; b--) {
						parent.removeChild(enemies[b]);
					}
					for (b = bullets.length - 1; b >= 0; b--) {
						parent.removeChild(bullets[b]);
					}
					
					player = null;
					
					gameOver();
					
					break;
				}
			}
			

		}
		
		//Controls difficulty of game, as score increases difficulty gets harder.
		private function levelUp() {
			txtLevel.text = String(level);
			if (playerScore > nextLevelUp && level < 5) {
				level += 1;
				nextLevelUp = nextLevelUp * 2;
				spawnRate = (spawnRate * 5) / 4;
				speedMultiplier = speedMultiplier * 1.5;
			}
			
		}
		
		//Ends and resets game variables. Goes to game over screen.
		private function gameOver() {
			player = null;
			bullets = null;
			enemies = null;
			xMovement = 0;
			yMovement = 0;
			
			parent.removeChild(backgroundOne);
			parent.removeChild(backgroundTwo);
			parent.removeEventListener(Event.ENTER_FRAME,update);
			
			gotoAndStop(3);
			txtLastScore.text = String(playerScore);
		}
}
}