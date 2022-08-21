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
  void die() {
    animation?.playOnce(EnemiesSpriteSheet.skullDie, onFinish: removeFromParent);
    super.die();
  }
}
