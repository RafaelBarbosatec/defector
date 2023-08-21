import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:flutter/material.dart';

class Door extends GameDecoration {
  bool showingDialog = false;
  Door({
    required super.position,
  }) : super.withSprite(
          size: Vector2.all(16),
          sprite: DecorationSpriteSheet.doorClosed,
        );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (isRemoving) {
      return;
    }
    if (other is LittleEvil) {
      if (other.iventory.keyCount > 0) {
        other.iventory.decrementKey();
        _changeSprite();
      } else if (!showingDialog) {
        other.idle();
        showingDialog = true;
        TalkDialog.show(
          talkAlignment: Alignment.center,
          context,
          [
            Say(
              text: [
                const TextSpan(
                  text: 'I think I need a key to get through here ...',
                  style: TextStyle(
                    fontFamily: 'Minecraft',
                  ),
                ),
              ],
            )
          ],
          onClose: () {
            showingDialog = false;
          },
        );
      }
    }
    return super.onCollision(intersectionPoints, other);
  }

  void _changeSprite() async {
    sprite = await DecorationSpriteSheet.doorOpen;
    Future.delayed(const Duration(seconds: 1), removeFromParent);
  }
}
