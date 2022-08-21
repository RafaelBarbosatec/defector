import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/decoration_spritesheet.dart';
import 'package:defector/player/little_evil.dart';

class DoorKey extends GameDecoration with Sensor {
  bool delivery = false;
  DoorKey({required super.position})
      : super.withSprite(
          size: Vector2.all(16),
          sprite: DecorationSpriteSheet.key,
        );

  @override
  void onContact(GameComponent component) {
    if (component is LittleEvil && !delivery) {
      delivery = true;
      component.iventory.incrementKey();
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}
