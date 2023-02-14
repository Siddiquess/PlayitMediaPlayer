import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/database/player_db.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/player.dart';

class PlayListPopUpVideo extends StatelessWidget {
  PlayListPopUpVideo({
    super.key,
    required this.playlist,
    required this.videoPlayitList,
    required this.index,
  });
  final PlayerModel playlist;
  final Box<PlayerModel> videoPlayitList;
  final int index;

  final TextStyle popupStyle = const TextStyle(color: Colors.white);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> listVideos = [];
    return ValueListenableBuilder(
        valueListenable: Hive.box<PlayerModel>('PlayerDB').listenable(),
        builder: (context, Box<PlayerModel> videos, child) {
          listVideos = videos.values.toList()[index].videoPath;
          return PopupMenuButton<int>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 2,
                child: Text("Rename", style: popupStyle),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Delete", style: popupStyle),
              )
            ],
            // offset: const Offset(0, 50),
            color: const Color.fromARGB(255, 75, 75, 75),
            elevation: 2,
            onSelected: (value) {
              if (value == 2) {
                editVideoPlaylistName(context, playlist, index, listVideos);
              } else if (value == 3) {
                deleteVideoPlayList(context, videoPlayitList, index);
              }
            },
          );
        });
  }

  Future deleteVideoPlayList(
      BuildContext context, Box<PlayerModel> videoList, int index) {
    return showDialog(
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
                      "Delete",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
                videoList.deleteAt(index);

                snackBar(
                    inTotal: 4,
                    width: 2,
                    context: context,
                    content: "Deleted successfully",
                  );
              },
            ),
            const Divider(thickness: 1),
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

  Future editVideoPlaylistName(BuildContext context, PlayerModel data,
      int index, List<String> videoData) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 47, 47),
        children: [
          SimpleDialogOption(
            child: Text(
              "Edit Playlist '${data.name}'",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
                key: formKey,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  controller: textEditingController,
                  maxLength: 15,
                  decoration: InputDecoration(
                    counterStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.7),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, top: 5),
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your playlist name";
                    } else {
                      return null;
                    }
                  },
                )),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  textEditingController.clear();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final name = textEditingController.text.trim();
                    if (name.isEmpty) {
                      return;
                    } else {
                      final playlistName =
                          PlayerModel(name: name, videoPath: videoData);
                      final datas = VideoPlayerListDB.videoPlayerListDB.values
                          .map((e) => e.name.trim())
                          .toList();
                      if (datas.contains(playlistName.name)) {
                        snackBar(
                          context: context,
                          content: "Playlist already exist",
                          width: 2,
                          inTotal: 4,
                        );
                        Navigator.of(context).pop();
                        textEditingController.clear();
                      } else {
                        VideoPlayerListDB.editList(index, playlistName);
                        snackBar(
                          context: context,
                          content: "Playlist updated",
                          width: 2,
                          inTotal: 4,
                        );
                        Navigator.pop(context);
                        textEditingController.clear();
                      }
                    }
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
