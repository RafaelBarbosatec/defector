import 'package:bonfire/bonfire.dart';
import 'package:defector/widgets/dialog_credits.dart';
import 'package:defector/main.dart';
import 'package:defector/util/sounds.dart';
import 'package:defector/widgets/button.dart';
import 'package:defector/widgets/radio.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Sounds.stopBackgroundSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Defector',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  child: DefectorButton(
                    text: 'Start',
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/game',
                        (_) => false,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: DefectorButton(
                    text: 'Credits',
                    onPressed: () {
                      DialogCredits.show(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DefectorRadio(
                  value: false,
                  group: Game.withJoystick,
                  label: 'Use Keyboard',
                  onChange: (_) {
                    setState(() {
                      Game.withJoystick = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DefectorRadio(
                  value: true,
                  group: Game.withJoystick,
                  label: 'Use screen pads',
                  onChange: (_) {
                    setState(() {
                      Game.withJoystick = true;
                    });
                  },
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'v1.0.0',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (!Game.withJoystick)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 80,
                  width: 150,
                  child: Sprite.load('keyboard_tip.png').asWidget(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
