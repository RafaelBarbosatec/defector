import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/decoration_spritesheet.dart';
import 'package:defector/player/little_evil.dart';

class Door extends GameDecoration with ObjectCollision {
  Door({
    required super.position,
  }) : super.withSprite(
          size: Vector2.all(16),
          sprite: DecorationSpriteSheet.doorClosed,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: size),
        ],
      ),
    );
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is LittleEvil) {
      if (component.iventory.keyCount > 0) {
        enableCollision(false);
        component.iventory.decrementKey();
        _changeSprite();
      }
    }
    return super.onCollision(component, active);
  }

  void _changeSprite() async {
    sprite = await DecorationSpriteSheet.doorOpen;
    Future.delayed(const Duration(seconds: 1), removeFromParent);
  }
}
