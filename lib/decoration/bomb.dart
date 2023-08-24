import 'package:bonfire/bonfire.dart';
import 'package:defector/enemies/skeleton.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:defector/util/sounds.dart';

class Bomb extends GameDecoration
    with Movement, HandleForces, BlockMovementCollision, BouncingObject {
  final double angleDirection;
  bool exploded = false;
  Bomb({
    required super.position,
    required this.angleDirection,
    double speed = 120,
  }) : super.withAnimation(
          size: Vector2.all(16),
          animation: DecorationSpriteSheet.bomb,
        ) {
    this.speed = speed;
    addForce(ResistenceForce2D(id: 1, value: Vector2.all(3)));
  }

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  bool onBlockMovement(Set<Vector2> intersectionPoints, GameComponent other) {
    if (other is Skeleton) {
      return false;
    }

    if (other is Player) {
      _explode();
      return false;
    }
    return super.onBlockMovement(intersectionPoints, other);
  }

  @override
  void onMount() {
    moveFromAngle(angleDirection);
    super.onMount();
  }

  void _execExplode() {
    Rect rectExplosion = Rect.fromCenter(
      center: center.toOffset(),
      width: width * 2,
      height: height * 2,
    );
    gameRef.attackables(onlyVisible: true).forEach((e) {
      if (e.toRect().overlaps(rectExplosion)) {
        e.receiveDamage(AttackFromEnum.ENEMY, 30, 'bomb');
      }
    });
    gameRef.bonfireCamera.shake(intensity: 1);
    playSpriteAnimationOnce(
      DecorationSpriteSheet.explosion,
      onFinish: removeFromParent,
    );
    Sounds.explosion();
  }

  void _explode() {
    if (!exploded) {
      exploded = true;
      stopMove();
      _execExplode();
    }
  }
}
