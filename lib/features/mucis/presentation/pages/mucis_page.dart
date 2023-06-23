import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;

  // The getters
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer()..setAsset('assets/audio/audio-1.mp3');
        _audioPlayer = AudioPlayer()..setAsset('assets/audio/audio-1.mp3');

  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topRight,
              colors: [Colors.amberAccent, Colors.white]),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return ProgressBar(
                baseBarColor: Colors.amberAccent,
                progressBarColor: Colors.amber,
                thumbColor: Colors.amber.shade800,
                timeLabelTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                progress: positionData?.position ?? Duration.zero,
                buffered: positionData?.bufferPosition ?? Duration.zero,
                total: positionData?.duration ?? Duration.zero,
                onSeek: _audioPlayer.seek,
              );
            },
          ),
          // ignore: unnecessary_null_comparison
          _audioPlayer != null
              ? Control(audioPlayer: _audioPlayer)
              : const SizedBox()
        ]),
      ),
    );
  }
}

class Control extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Control({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final playerState = snapshot.data;
            final isPlaying = playerState!.playing;
            final processingState = playerState.processingState;

            if (isPlaying == false) {
              return IconButton(
                onPressed: audioPlayer.play,
                iconSize: 80,
                color: Colors.black87,
                icon: const Icon(Icons.play_arrow_rounded),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                iconSize: 80,
                color: Colors.black87,
                icon: const Icon(Icons.pause_rounded),
              );
            }
            return IconButton(
              onPressed: () {},
              iconSize: 80,
              color: Colors.black87,
              icon: const Icon(Icons.play_arrow_rounded),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class PositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  PositionData(this.position, this.bufferPosition, this.duration);
}
