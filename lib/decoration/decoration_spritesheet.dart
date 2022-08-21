import 'package:bonfire/bonfire.dart';

class DecorationSpriteSheet {
  static Future<SpriteAnimation> get bomb => SpriteAnimation.load(
        'objects/spritesheet_objects.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.2,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(72, 8),
        ),
      );

  static Future<SpriteAnimation> get explosion => SpriteAnimation.load(
        'effects/spritesheet_effects.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2.all(8),
          texturePosition: Vector2(0, 8),
        ),
      );

  static Future<Sprite> get doorClosed => Sprite.load(
        'objects/spritesheet_objects.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(88, 64),
      );
  static Future<Sprite> get doorOpen => Sprite.load(
        'objects/spritesheet_objects.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(96, 64),
      );

  static Future<Sprite> get key => Sprite.load(
        'objects/spritesheet_objects.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(96, 32),
      );
}
