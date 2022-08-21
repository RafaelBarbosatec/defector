import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idle => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
        ),
      );

  static Future<SpriteAnimation> get run => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
            amount: 2,
            stepTime: 0.4,
            textureSize: Vector2.all(8),
            texturePosition: Vector2(16, 0)),
      );

  static Future<SpriteAnimation> get die => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
            amount: 2,
            stepTime: 0.4,
            textureSize: Vector2.all(8),
            texturePosition: Vector2(32, 0)),
      );
}
