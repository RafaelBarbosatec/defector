import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/bomb.dart';
import 'package:defector/spritesheets/enemies_spritesheet.dart';
import 'package:defector/util/sounds.dart';
import 'package:defector/widgets/dialog_congrats.dart';

class Boss extends SimpleEnemy with BlockMovementCollision {
  Boss({required super.position})
      : super(
          size: Vector2.all(32),
          animation: SimpleDirectionAnimation(
            idleRight: EnemiesSpriteSheet.bossIdle,
            runRight: EnemiesSpriteSheet.bossRun,
          ),
          speed: 50,
          life: 100,
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
            damage: 30,
            size: size,
            execute: () => Sounds.attackMelee(),
          );
        },
        margin: 4,
        radiusVision: 75,
        notObserved: () {
          seeAndMoveToAttackRange(
            radiusVision: 140,
            positioned: (player) {
              if (checkInterval('bomb', 1000, dt)) {
                double distance = center.distanceTo(player.center);
                double bombSpeed = distance * 1.3;
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
        },
      );
    }
    super.update(dt);
  }

  @override
  void die() {
    animation?.playOnce(
      EnemiesSpriteSheet.bossDie,
      onFinish: removeFromParent,
      runToTheEnd: true,
    );
    super.die();
  }

  @override
  void onRemove() {
    gameRef.player?.idle();
    DialogCongrats.show(context);
    super.onRemove();
  }
}
