import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:defector/util/sounds.dart';

class DoorKey extends GameDecoration with Sensor<LittleEvil> {
  bool delivery = false;
  DoorKey({required super.position})
      : super.withSprite(
          size: Vector2.all(16),
          sprite: DecorationSpriteSheet.key,
        );

  @override
  void onContact(LittleEvil component) {
    if (!delivery) {
      delivery = true;
      Sounds.getItem();
      component.iventory.incrementKey();
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}
