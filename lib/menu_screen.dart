import 'package:bonfire/bonfire.dart';
import 'package:defector/dialog_credits.dart';
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
  bool withKeyboard = true;
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
                        arguments: !withKeyboard,
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
                  value: true,
                  group: withKeyboard,
                  label: 'Use Keyboard',
                  onChange: (_) {
                    setState(() {
                      withKeyboard = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DefectorRadio(
                  value: false,
                  group: withKeyboard,
                  label: 'Use screen pads',
                  onChange: (_) {
                    setState(() {
                      withKeyboard = false;
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
          if (withKeyboard)
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
