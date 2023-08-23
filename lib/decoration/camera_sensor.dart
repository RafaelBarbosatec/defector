import 'package:bonfire/bonfire.dart';
import 'package:defector/player/little_evil.dart';

class CameraSensor extends GameDecoration with Sensor<LittleEvil> {
  static const sizeScreen = 288.0;

  bool canMove = true;

  CameraSensor({
    required super.position,
    required super.size,
  });

  @override
  void onContact(GameComponent component) {
    if (canMove) {
      canMove = false;
      final cameraRect = gameRef.bonfireCamera.visibleWorldRect;
      final diff = component.center - cameraRect.center.toVector2();
      final camera = gameRef.bonfireCamera;

      if (diff.x.abs() > diff.y.abs()) {
        if (diff.x < 0) {
          camera.moveToPositionAnimated(
            position: camera.position.translated(sizeScreen * -1, 0),
            effectController: EffectController(
              duration: 0.5,
            ),
          );
          component.position.x = left - component.width;
        } else {
          camera.moveToPositionAnimated(
            position: camera.position.translated(sizeScreen, 0),
            effectController: EffectController(
              duration: 0.5,
            ),
          );
          component.position.x = right;
        }
      } else {
        if (diff.y < 0) {
          camera.moveToPositionAnimated(
            position: camera.position.translated(0, sizeScreen * -1),
            effectController: EffectController(
              duration: 0.5,
            ),
          );
          component.position.y = top - component.height;
        } else {
          camera.moveToPositionAnimated(
            position: camera.position.translated(0, sizeScreen),
            effectController: EffectController(
              duration: 0.5,
            ),
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
}
