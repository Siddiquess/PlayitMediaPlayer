import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/music/songbottom_sheet/add_to_playlist.dart';
import 'package:playit/screens/music/songbottom_sheet/details_song.dart';
import 'package:provider/provider.dart';
import '../../../database/song_favorite_db.dart';
import '../../../database/video_favorite_db.dart';
import '../get_all_songs.dart';
import '../music_page/songs/song_list_builder.dart';
import '../playing_music/playing_music.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({
    super.key,
    required this.songTitle,
    required this.artistName,
    required this.songModel,
    required this.songFavorite,
    required this.count,
    required this.index,
    this.isPLaylist = false,
    this.playList,
    this.isFavor = false,
  });
  final String songTitle;
  final String? artistName;
  final List<SongModel> songModel;
  final SongModel songFavorite;
  final int count;
  final int index;
  final bool isPLaylist;
  final dynamic playList;
  final bool isFavor;

  @override
  State<SongBottomSheet> createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          songBottomSheet(
              context: context,
              songTitle: widget.songTitle,
              artistName: widget.artistName,
              songModel: widget.songModel,
              songFavorite: widget.songFavorite,
              count: widget.count,
              index: widget.index,
              isVisible: widget.isPLaylist,
              playList: widget.playList,
              isFavor: widget.isFavor);
        },
        icon: const Icon(Icons.more_vert));
  }

  void songBottomSheet(
      {required context,
      required songTitle,
      required artistName,
      required List<SongModel> songModel,
      required SongModel songFavorite,
      required index,
      count = 0,
      required isVisible,
      required playList,
      required isFavor}) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            songTitle,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Consumer<GetRecentSongController>(
                      builder: (context, recentSong, child){
                        return ListTile(
                          leading: const Icon(
                            Icons.play_arrow_rounded,
                            size: 37,
                            color: Color.fromARGB(255, 21, 21, 21),
                          ),
                          title: bottomText("Play"),
                          onTap: () {
                            recentSong.addRecentlyPlayed(
                                songModel[index].id);
                            GetAllSongController.audioPlayer.setAudioSource(
                                GetAllSongController.createSongList(songModel),
                                initialIndex: index);
                            GetAllSongController.audioPlayer.play();
                            Navigator.of(context).pop();
                            setState(() {
                              selectedIndex =
                                  songModel[index].id; // update the selected index
                              isPlayingSong = true;
                              bodyBottomMargin = 50;
                            });

                          },
                        );
                      }
                    ),
                    FavoriteDb.isFavor(songFavorite)
                        ? ListTile(
                            leading: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 27,
                              ),
                            ),
                            title: bottomText(
                              "Added To Favorite",
                            ),
                            onTap: () {
                              setState(() {
                                FavoriteDb.delete(songFavorite.id);
                                FavoriteDb.favoriteSongs.notifyListeners();
                              });
                              if (isFavor) {
                                Navigator.pop(context);
                              }
                            },
                          )
                        : ListTile(
                            leading: bottomIcon(Icons.favorite_border_outlined),
                            title: bottomText("Add To Favorite"),
                            onTap: () {
                              setState(() {
                                FavoriteDb.add(songFavorite);
                              });

                              snackBar(
                                context: context,
                                content: "Song added to favorite",
                                width: 3,
                                inTotal: 5,
                              );
                            },
                          ),
                    ListTile(
                      leading: bottomIcon(Icons.playlist_add),
                      title: bottomText("Add To Playlist"),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToPlaylist(
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                    SongDetails(
                      artistName: artistName,
                      songModel: songFavorite,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: ListTile(
                        leading: bottomIcon(Icons.delete),
                        title: bottomText("Delete"),
                        onTap: () {
                          Navigator.pop(context);
                          showdialog(widget.playList, songModel, index);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }

  Widget bottomText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget bottomIcon(icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Icon(
        icon,
        size: 27,
        color: const Color.fromARGB(255, 21, 21, 21),
      ),
    );
  }

  bottomStyle() {
    return TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 21, 21, 21),
    );
  }

  showdialog(
    PlayItSongModel playlist,
    List<SongModel> songPlaylist,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Remove from playlist",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                playlist.deleteData(songPlaylist[index].id);
                snackBar(
                  inTotal: 4,
                  width: 3,
                  context: context,
                  content: "Deleted successfully",
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
