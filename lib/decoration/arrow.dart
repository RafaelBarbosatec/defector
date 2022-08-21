import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/weapons/weapons_sprite_sheet.dart';

class Arrow extends GameDecoration with Sensor {
  bool delivery = false;
  Arrow({required super.position})
      : super.withSprite(
          size: Vector2.all(16),
          sprite: WeaponsSpriteSheet.arrowReload,
        );

  @override
  void onContact(GameComponent component) {
    if (component is LittleEvil && !delivery) {
      delivery = true;
      component.iventory.incrementArrow(count: 5);
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}
