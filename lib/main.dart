import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/camera_sensor.dart';
import 'package:defector/enemies/imp.dart';
import 'package:defector/enemies/skeleton.dart';
import 'package:defector/enemies/skull.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/weapons/bow.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Game(),
    );
  }
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxSide = min(size.width, size.height);
    final zoom = maxSide / CameraSensor.sizeScreen;
    return BonfireTiledWidget(
      joystick: Joystick(keyboardConfig: KeyboardConfig()),
      map: TiledWorldMap(
        'map/m1.tmj',
        forceTileSize: const Size(16, 16),
        objectsBuilder: {
          'sensor': (prop) => CameraSensor(
                position: prop.position,
                size: prop.size,
              ),
          'bow': (prop) => Bow(
                position: prop.position,
              ),
          'imp': (prop) => Imp(
                position: prop.position,
              ),
          'skeleton': (prop) => Skeleton(
                position: prop.position,
              ),
          'skull': (prop) => Skull(
                position: prop.position,
              ),
        },
      ),
      player: LittleEvil(position: Vector2.all(32)),
      cameraConfig: CameraConfig(
        zoom: zoom,
      ),
    );
  }
}
