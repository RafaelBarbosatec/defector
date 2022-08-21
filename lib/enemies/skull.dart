import 'package:bonfire/bonfire.dart';
import 'package:defector/enemies/enemies_spritesheet.dart';

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
    seeAndMoveToPlayer(
      closePlayer: (p) {
        simpleAttackMelee(damage: 10, size: size);
      },
      margin: 4,
      radiusVision: 48,
    );
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
