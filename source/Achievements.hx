import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Hidden achievement
		["Frigorifico do Pedro",	"Play on a Friday... Night.",							 true],
		["ALEK?",		"Beat Week 1 on Hard with no Misses.",					false],
		["Sem truques",				"Beat Week 2 on Hard with no Misses.",					false],
		["Me chame de Hitman",			"Beat Week 3 on Hard with no Misses.",					false],
		["Assassina",					"Beat Week 4 on Hard with no Misses.",					false],
		["Natal com traumas",			"Beat Week 5 on Hard with no Misses.",					false],
		["Preso no videogame!",					"Beat Week 6 on Hard with no Misses.",					false],
		["Voce vai pagar por isso...",		"Beat Week 7 on Hard with no Misses.",					true],
		["Disastre Funkin'!",	"Complete uma música com uma nota de menos de 20%.",		false],
		["Perfeicao!",				"Faça FC em uma música qualquer.",				false],
		["Psicopata",			"Watch the Henchmen die over 100 times.",				false],
		["Cordas vocais?",		"Segure uma nota por 20 segundos.",						false],
		["Hiperativo",					"Termine uma música sem pose de Idle.",					false],
		["Somente dois de nos.",			"Termine uma música apertando 2 setas.",				false],
		["Torradeira Gamer",				"Você tentou rodar isso em uma torradeira?",			false],
		["Debugger",					"Beat the \"Test\" Stage from the Chart Editor.",		 true],
		["Deus Gamer",				"Passou Zapurgation FC no Hard sem Cheats",			false],
	];

	public static var achievementsUnlocked:Array<Dynamic> = [ //Save string and Achievement tag + is it unlocked?
		['friday_night_play', false],	//0
		['week1_nomiss', false],		//1
		['week2_nomiss', false],		//2
		['week3_nomiss', false],		//3
		['week4_nomiss', false],		//4
		['week5_nomiss', false],		//5
		['week6_nomiss', false],		//6
		['week7_nomiss', false],		//7
		['ur_bad', false],				//8
		['ur_good', false],				//9
		['roadkill_enthusiast', false],	//10
		['oversinging', false],			//11
		['hype', false],				//12
		['two_keys', false],			//13
		['toastie', false],				//14
		['debugger', false], 			//15
		['foda', false], //cu
	];

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(id:Int):Void {
		FlxG.log.add('Completed achievement "' + achievementsStuff[id][0] +'"');
		achievementsUnlocked[id][1] = true;
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsUnlocked != null) {
				FlxG.log.add("Trying to load stuff");
				var savedStuff:Array<String> = FlxG.save.data.achievementsUnlocked;
				for (i in 0...achievementsUnlocked.length) {
					for (j in 0...savedStuff.length) {
						if(achievementsUnlocked[i][0] == savedStuff[j]) {
							achievementsUnlocked[i][1] = true;
						}
					}
				}
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}

		// You might be asking "Why didn't you just fucking load it directly dumbass??"
		// Well, Mr. Smartass, consider that this class was made for Mind Games Mod's demo,
		// i'm obviously going to change the "Psyche" achievement's objective so that you have to complete the entire week
		// with no misses instead of just Psychic once the full release is out. So, for not having the rest of your achievements lost on
		// the full release, we only save the achievements' tag names instead. This also makes me able to rename
		// achievements later as long as the tag names aren't changed of course.

		// Edit: Oh yeah, just thought that this also makes me able to change the achievements orders easier later if i want to.
		// So yeah, if you didn't thought about that i'm smarter than you, i think

		// buffoon
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	public function new(x:Float = 0, y:Float = 0, id:Int = 0) {
		super(x, y);

		if(Achievements.achievementsUnlocked[id][1]) {
			loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
			animation.add('icon', [id], 0, false, false);
			animation.play('icon');
		} else {
			loadGraphic(Paths.image('lockedachievement'));
		}
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(id:Int, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
		achievementIcon.animation.add('icon', [id], 0, false, false);
		achievementIcon.animation.play('icon');
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}