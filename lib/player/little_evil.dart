import 'package:bonfire/bonfire.dart';
import 'package:defector/enemies/boss.dart';
import 'package:defector/main.dart';
import 'package:defector/player/inventory.dart';
import 'package:defector/spritesheets/player_spritesheet.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:defector/widgets/dialog_game_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LittleEvil extends SimplePlayer
    with BlockMovementCollision, ChangeNotifier {
  late PlayerInventory iventory;
  bool seeBoss = false;
  bool canMove = false;
  Weapon? _weapon;

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
    setupMovementByJoystick(diagonalEnabled: false);
  }

  void setWeapon(Weapon w) {
    _weapon = w;
  }

  bool get containWeapon => _weapon != null;

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: size * 0.8,
        position: size * 0.1,
      ),
    );
    return super.onLoad();
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN &&
        event.id == LogicalKeyboardKey.space.keyId) {
      _weapon?.attack();
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (canMove) {
      super.joystickChangeDirectional(event);
    }
  }

  @override
  void update(double dt) {
    if (!seeBoss) {
      seeComponentType<Boss>(
        observed: (boss) {
          seeBoss = true;
          _talkWithBoss(boss);
        },
        radiusVision: 150,
      );
    }
    super.update(dt);
  }

  @override
  void onMount() {
    iventory = BonfireInjector.instance.get();
    iventory.reset();
    Future.delayed(Duration.zero, _talkInitial);
    super.onMount();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    super.receiveDamage(attacker, damage, identify);
    notifyListeners();
  }

  @override
  void die() {
    animation?.playOnce(
      PlayerSpriteSheet.die,
      runToTheEnd: true,
      onFinish: () {
        removeFromParent();
        _weapon?.removeFromParent();
      },
    );
    super.die();
  }

  @override
  void onRemove() {
    DialogGameOver.show(context);
    super.onRemove();
  }

  void _talkWithBoss(List<Boss> boss) {
    idle();
    TalkDialog.show(context, [
      Say(
        text: const [
          TextSpan(
            text: 'I finally found you!',
            style: TextStyle(
              fontFamily: 'Minecraft',
            ),
          ),
        ],
      ),
      Say(
        text: const [
          TextSpan(
            text:
                "I'm tired of following your orders! You will get what you deserve!",
            style: TextStyle(
              fontFamily: 'Minecraft',
            ),
          ),
        ],
      ),
    ], logicalKeyboardKeysToNext: [
      LogicalKeyboardKey.space,
      LogicalKeyboardKey.enter,
    ], onClose: () {
      boss.first.position =
          boss.first.position.translated(boss.first.width * -1, 0);
    });
  }

  void _talkInitial() {
    idle();
    TalkDialog.show(
      context,
      [
        Say(
          header: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.black,
            child: const Text(
              'Little devil',
              style: TextStyle(
                fontFamily: 'Minecraft',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          text: const [
            TextSpan(
              text: "I can't take this little devil's life anymore!",
              style: TextStyle(
                fontFamily: 'Minecraft',
              ),
            ),
          ],
        ),
        Say(
          header: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.black,
            child: const Text(
              'Little devil',
              style: TextStyle(
                fontFamily: 'Minecraft',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          text: const [
            TextSpan(
              text:
                  'We only harm others and gain nothing in return. Our boss is exploiting us.',
              style: TextStyle(
                fontFamily: 'Minecraft',
              ),
            ),
          ],
        ),
        Say(
          header: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.black,
            child: const Text(
              'Little devil',
              style: TextStyle(
                fontFamily: 'Minecraft',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          text: const [
            TextSpan(
              text: 'Time to end it! I will kill him!',
              style: TextStyle(
                fontFamily: 'Minecraft',
              ),
            ),
          ],
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
        LogicalKeyboardKey.enter,
      ],
      onFinish: () => canMove = true,
    );
  }

  @override
  void onGameResize(Vector2 size) {
    gameRef.bonfireCamera.zoom = getGameZoom(size);
    super.onGameResize(size);
  }
}
