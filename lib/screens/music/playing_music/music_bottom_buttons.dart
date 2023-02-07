import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/music_page/favorite_button/favorite_button.dart';
import '../get_all_songs.dart';

class MusicBottomButtons extends StatefulWidget {
  const MusicBottomButtons({
    super.key,
    required this.favSongModel,
    required this.firstsong,
    required this.lastsong,
    required this.count,
  });
  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongModel favSongModel;

  @override
  State<MusicBottomButtons> createState() => _MusicBottomButtonsState();
}

class _MusicBottomButtonsState extends State<MusicBottomButtons> {
  bool isPlaying = true;
  bool _isShuffling = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _isShuffling == false
                    ? GetAllSongController.audioPlayer
                        .setShuffleModeEnabled(true)
                    : GetAllSongController.audioPlayer
                        .setShuffleModeEnabled(false);
              },
              icon: StreamBuilder<bool>(
                stream:
                    GetAllSongController.audioPlayer.shuffleModeEnabledStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                      _isShuffling = snapshot.data;
                  }
                  if (_isShuffling) {
                    return const Icon(Icons.shuffle_rounded,
                        color: Colors.deepOrange);
                  } else {
                    return const Icon(Icons.shuffle_rounded,
                        color: Colors.white);
                  }
                },
              ),
            ),
            FavoriteButton(songFavorite: widget.favSongModel),
            IconButton(
              onPressed: () {
                GetAllSongController.audioPlayer.loopMode == LoopMode.one
                    ? GetAllSongController.audioPlayer.setLoopMode(LoopMode.all)
                    : GetAllSongController.audioPlayer
                        .setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                stream: GetAllSongController.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data;
                  if (LoopMode.one == loopMode) {
                    return const Icon(Icons.repeat_one,
                        color: Colors.deepOrange);
                  } else {
                    return const Icon(
                      Icons.repeat,
                      color: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.firstsong
                ? const IconButton(
                    iconSize: 40,
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_previous,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  )
                : IconButton(
                    iconSize: 40,
                    onPressed: () {
                      if (GetAllSongController.audioPlayer.hasPrevious) {
                        GetAllSongController.audioPlayer.seekToPrevious();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                  ),
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (GetAllSongController.audioPlayer.playing) {
                        GetAllSongController.audioPlayer.pause();
                      } else {
                        GetAllSongController.audioPlayer.play();
                      }
                      isPlaying = !isPlaying;
                    });
                  },
                  icon: isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  color: Colors.black,
                  iconSize: 30,
                )),
            widget.lastsong
                ? const IconButton(
                    iconSize: 40,
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_next,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ))
                : IconButton(
                    iconSize: 40,
                    onPressed: () {
                      if (GetAllSongController.audioPlayer.hasNext) {
                        GetAllSongController.audioPlayer.seekToNext();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    )),
          ],
        ),
      ],
    );
  }
}