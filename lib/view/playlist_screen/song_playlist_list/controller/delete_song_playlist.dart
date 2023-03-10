import 'package:flutter/material.dart';
import 'package:playit/controller/database/music_playlist_db_controller.dart';
import 'package:provider/provider.dart';
import '../../../../controller/database/video_favorite_db.dart';

class DeleteSongPlaylist {
  // ---------- Edit song playlist
  static deletePlayList(
    BuildContext context,
    int index,
  ) {
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
                Provider.of<MusicPlaylistDbController>(context,listen: false)
                    .deletePlaylist(index);


                snackBar(
                  inTotal: 4,
                  width: 3,
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
}
