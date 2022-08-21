import 'dart:math';

import 'package:bonfire/bonfire.dart';

class CameraSensor extends GameDecoration with Sensor {
  static const sizeScreen = 320.0;
 
  bool canMove = true;

  CameraSensor({
    required super.position,
    required super.size,
  });

  @override
  void onContact(GameComponent component) {
    if (canMove && component is SimplePlayer) {
      canMove = false;
      final cameraRect = gameRef.camera.cameraRect;
      final diff = component.center - cameraRect.center.toVector2();

      if (diff.x.abs() > diff.y.abs()) {
        if (diff.x < 0) {
          gameRef.camera.moveToPositionAnimated(
            gameRef.camera.position.translate(sizeScreen * -1, 0),
            duration: const Duration(milliseconds: 500),
          );
          component.position.x = left - component.width;
        } else {
          gameRef.camera.moveToPositionAnimated(
            gameRef.camera.position.translate(sizeScreen, 0),
            duration: const Duration(milliseconds: 500),
          );
          component.position.x = right;
        }
      } else {
        if (diff.y < 0) {
          gameRef.camera.moveToPositionAnimated(
            gameRef.camera.position.translate(0, sizeScreen * -1),
            duration: const Duration(milliseconds: 500),
          );
          component.position.y = top - component.height;
        } else {
          gameRef.camera.moveToPositionAnimated(
            gameRef.camera.position.translate(0, sizeScreen),
            duration: const Duration(milliseconds: 500),
          );
          component.position.y = bottom;
        }
      }
    }
  }

  @override
  void onContactExit(GameComponent component) {
    if (component is SimplePlayer) {
      canMove = true;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    final maxSide = min(size.x, size.y);
    final zoom = maxSide / CameraSensor.sizeScreen;
    gameRef.camera.zoom = zoom;
    super.onGameResize(size);
  }
}
