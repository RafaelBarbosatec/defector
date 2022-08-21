import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:defector/weapons/weapons_sprite_sheet.dart';

class Bow extends Weapon {
  Bow({
    required super.position,
  }) : super(
          size: Vector2.all(16),
          sprite: WeaponsSpriteSheet.bowInFloor,
        );

  @override
  void update(double dt) {
    if (followerTarget != null) {
      switch ((followerTarget as Movement).lastDirection) {
        case Direction.left:
          followerOffset = Vector2(size.x * -1, 0);
          isFlipHorizontal = true;
          angle = 0;
          break;
        case Direction.right:
          followerOffset = Vector2(size.x, 0);
          isFlipHorizontal = false;
          angle = 0;
          break;
        case Direction.up:
          angle = pi / 2;
          isFlipHorizontal = true;
          followerOffset = Vector2(0, size.y * -1);
          break;
        case Direction.down:
          followerOffset = Vector2(0, size.y);
          isFlipHorizontal = false;
          angle = pi / 2;
          break;
        case Direction.upLeft:
          break;
        case Direction.upRight:
          break;
        case Direction.downLeft:
          break;
        case Direction.downRight:
          break;
      }
    }
    super.update(dt);
  }

  @override
  void onContact(GameComponent component) {
    if (component is LittleEvil) {
      _changeSprite(WeaponsSpriteSheet.bowInHand);
      followerTarget = component;
      component.weapon = this;
    }
  }

  @override
  void onContactExit(GameComponent component) {}

  void _changeSprite(Future<Sprite> newSprite) async {
    sprite = await newSprite;
  }

  @override
  void attack() {
    if (followerTarget != null) {
      simpleAttackRangeByAngle(
        damage: 10,
        angle: (followerTarget as Movement).lastDirection.toRadians(),
        size: size,
        attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
        animation: WeaponsSpriteSheet.arrow.toAnimation(),
        marginFromOrigin: 0,
        speed: 300,
      );
    }
  }
}
