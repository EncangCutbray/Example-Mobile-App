
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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

  final _playlist = ConcatenatingAudioSource(children: [
    ...List.generate(5, (index) {
      int indexSong = index + 1;
      String song =
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$indexSong.mp3';
      return AudioSource.uri(
        Uri.parse(song),
        tag: MediaItem(
          id: '$indexSong',
          title: song,
          artist: 'SoundHelix $indexSong',
          artUri: Uri.parse('https://picsum.photos/300/300?random=$indexSong'),
        ),
      );
    })
  ]);

  @override
  void initState() {
    super.initState();

    /// Single Audio
    /// Uncomment initAudio
    // initAudio();

    /// Multiple Audiod
    initAudioPlayLists();
  }

  Future<void> initAudio() async {
    try {
      _audioPlayer = AudioPlayer();
      // _audioPlayer = AudioPlayer()..setAsset('assets/audio/audio-1.mp3');
      await _audioPlayer.setUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print("Error code: ${e.code}");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all errors
      print(e);
    }
  }

  Future<void> initAudioPlayLists() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer.setLoopMode(LoopMode.all);
      await _audioPlayer.setAudioSource(_playlist);
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print("Error code: ${e.code}");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all errors
      print(e);
    }
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
            colors: [Colors.amberAccent, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final state = snapshot.data;

                  if (state!.sequence.isEmpty) {
                    return const Placeholder(
                      fallbackHeight: 300,
                      fallbackWidth: 300,
                    );
                  }

                  final metaData = state.currentSource!.tag as MediaItem;

                  return MediaMetaData(
                    title: metaData.title,
                    artist: metaData.artist ?? '',
                    imageUrl: metaData.artUri.toString(),
                  );
                }

                return const Center();
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Play Button
                StreamBuilder(
                    stream: _audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final playerState = snapshot.data;
                        final isPlaying = playerState!.playing;
                        final processingState = playerState.processingState;

                        if (isPlaying == false) {
                          return IconButton(
                            onPressed: _audioPlayer.play,
                            iconSize: 36,
                            color: Colors.black87,
                            icon: const Icon(Icons.play_arrow_rounded),
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return IconButton(
                            onPressed: _audioPlayer.pause,
                            iconSize: 36,
                            color: Colors.black87,
                            icon: const Icon(Icons.pause_rounded),
                          );
                        }
                        return IconButton(
                          onPressed: () {},
                          iconSize: 36,
                          color: Colors.black87,
                          icon: const Icon(Icons.play_arrow_rounded),
                        );
                      }

                      return const SizedBox();
                    }),
                // Slider
                StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return Expanded(
                        child: ProgressBar(
                          baseBarColor: Colors.amberAccent,
                          progressBarColor: Colors.amber,
                          thumbColor: Colors.amberAccent,
                          timeLabelLocation: TimeLabelLocation.none,
                          timeLabelTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          progress: positionData?.position ?? Duration.zero,
                          buffered:
                              positionData?.bufferPosition ?? Duration.zero,
                          total: positionData?.duration ?? Duration.zero,
                          onSeek: _audioPlayer.seek,
                        ),
                      );
                    }),
                // Volume Button
                StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) {
                      return IconButton(
                        onPressed: () {},
                        iconSize: 36,
                        color: Colors.black87,
                        icon: const Icon(Icons.volume_down),
                      );
                    }),
              ],
            ),
            Control(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}

class Control extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Control({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          iconSize: 60,
          color: Colors.black87,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        Visibility(
          visible: false,
          child: StreamBuilder(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playerState = snapshot.data;
                  final isPlaying = playerState!.playing;
                  final processingState = playerState.processingState;

                  if (isPlaying == false) {
                    return IconButton(
                      onPressed: audioPlayer.play,
                      iconSize: 60,
                      color: Colors.black87,
                      icon: const Icon(Icons.play_arrow_rounded),
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      onPressed: audioPlayer.pause,
                      iconSize: 60,
                      color: Colors.black87,
                      icon: const Icon(Icons.pause_rounded),
                    );
                  }
                  return IconButton(
                    onPressed: () {},
                    iconSize: 60,
                    color: Colors.black87,
                    icon: const Icon(Icons.play_arrow_rounded),
                  );
                }

                return const SizedBox();
              }),
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          iconSize: 60,
          color: Colors.black87,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}

class MediaMetaData extends StatelessWidget {
  const MediaMetaData({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  final String imageUrl;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 4),
                blurRadius: 4,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          artist,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  PositionData(this.position, this.bufferPosition, this.duration);
}
