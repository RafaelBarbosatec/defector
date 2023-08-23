import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:defector/player/inventory.dart';
import 'package:defector/player/little_evil.dart';
import 'package:defector/spritesheets/decoration_spritesheet.dart';
import 'package:defector/weapons/weapons_sprite_sheet.dart';
import 'package:flutter/material.dart';

class PlayerInterface extends StatefulWidget {
  final BonfireGame game;
  const PlayerInterface(this.game, {Key? key}) : super(key: key);

  @override
  State<PlayerInterface> createState() => _PlayerInterfaceState();
}

class _PlayerInterfaceState extends State<PlayerInterface> {
  late PlayerInventory iventory;

  @override
  void initState() {
    iventory = BonfireInjector.instance.get();
    (widget.game.player as ChangeNotifier?)?.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    (widget.game.player as ChangeNotifier?)?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LittleEvil? player = widget.game.player as LittleEvil?;
    return Material(
      color: Colors.black.withOpacity(0.6),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (player != null)
              ListenableBuilder(
                listenable: player,
                builder: (context, child) {
                  final size = MediaQuery.of(context).size;
                  final minSide = min(size.width, size.height);
                  final lifePlayer = player.life;
                  double barWidth = minSide / 4;

                  double lifeBar = (lifePlayer / 100) * barWidth;
                  if (lifeBar < 0) {
                    lifeBar = 0;
                  }

                  if (lifeBar > barWidth) {
                    lifeBar = barWidth;
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'HP',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: barWidth,
                        height: 16,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: barWidth - lifeBar),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 8),
            ListenableBuilder(
              listenable: iventory,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: DecorationSpriteSheet.key.asWidget(),
                    ),
                    const SizedBox(width: 6),
                    Transform.translate(
                      offset: const Offset(0, 2),
                      child: Text(
                        ' ${iventory.keyCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: WeaponsSpriteSheet.arrowReload.asWidget(),
                    ),
                    const SizedBox(width: 6),
                    Transform.translate(
                      key: UniqueKey(),
                      offset: const Offset(0, 2),
                      child: Text(
                        ' ${iventory.arrowCount}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _listener() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
