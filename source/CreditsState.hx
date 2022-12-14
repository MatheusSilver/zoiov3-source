package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['FNF VS. Zoio V3'],
		['XxFrostzNeekoxX',			'frostz',			'Dono da equipe e ideia do mod',				'https://www.youtube.com/channel/UC_f-qYj4Z2AB3pzSlPgvOAw',		0xFF4494E6],
		['BeeMax',				'abelha',			'Divulgador e ideia do mod',							'https://www.youtube.com/c/BeeMaxima',			0xFFFF9300],
		['MateusX02',		'matx02',		'Programador, chromatic Zoio,\nCovers e mais.',					'https://www.youtube.com/channel/UCPh9ueTFJh50NRlF2CLsbbA',	0xFF210264],
		['Matheus Silver',			'silver',		'Programador',				'https://www.youtube.com/c/MatheusSilver',		0xFF545454],
		['fukanzen',				'fuk',			'Artista',						'https://www.youtube.com/channel/UCH9tZ5mILqaSw1EKJm3C2eA',			0xFFD6A6C6],
		['SOMBRA',		'shadow',	'Artista',						'https://open.spotify.com/user/31s6dvosg2kgz5udxg5acha6p7la',	0xFFE0E01F],
		['DCWars',			'dcwars',		'Artista, coder e mais',		'https://www.youtube.com/c/DCwars',		0xFF0617D1],
		['Julitolito',				'julito',		'Ex integrante, ajudou em\nmuita coisa',	'https://twitter.com/oJulitolito',	0xFF4C007B],
		['Nikk Mura',			'nikkmura',			'Ex integrante',					'https://www.youtube.com/channel/UCfuO5pZON_s2tsa7j2epVSQ',			0xFFA72CE5],
		['KadeDev e Tricky Team',		'kadedev',		'Basicamente?',					'https://twitter.com/kade0912',	'0xFFFF0000'],
		['DuckDuckArrows',		'bubba',		'Port base Tricky V2 para a Psych Engine',					'https://www.youtube.com/channel/UCgGOUTghLXFrWXUqL1oQp7A',	'0xFFFFDD33'],
		['Yoisabo',		'nashira',		'Core e Pitro be like',					'https://www.youtube.com/channel/UCgGOUTghLXFrWXUqL1oQp7A',	'0xFF370041'],		
		['Discord',			'discord',			"Discord da nossa equipe.",					'https://discord.gg/rQpcpHpW88',			0xFF2C7CE5],
		[''],
		['Time Psych Engine'],
		['Shadow Mario',		'shadowmario',		'Programador da Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Artista da Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		[''],
		['Contribuidores da Engine'],
		['shubs',				'shubs',			'Programacao do novo input',						'https://twitter.com/yoshubs',			0xFF4494E6],
		['PolybiusProxy',		'polybiusproxy',	'Suporte a .MP4',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		['gedehari',			'gedehari',			'Coisinhas legais no chart editor',				'https://twitter.com/gedehari',			0xFFFF9300],
		['Keoiki',				'keoiki',			'Animacoes de notesplash',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['bubba',				'bubba',		'Compositor de HotDilf',	'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw',	0xFF61536A],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programador do Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animador do Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artista do Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Compositor do Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
