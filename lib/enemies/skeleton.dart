import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/bomb.dart';
import 'package:defector/enemies/enemies_spritesheet.dart';

class Skeleton extends SimpleEnemy with ObjectCollision {
  Skeleton({required super.position})
      : super(
          size: Vector2.all(16),
          animation: SimpleDirectionAnimation(
            idleRight: EnemiesSpriteSheet.skeletonIdle,
            runRight: EnemiesSpriteSheet.skeletonRun,
          ),
          speed: 40,
          life: 50,
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
      seeAndMoveToAttackRange(
        radiusVision: 4 * 16,
        positioned: (player) {
          if (checkInterval('bomb', 2000, dt)) {
            double distance = center.distanceTo(player.center);
            double bombSpeed = distance * 2;
            gameRef.add(
              Bomb(
                position: position,
                angleDirection: BonfireUtil.angleBetweenPoints(
                  center,
                  player.center,
                ),
                speed: bombSpeed,
              ),
            );
          }
        },
      );
    }

    super.update(dt);
  }

  @override
  void die() {
    enableCollision(false);
    animation?.playOnce(
      EnemiesSpriteSheet.skeletonDie,
      onFinish: removeFromParent,
      runToTheEnd: true,
    );
    super.die();
  }
}
