import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/provider/music_buttons/music_buttond_provider.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:provider/provider.dart';
import '../../../database/recent_song_db.dart';

class SongSkipNextButton extends StatelessWidget {
  const SongSkipNextButton({
    Key? key,
    required this.songModel,
    required this.iconSize,
  }) : super(key: key);

  final SongModel songModel;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetRecentSongController>(
      builder: (ctx, recentSong, child) {
        return IconButton(
          iconSize: iconSize,
          onPressed: () {
            if (GetAllSongController.audioPlayer.hasNext) {
              recentSong.addRecentlyPlayed(songModel.id);
              GetAllSongController.audioPlayer.seekToNext();
              context
                  .read<MusicButtonsProvider>()
                  .selectedListTile(songModel.id);
            }
          },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
