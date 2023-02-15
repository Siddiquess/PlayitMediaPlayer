import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/popup_menu.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/song_playlist_list.dart';

class NewMuciPlaylist extends StatelessWidget {
  const NewMuciPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final musicHivebox = Hive.box<PlayItSongModel>('songplaylistDb');

    return ValueListenableBuilder(
      valueListenable: musicHivebox.listenable(),
      builder: (context, Box<PlayItSongModel> musicList, child) {
        return musicHivebox.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 10,
                child: const Center(
                  child: Text(
                    "No Song Playlist",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final data = musicList.values.toList()[index];
                  final itemCount = data.songId.length;
                  String songCount =
                      itemCount < 2 ? "$itemCount Song" : '$itemCount Songs';
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.library_music,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(data.name),
                    subtitle: Text(songCount),
                    trailing: PlayListPopUpMusic(
                      playlist: data,
                      musicPlayitList: musicList,
                      index: index,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SongPlayListList(
                            playList: data,
                            listIndex: index,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
