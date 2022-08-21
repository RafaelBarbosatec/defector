import 'package:bonfire/bonfire.dart';

abstract class Weapon extends GameDecoration with Follower, Sensor {
  Weapon({
    required super.position,
    required super.size,
    required Future<Sprite> sprite,
  }) : super.withSprite(
          sprite: sprite,
        );

  void attack();

  @override
  void onContact(GameComponent component) {}

  @override
  void onContactExit(GameComponent component) {}
}
