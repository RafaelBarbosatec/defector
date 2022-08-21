import 'package:bonfire/bonfire.dart';

class WeaponsSpriteSheet {
  static Future<Sprite> get bowInHand => Sprite.load(
        'objects/bow.png',
        srcSize: Vector2.all(8),
      );

  static Future<Sprite> get bowInFloor => Sprite.load(
        'objects/bow.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(8, 0),
      );

  static Future<Sprite> get arrowReload => Sprite.load(
        'objects/bow.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(16, 0),
      );
  static Future<Sprite> get arrow => Sprite.load(
        'objects/bow.png',
        srcSize: Vector2.all(8),
        srcPosition: Vector2(32, 0),
      );
}
