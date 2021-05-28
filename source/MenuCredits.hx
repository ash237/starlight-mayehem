package;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxGradient;
#if windows
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
import lime.utils.Assets;
import flixel.addons.display.FlxBackdrop;
import MainVariables._variables;
import ModifierVariables._modifiers;

using StringTools;

class MenuCredits extends MusicBeatState
{
	var songs:Array<String> = [];
	var titles:Array<String> = [];
	/*
	listen, I'm tired, i came in last second as a programmer and i had to finish this shit in 2 days, let me get away with this one
	*/
	var lazyShit:Alphabet;

	var selector:FlxText;

	public static var curSelected:Int = 0;
	public static var curSelectedInCat:Int = 0;


	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var grpTitles:FlxTypedGroup<Alphabet>;
	private var grpSocials:FlxTypedGroup<Alphabet>;

	private var socialCatagory:Array<Int> = [];
	var socialLink:Array<String> = [];
	var socialNames:Array<String> = [];
	var dumbPersonArray:Array<Int> = [];
	var links:Array<String> = [];
	var icons:Array<String> = [];


	var curCatagory:Int = 0;
	var inCat:Bool = false;
	var realLength:Int = 0;
	var catLength:Int = 0;




	private var curPlaying:Bool = false;

	var bg:FlxSprite = new FlxSprite(-89).loadGraphic(Paths.image('fBG_Main'));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Free_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0,0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Free_Bottom'));
	var boombox:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('Boombox'));

	private var vocals:FlxSound;

	override function create()
	{
		FlxG.game.scaleX = 1;
		FlxG.game.x = 0;
		FlxG.game.scaleY = 1;
		FlxG.game.y = 0;

		var initSocials:Array<String> = [
            "0:discord://media.discordapp.net/attachments/825209772587745281/843957470123786310/unknown.png:0",
			"0:twitter://twitter.com/ah08937536:1",
            "1:youtube://www.youtube.com/channel/UChaHMuFyTKrVnCZpQelxhDQ:0",
			"1:twitter://twitter.com/TheMaskedChris:1",
            "2:youtube://www.youtube.com/channel/UCgfJjMiNGlI7uZu1cVag5NA:0",
            "2:twitter://twitter.com/Cerbera_ssb:1",
            "3:youtube://youtube.com/channel/UCsrWG26gb6HCI8tvimTzm4w:0",
            "4:youtube://youtube.com/channel/UCf6utxAJb8HixJVkWYaymnw:0",
			"5:twitter://twitter.com/mudstepmusic:0",
			"5:youtube://youtube.com/mudstep:1"
        ];

		for (i in 0...initSocials.length)
		{
			var data:Array<String> = initSocials[i].split(':');
			socialCatagory.push(Std.parseInt(data[0]));
			socialNames.push(data[1]);
			socialLink.push(data[2]);
			//I am sorry for being dumb
			dumbPersonArray.push(Std.parseInt(data[3]));
		}
		trace(socialCatagory);
		trace(socialNames);
		links = [
			'//twitter.com/Cerbera_ssb'
		];
		songs = [
			'ash',
			'chris',
			'cerbera',
			'red',
			'miyno',
			'mudstep'
		];
		icons = [
			'ash',
			'chris',
			'cerb',
			'red',
			'miyno',
			'mudstep'
		];
		titles = [
			'programmer',
			'artist',
			'charter',
			'musician',
			'musician',
			'musician'
		];

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
		bg.alpha = 0;

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55FFBDF8, 0xAAFFFDF3], 1, 90, true); 
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		add(side);
		side.y = FlxG.height;
		//side.y = FlxG.height - side.height/3*2;
		side.x = FlxG.width/2 - side.width/2;

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		grpTitles = new FlxTypedGroup<Alphabet>();
		add(grpTitles);

		grpSocials = new FlxTypedGroup<Alphabet>();
		add(grpSocials);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], true, false);
			songText.itemType = "Diagonal";
			songText.targetY = i;
			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
			realLength++;
		}

		for (i in 0...titles.length)
		{
			var songText:Alphabet = new Alphabet(20, 10, titles[i], true, false);
			songText.scale.set(1.3, 1.3);
			songText.y += 20;
			songText.screenCenter(X);
			songText.visible = false;
			grpTitles.add(songText);
			var daIcon:ModIcon = new ModIcon(icons[i]);
			daIcon.sprTracker = songText;
			add(daIcon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		var order:Int = 0;
		for (i in 0...socialNames.length)
		{
			trace(dumbPersonArray[i]);
			var songText:Alphabet = new Alphabet(0, (70 * dumbPersonArray[i]) + 50, socialNames[i], true, false);
			songText.x += 500;
			songText.itemType = "CVertical";
			songText.targetY = dumbPersonArray[i];
			grpSocials.add(songText);
			
			trace(grpSocials.members[i]);
			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));
			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;
			FlxG.stage.addChild(texFel);
			// scoreText.textField.htmlText = md;
			trace(md);
		 */

		super.create();

		FlxTween.tween(bg, { alpha:1}, 0.5, { ease: FlxEase.quartInOut});
		FlxTween.tween(side, { y:FlxG.height - side.height/3*2}, 0.5, { ease: FlxEase.quartInOut});
		FlxG.camera.zoom = 0.6;
		FlxG.camera.alpha = 0;
		FlxTween.tween(FlxG.camera, { zoom:1, alpha:1}, 0.5, { ease: FlxEase.quartInOut});

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				selectable = true;
			});
	}

	var selectedSomethin:Bool = false;
	var selectable:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		checker.x -= -0.27/(_variables.fps/60);
		checker.y -= 0.63/(_variables.fps/60);

		persistentUpdate = persistentDraw = true;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (!selectedSomethin && selectable)
		{
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
				if (inCat) {
					exitCat();
				} else {
				FlxG.switchState(new MainMenuState());
				selectedSomethin = true;
				FlxTween.tween(FlxG.camera, { zoom:0.6, alpha:-0.6}, 0.7, { ease: FlxEase.quartInOut});
				FlxTween.tween(bg, { alpha:0}, 0.7, { ease: FlxEase.quartInOut});
				FlxTween.tween(checker, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
				FlxTween.tween(gradientBar, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});
				FlxTween.tween(side, { alpha:0}, 0.3, { ease: FlxEase.quartInOut});

				#if windows
						DiscordClient.changePresence("Going back!", null);
				#end

				FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume/100);
				}
			}
            var urlString:String = 'https:'+socialLink[grpSocials.members.indexOf(lazyShit)];
			if (accepted)
			{
				if (!inCat) {
					enterCat();
				} else {
				#if linux
				trace(urlString);
				//FlxG.openURL(urlString);
				Sys.command('/usr/bin/xdg-open'+' '+urlString);
				#else
				FlxG.openURL('https:' + socialLink[grpSocials.members.indexOf(lazyShit)]);
				#end
				}
			}
		}
	}
	function enterCat() {
		curSelectedInCat = 0;
		catLength = 0;
		for (i in grpSocials) {
			if (i.visible) {
				catLength++;
			}
		}
		inCat = true;
		changeSelection();
	}
	function exitCat() {
		inCat = false;
		changeSelection();
	}
	function changeSelection(change:Int = 0)
	{

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4*_variables.svolume/100);
		if (inCat) {
			curSelectedInCat += change;

			if (curSelectedInCat < 0)
				curSelectedInCat = catLength - 1;
			if (curSelectedInCat >= catLength)
				curSelectedInCat = 0;
		} else {
			curSelected += change;

			if (curSelected < 0)
				curSelected = realLength - 1;
			if (curSelected >= realLength)
				curSelected = 0;
		}

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		if (inCat) {
			//i am again sorry for being dumb
			var dumbArray:Array<Alphabet> = [];
			for (i in grpSocials) {
				if (socialCatagory[grpSocials.members.indexOf(i)] == curSelected) {
					dumbArray.push(i);
				}
			}
			for (i in dumbArray) {
				if (dumbArray.indexOf(i) == curSelectedInCat) {
					i.alpha = 1;
					lazyShit = i;
				} else {
					i.alpha = 0.6;
				}
			}
		} else {
			for (i in grpSocials) {
				i.alpha = 0.6;
			}
		}
		for (i in grpTitles.members) {
			if (grpTitles.members.indexOf(i) == curSelected) {
				i.visible = true;
			} else {
				i.visible = false;
			}
		}

		for (i in 0...grpSocials.members.length) {
			if (socialCatagory[i] == curSelected) {
				grpSocials.members[i].visible = true;
				trace('ayoo make me visible');
			} else {
				grpSocials.members[i].visible = false;
			}
		}


		#if windows
		// Updating Discord Rich Presence
		switch (FlxG.random.int(0, 5))
		{
			case 0:
				DiscordClient.changePresence("Vibing to " + songs[curSelected] + " for:", null, null, true);
			case 1:
				DiscordClient.changePresence("Sleeping on someone with " + songs[curSelected] + " for:", null, null, true);
			case 2:
				DiscordClient.changePresence("Dreaming about " + songs[curSelected] + " for:", null, null, true);
			case 3:
				DiscordClient.changePresence("Suckling some " + songs[curSelected] + " for:", null, null, true);
			case 4:
				DiscordClient.changePresence("Presenting " + songs[curSelected] + " to myself for:", null, null, true);
			case 5:
					DiscordClient.changePresence("Admiring " + songs[curSelected] + " for:", null, null, true);
		}
		#end
	}

	/*function enterCatagory()
	{
		realLength = 0;
		var order:Int = 1;
		isinCat = true;
		/*grpSocials.clear();
		grpTitles.clear();
		prevSelected = curSelected;
		for (i in 0...socialNames.length) {
			if (socialCatagory[i] == curSelected) {
				var text:Alphabet = new Alphabet(0, (70 * order) + 30, socialNames[i], true, false);
				order++;
				grpSocials.add(text);
				realLength++;
			}
		}
		trace(grpCatagories.length);
		curSelected = 0;
		changeSelection();
	}*/
}
