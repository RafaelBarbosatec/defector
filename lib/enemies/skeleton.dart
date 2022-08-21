import 'package:bonfire/bonfire.dart';
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
  void die() {
    animation?.playOnce(
      EnemiesSpriteSheet.skeletonDie,
      onFinish: removeFromParent,
    );
    super.die();
  }
}
