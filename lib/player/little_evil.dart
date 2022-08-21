import 'package:bonfire/bonfire.dart';
import 'package:defector/dialog_game_over.dart';
import 'package:defector/enemies/boss.dart';
import 'package:defector/player/iventory.dart';
import 'package:defector/player/player_spritesheet.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LittleEvil extends SimplePlayer with ObjectCollision, ChangeNotifier {
  late PlayerIventory iventory;
  bool seeBoss = false;
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
    // gameRef.camera.target = null;
    Future.delayed(const Duration(seconds: 1), _talkInitial);
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

  @override
  void onRemove() {
    DialogGameOver.show(context);
    super.onRemove();
  }

  void _talkWithBoss(List<Boss> boss) {
    idle();
    TalkDialog.show(
      context,
      [
        Say(
          text: [
            TextSpan(
              text: 'I finally found you!',
              style: TextStyle(
                fontFamily: 'Minecraft',
              ),
            ),
          ],
        ),
        Say(text: [
          TextSpan(
            text: "I'm tired of following your orders! You will get what you deserve!",
            style: TextStyle(
              fontFamily: 'Minecraft',
            ),
          ),
        ]),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
        LogicalKeyboardKey.enter,
      ],
      onClose: (){
        boss.first.position = boss.first.position.translate(boss.first.width * -1, 0);
      }
    );
  }

  void _talkInitial() {
    idle();
    TalkDialog.show(context, [
      Say(
        header: Container(
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black,
          child: Text(
            'Little devil',
            style: TextStyle(
              fontFamily: 'Minecraft',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        text: [
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
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black,
          child: Text(
            'Little devil',
            style: TextStyle(
              fontFamily: 'Minecraft',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        text: [
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
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black,
          child: Text(
            'Little devil',
            style: TextStyle(
              fontFamily: 'Minecraft',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        text: [
          TextSpan(
            text: 'Time to end it! I will kill him!',
            style: TextStyle(
              fontFamily: 'Minecraft',
            ),
          ),
        ],
      ),
    ], logicalKeyboardKeysToNext: [
      LogicalKeyboardKey.space,
      LogicalKeyboardKey.enter,
    ]);
  }
}
