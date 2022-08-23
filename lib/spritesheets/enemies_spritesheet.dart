import 'package:bonfire/bonfire.dart';

class EnemiesSpriteSheet {
  static Future<SpriteAnimation> get impIdle => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(0, 16),
        ),
      );

  static Future<SpriteAnimation> get impRun => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get impDie => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(32, 16),
        ),
      );

  static Future<SpriteAnimation> get skeletonIdle => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(56, 32),
        ),
      );

  static Future<SpriteAnimation> get skeletonRun => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(72, 32),
        ),
      );

  static Future<SpriteAnimation> get skeletonDie => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(88, 32),
        ),
      );

  static Future<SpriteAnimation> get skullIdle => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(56, 16),
        ),
      );

  static Future<SpriteAnimation> get skullRun => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(72, 16),
        ),
      );

  static Future<SpriteAnimation> get skullDie => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(88, 16),
        ),
      );

  static Future<SpriteAnimation> get bossIdle => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(56, 0),
        ),
      );

  static Future<SpriteAnimation> get bossRun => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(72, 0),
        ),
      );

  static Future<SpriteAnimation> get bossDie => SpriteAnimation.load(
        'characters/spritesheet_characters.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.4,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(88, 0),
        ),
      );
}
