package;

import flixel.FlxSprite;

class ModIcon extends FlxSprite
{
	/**
	 * Used by me, don't use it if you're not me
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('credits', 'CJ'), true, 150, 150);

		antialiasing = true;
		animation.add('chris', [0], 0, false, isPlayer);
		animation.add('cerb', [1], 0, false, isPlayer);
		animation.add('ash', [2], 0, false, isPlayer);
		animation.add('miyno', [3], 0, false, isPlayer);
		animation.add('mudstep', [4], 0, false, isPlayer);
		animation.add('fuego', [5], 0, false, isPlayer);
		animation.add('red', [6], 0, false, isPlayer);
		animation.play(char);
		antialiasing = true;
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (sprTracker != null) {
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 40);
			visible = sprTracker.visible;
		}
	}
}
