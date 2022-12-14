import 'package:bonfire/bonfire.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:defector/player/little_evil.dart';
import 'package:flutter/material.dart';

class Door extends GameDecoration with ObjectCollision {
  bool showingDialog = false;
  Door({
    required super.position,
  }) : super.withSprite(
          size: Vector2.all(16),
          sprite: DecorationSpriteSheet.doorClosed,
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
  bool onCollision(GameComponent component, bool active) {
    if (component is LittleEvil) {
      if (component.iventory.keyCount > 0) {
        enableCollision(false);
        component.iventory.decrementKey();
        _changeSprite();
      } else if (!showingDialog && collisionConfig?.enable == true) {
        component.idle();
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
    return super.onCollision(component, active);
  }

  void _changeSprite() async {
    sprite = await DecorationSpriteSheet.doorOpen;
    Future.delayed(const Duration(seconds: 1), removeFromParent);
  }
}
