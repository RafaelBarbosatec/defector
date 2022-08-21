import 'package:bonfire/bonfire.dart';
import 'package:defector/player/iventory.dart';
import 'package:defector/player/player_spritesheet.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LittleEvil extends SimplePlayer with ObjectCollision, ChangeNotifier {
  late PlayerIventory iventory;
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
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: size * 0.8,
            align: (size * 0.1),
          ),
        ],
      ),
    );
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
    iventory = BonfireInjector.instance.get();
    gameRef.camera.target = null;
    super.onMount();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    super.receiveDamage(attacker, damage, identify);
    notifyListeners();
  }

  @override
  void die() {
    movementByJoystickEnabled = false;
    animation?.playOnce(
      PlayerSpriteSheet.die,
      runToTheEnd: true,
      onFinish: () {
        removeFromParent();
        weapon?.removeFromParent();
      },
    );
    super.die();
  }
}
