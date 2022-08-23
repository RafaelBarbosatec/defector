import 'package:bonfire/bonfire.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:defector/util/sounds.dart';
import 'package:flutter/material.dart';

class Bomb extends GameDecoration with Movement, Acceleration {
  final double angleDirection;
  bool explosed = false;
  Bomb({
    required super.position,
    required this.angleDirection,
    double speed = 120,
  }) : super.withAnimation(
          size: Vector2.all(16),
          animation: DecorationSpriteSheet.bomb,
        ) {
    this.speed = speed;
  }

  @override
  void update(double dt) {
    if (speed == 0 && !explosed) {
      explosed = true;
      playSpriteAnimationOnce(
        DecorationSpriteSheet.bomb,
        onFinish: _explose,
      );
    }
    super.update(dt);
  }

  @override
  void onMount() {
    applyAccelerationByAngle(-2, angleDirection, stopWhenSpeedZero: true);
    super.onMount();
  }

  void _explose() {
    Rect rectExplosion = Rect.fromCenter(
      center: center.toOffset(),
      width: width * 2,
      height: height * 2,
    );
    gameRef.visibleAttackables().forEach((e) {
      if (e.toRect().overlaps(rectExplosion)) {
        e.receiveDamage(AttackFromEnum.ENEMY, 30, 'bomb');
      }
    });
    gameRef.camera.shake(intensity: 2);
    playSpriteAnimationOnce(
      DecorationSpriteSheet.explosion,
      onFinish: removeFromParent,
    );
    Sounds.explosion();
  }
}
