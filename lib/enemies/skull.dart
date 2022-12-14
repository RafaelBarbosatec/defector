import 'package:bonfire/bonfire.dart';
import 'package:defector/spritesheets/enemies_spritesheet.dart';
import 'package:defector/util/sounds.dart';

class Skull extends SimpleEnemy with ObjectCollision {
  Skull({required super.position})
      : super(
          size: Vector2.all(16),
          animation: SimpleDirectionAnimation(
            idleRight: EnemiesSpriteSheet.skullIdle,
            runRight: EnemiesSpriteSheet.skullRun,
          ),
          speed: 40,
          life: 30,
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
  void update(double dt) {
    if (!isDead) {
      seeAndMoveToPlayer(
        closePlayer: (p) {
          simpleAttackMelee(
            damage: 20,
            size: size,
            execute: () => Sounds.attackMelee(),
          );
        },
        margin: 4,
        radiusVision: 48,
      );
    }
    super.update(dt);
  }

  @override
  void die() {
    enableCollision(false);
    animation?.playOnce(
      EnemiesSpriteSheet.skullDie,
      onFinish: removeFromParent,
      runToTheEnd: true,
    );
    super.die();
  }
}
