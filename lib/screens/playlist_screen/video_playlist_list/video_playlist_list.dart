import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/main.dart';
import 'package:playit/model/player.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';
import '../../../model/playit_media_model.dart';
import 'add_videos_playlist.dart';

class VideoPlayListList extends StatefulWidget {
  const VideoPlayListList({
    super.key,
    required this.playList,
    required this.listIndex,
  });
  final PlayerModel playList;
  final int listIndex;

  @override
  State<VideoPlayListList> createState() => _VideoPlayListListState();
}

class _VideoPlayListListState extends State<VideoPlayListList> {
  @override
  Widget build(BuildContext context) {
    List<String> allListVideos;
    return ValueListenableBuilder(
      valueListenable: Hive.box<PlayerModel>('PlayerDB').listenable(),
      builder: (context, Box<PlayerModel> videoPlaylistItems, child) {
        allListVideos = videoPlaylist(
            videoPlaylistItems.values.toList()[widget.listIndex].videoPath);
        // final temp = items.reversed.toList();
        // final videoPlaylistItems = temp.toSet().toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.playList.name),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddVideosToPlayList(
                              playlist: widget.playList,
                      ),
                        ));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: allListVideos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No videos here.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0)),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddVideosToPlayList(
                                playlist: widget.playList,
                           ),
                          ),
                        ),
                        child: const Text("ADD VIDEOS"),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: allListVideos.length,
                  itemBuilder: (context, index) {
                    String videoPath = allListVideos[index];
                    String videoTitle = videoPath.split('/').last;
                    String shorttitle = videoTitle;
                    if (videoTitle.length > 19) {
                      shorttitle = shorttitle.substring(0, 19);
                    }
                    AllVideos? info = videoDB.getAt(index);
                    String duration = info!.duration.split('.').first;

                    return VideoListBuilder(
                      videoPath: videoPath,
                      videoTitle: shorttitle,
                      duration: duration,
                      index: index,
                      isPlaylist: true,
                    );
                  },
                ),
        );
      },
    );
  }

  List<String> videoPlaylist(List<String> data) {
    List<String> testVideos = [];
    for (int i = 0; i < accessVideosPath.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (accessVideosPath[i] == data[j]) {
          testVideos.add(accessVideosPath[i]);
        }
      }
    }
    return testVideos;
  }
}
