import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/decoration_spritesheet.dart';

class Saw extends GameDecoration with Sensor {
  Saw({
    required super.position,
  }) : super.withAnimation(
          size: Vector2.all(16),
          animation: DecorationSpriteSheet.saw,
        );

  @override
  void onContact(GameComponent component) {
    if (component is SimplePlayer) {
      component.receiveDamage(AttackFromEnum.ENEMY, 25, 'Saw');
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}
