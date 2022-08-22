import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'bow_attack.wav',
      'arrow_hit.wav',
      'meele_attack.wav',
      'explosion.wav',
      'bg.mp3',
    ]);
  }

  static void bowAttack() {
    FlameAudio.play('bow_attack.wav');
  }

  static void arrowHit() {
    FlameAudio.play('arrow_hit.wav');
  }

  static void attackMelee() {
    FlameAudio.play('meele_attack.wav');
  }

  static void explosion() {
    FlameAudio.play('explosion.wav');
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('bg.mp3', volume: 0.2);
  }

  static void pauseBackgroundSound() {
    if (kIsWeb) return;
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    if (kIsWeb) return;
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    if (kIsWeb) return;
    FlameAudio.bgm.dispose();
  }
}
