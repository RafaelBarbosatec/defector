import 'package:bonfire/bonfire.dart';
import 'package:defector/spritesheets/enemies_spritesheet.dart';
import 'package:defector/util/sounds.dart';

class Imp extends SimpleEnemy with BlockMovementCollision {
  Imp({required super.position})
      : super(
          size: Vector2.all(16),
          animation: SimpleDirectionAnimation(
            idleRight: EnemiesSpriteSheet.impIdle,
            runRight: EnemiesSpriteSheet.impRun,
          ),
          speed: 30,
          life: 10,
        );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isDead) {
      seeAndMoveToPlayer(
        closePlayer: (p) {
          simpleAttackMelee(
            damage: 10,
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
    animation?.playOnce(
      EnemiesSpriteSheet.impDie,
      onFinish: removeFromParent,
      runToTheEnd: true,
    );
    super.die();
  }
}
