import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  AudioPlayer winPlayer = AudioPlayer();
  AudioPlayer clickPlayer = AudioPlayer();

  String cheeringAudio = "audios/cheering.mp3";
  String losingAudio = "audios/losing.mp3";
  String clickAudio = "audios/click.wav";

  Future<void> playWinAudio(bool hasWon) async {
    await winPlayer.play(AssetSource(hasWon ? cheeringAudio : losingAudio));
  }

  Future<void> playClickAudio() async {
    await clickPlayer.play(AssetSource(clickAudio));
  }

  void disposePlayer() async {
    await winPlayer.stop();
    await winPlayer.dispose();
    await clickPlayer.dispose();
  }
}
