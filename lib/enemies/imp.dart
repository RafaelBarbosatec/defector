import 'package:bonfire/bonfire.dart';
import 'package:defector/enemies/enemies_spritesheet.dart';

class Imp extends SimpleEnemy with ObjectCollision {
  Imp({required super.position})
      : super(
          size: Vector2.all(16),
          animation: SimpleDirectionAnimation(
            idleRight: EnemiesSpriteSheet.impIdle,
            runRight: EnemiesSpriteSheet.impRun,
          ),
          speed: 25,
          life: 10,
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
      closePlayer: (p) {},
      margin: 4,
    );
    super.update(dt);
  }

  @override
  void die() {
    animation?.playOnce(EnemiesSpriteSheet.impDie, onFinish: removeFromParent);
    super.die();
  }
}
