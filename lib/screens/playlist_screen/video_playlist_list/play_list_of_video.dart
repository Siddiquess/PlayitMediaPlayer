import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/player.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/video_playlist_list.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/video_popup_menu.dart';

class PlaylistOfVideo extends StatelessWidget {
  const PlaylistOfVideo({super.key});

  @override
  Widget build(BuildContext context) {
    final videoHivebox = Hive.box<PlayerModel>('PlayerDB');
    
    return ValueListenableBuilder(
      valueListenable: videoHivebox.listenable(),
      builder: (context, Box<PlayerModel> videoList, child) {

        return videoHivebox.isEmpty?
        SizedBox(
          height: MediaQuery.of(context).size.height*2/10,
          child:const Center(
            child: Text('No Video Playlist'),
          ),
        )
        : ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            final data = videoList.values.toList()[index];
            final itemCount = data.videoPath.length;
            String videoCount =
                itemCount < 2 ? '$itemCount Video' : '$itemCount Videos';
            return ListTile(
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Icon(
                    Icons.video_collection_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(data.name),
              subtitle: Text(videoCount),
              trailing: PlayListPopUpVideo(
                playlist: data,
                videoPlayitList: videoList,
                index: index,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return VideoPlayListList(
                    playList: data,
                    listIndex: index,
                  );
                },
              )),
            );
          },
        );
      },
    );
  }
}
