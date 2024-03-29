import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/controller/music/music_tile_controller.dart';
import 'package:playit/controller/database/song_favorite_db.dart';
import 'package:playit/controller/database/video_favorite_db.dart';
import 'package:playit/model/player.dart';
import 'package:playit/controller/music/get_all_songs_controller.dart';
import 'package:playit/view/splash_screen/splash_screen.dart';
import '../../model/playit_media_model.dart';
import 'package:provider/provider.dart';

class ResetApp {
  static Future<void> resetApp(context) async {
    final songFavorite = Hive.box<int>('SongFavoriteDB');
    final videoFavorite = Hive.box<String>('VideoFavoriteDataB');
    final recentSong = Hive.box('recentSongNotifier');
    final songPlaylist = Hive.box<PlayItSongModel>('songPlaylistDb');
    final videoPlaylist = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    final videoPlaylistItems = Hive.box<VideoPlayListItem>('VideoListItemsBox');
    final allVideoinfo = Hive.box<AllVideos>('videoplayer');
    final allVideoPlaylist = Hive.box<PlayerModel>('PlayerDB');
    await songFavorite.clear();
    await videoFavorite.clear();
    await recentSong.clear();
    await songPlaylist.clear();
    await videoPlaylist.clear();
    await videoPlaylistItems.clear();
    await allVideoinfo.clear();
    await allVideoPlaylist.clear();
    Provider.of<MusicFavController>(context, listen: false).clear();
    VideoFavoriteDb.videoFavoriteDb.clear();
    GetAllSongController.audioPlayer.pause();

    await Provider.of<MusicTileController>(context, listen: false)
        .removeSelectedMusicTile();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }
}
