import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:defector/decoration/arrow.dart';
import 'package:defector/decoration/camera_sensor.dart';
import 'package:defector/decoration/door.dart';
import 'package:defector/decoration/key.dart';
import 'package:defector/decoration/saw.dart';
import 'package:defector/enemies/boss.dart';
import 'package:defector/enemies/imp.dart';
import 'package:defector/enemies/skeleton.dart';
import 'package:defector/enemies/skull.dart';
import 'package:defector/interface/player_interface.dart';
import 'package:defector/menu_screen.dart';
import 'package:defector/player/inventory.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/util/sounds.dart';
import 'package:defector/weapons/bow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BonfireInjector.instance.putSingleton((i) => PlayerInventory());
  Sounds.initialize();
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
        fontFamily: 'Minecraft',
      ),
      routes: {
        '/': (_) => const MenuScreen(),
        '/game': (context) => const Game(),
      },
    );
  }
}

class Game extends StatelessWidget {
  static bool withJoystick = false;
  const Game({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxSide = min(size.width, size.height);
    Joystick joy = Joystick(
      keyboardConfig: KeyboardConfig(),
    );
    if (withJoystick) {
      joy = Joystick(
        directional: JoystickDirectional(color: Colors.grey),
        actions: [
          JoystickAction(
            actionId: LogicalKeyboardKey.space.keyId,
            margin: const EdgeInsets.all(40),
            color: Colors.grey,
          )
        ],
      );
    }
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: maxSide,
          height: maxSide,
          child: BonfireWidget(
            joystick: joy,
            map: WorldMapByTiled(
              'map/m1.tmj',
              forceTileSize: Vector2(16, 16),
              objectsBuilder: {
                'sensor': (prop) => CameraSensor(
                      position: prop.position,
                      size: prop.size,
                    ),
                'bow': (prop) => Bow(position: prop.position),
                'imp': (prop) => Imp(position: prop.position),
                'skeleton': (prop) => Skeleton(position: prop.position),
                'skull': (prop) => Skull(position: prop.position),
                'arrow': (prop) => Arrow(position: prop.position),
                'door': (prop) => Door(position: prop.position),
                'key': (prop) => DoorKey(position: prop.position),
                'saw': (prop) => Saw(position: prop.position),
                'boss': (prop) => Boss(position: prop.position),
              },
            ),
            player: LittleEvil(position: Vector2.all(48)),
            cameraConfig: CameraConfig(
              moveOnlyMapArea: true,
              zoom: getGameZoom(MediaQuery.of(context).size.toVector2()),
              startFollowPlayer: false,
            ),
            overlayBuilderMap: {
              'player_interface': ((context, game) => PlayerInterface(game))
            },
            initialActiveOverlays: const ['player_interface'],
            progress: const Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  'Loading',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            onReady: (game) {
              // Sounds.playBackgroundSound();
            },
            onDispose: () {
              // Sounds.stopBackgroundSound();
            },
          ),
        ),
      ),
    );
  }
}

double getGameZoom(Vector2 size) {
  final maxSide = min(size.x, size.y);
  return maxSide / CameraSensor.sizeScreen;
}
