import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class Sounds {
  static bool enabled = true;
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'bow_attack.wav',
      'arrow_hit.wav',
      'meele_attack.wav',
      'explosion.wav',
      'get_item.wav',
      'bg.mp3',
    ]);
  }

  static void getItem() {
    if (!enabled) return;
    FlameAudio.play('get_item.wav');
  }

  static void bowAttack() {
    if (!enabled) return;
    FlameAudio.play('bow_attack.wav');
  }

  static void arrowHit() {
    if (!enabled) return;
    FlameAudio.play('arrow_hit.wav');
  }

  static void attackMelee() {
    if (!enabled) return;
    FlameAudio.play('meele_attack.wav');
  }

  static void explosion() {
    if (!enabled) return;
    FlameAudio.play('explosion.wav');
  }

  static stopBackgroundSound() {
    if (!enabled) return;
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    if (!enabled) return;
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('bg.mp3', volume: 0.2);
  }

  static void pauseBackgroundSound() {
    if (!enabled) return;
    if (kIsWeb) return;
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    if (!enabled) return;
    if (kIsWeb) return;
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    if (!enabled) return;
    if (kIsWeb) return;
    FlameAudio.bgm.dispose();
  }
}
