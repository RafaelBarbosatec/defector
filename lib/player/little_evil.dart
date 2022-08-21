import 'package:bonfire/bonfire.dart';
import 'package:defector/player/player_spritesheet.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:flutter/services.dart';

class LittleEvil extends SimplePlayer {
  Weapon? weapon;
  LittleEvil({
    required super.position,
  }) : super(
          size: Vector2.all(16),
          animation: SimpleDirectionAnimation(
            idleRight: PlayerSpriteSheet.idle,
            runRight: PlayerSpriteSheet.run,
          ),
          speed: 50,
        ) {
    enabledDiagonalMovements = false;
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN &&
        event.id == LogicalKeyboardKey.space.keyId) {
      weapon?.attack();
    }
    super.joystickAction(event);
  }

  @override
  void onMount() {
    gameRef.camera.target = null;
    super.onMount();
  }

  @override
  void die() {
    animation?.playOnce(PlayerSpriteSheet.die, onFinish: removeFromParent);
    super.die();
  }
}
