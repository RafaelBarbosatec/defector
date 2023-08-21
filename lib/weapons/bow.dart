import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/util/sounds.dart';
import 'package:defector/weapons/weapon.dart';
import 'package:defector/weapons/weapons_sprite_sheet.dart';

class Bow extends Weapon {
  bool delivered = false;
  LittleEvil? target;
  Bow({
    required super.position,
  }) : super(
          size: Vector2.all(16),
          sprite: WeaponsSpriteSheet.bowInFloor,
        );

  LittleEvil? get user => target;

  @override
  void update(double dt) {
    followerOffset = Vector2.zero();
    if (user != null) {
      switch (user!.lastDirection) {
        case Direction.left:
          followerOffset = Vector2(0, 0);
          _flipH();
          angle = 0;
          break;
        case Direction.right:
          followerOffset = Vector2(size.x, 0);
          _removeFlipH();
          angle = 0;
          break;
        case Direction.up:
          angle = pi / 2;
          _flipH();
          followerOffset = Vector2(size.x, 0);
          break;
        case Direction.down:
          followerOffset = Vector2(size.x, size.y);
          _removeFlipH();
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
    if (component is LittleEvil && !delivered) {
      delivered = true;
      Sounds.getItem();
      component.setWeapon(this);
      component.iventory.incrementArrow(count: 5);
      
      _changeSprite(WeaponsSpriteSheet.bowInHand);
      target = component;
      setupFollower(target: target);
    }
  }

  @override
  void onContactExit(GameComponent component) {}

  void _changeSprite(Future<Sprite> newSprite) async {
    sprite = await newSprite;
  }

  @override
  void attack() {
    if (user != null) {
      LittleEvil player = user!;

      if (player.iventory.arrowCount > 0) {
        Sounds.bowAttack();
        player.iventory.decrementArrow();
        simpleAttackRangeByAngle(
          damage: 10,
          angle: player.lastDirection.toRadians(),
          size: size,
          attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
          animation: WeaponsSpriteSheet.arrow.toAnimation(),
          marginFromOrigin: -8,
          speed: 300,
          onDestroy: () {
            Sounds.arrowHit();
          },
        );
      }
    }
  }

  void _flipH() {
    if (!isFlippedHorizontally) {
      flipHorizontallyAroundCenter();
    }
  }

  void _removeFlipH() {
    if (isFlippedHorizontally) {
      flipHorizontallyAroundCenter();
    }
  }
}
