import 'package:flutter/material.dart';
import 'package:playit/controller/folder/accsess_folder.dart';
import 'package:playit/view/videos/video/view/video_list_builder.dart';

class FolderVideoInside extends StatefulWidget {
  const FolderVideoInside({super.key, required this.folderPath});
  final String folderPath;

  @override
  State<FolderVideoInside> createState() => _FolderVideoInsideState();
}

class _FolderVideoInsideState extends State<FolderVideoInside> {
  final String _duration = '';
  @override
  void initState() {
    loadVideos(widget.folderPath);
    // getduration();
    super.initState();
  }
  //   getduration() async {
  //   videoDB = await Hive.openBox<AllVideos>('videoplayer');
  //   List<AllVideos> data = videoDB.values.toList();
  //   List<AllVideos> result =
  //       data.where((element) => element.path == widget.folderPath).toList();
  //   if (result.isNotEmpty) {
  //     _duration = result
  //         .where((element) => element.path == widget.folderPath)
  //         .first
  //         .duration;
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderPath.split('/').last),
      ),
      body: ValueListenableBuilder(
        valueListenable: folderVideos,
        builder: (context, List<String> videos, child) {
          if (videos.isEmpty) {
            return const Center(
              child: Text("No video found"),
            );
          }
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              String videoPath = videos[index];
              String videoTitle = videoPath.split('/').last;
              String shorttitle = videoTitle;
              if (videoTitle.length > 19) {
                shorttitle = shorttitle.substring(0, 19);
              }
              // AllVideos? info = videoDB.getAt(index);
              // String duration = info!.duration.split('.').first;
              return VideoListBuilder(
                videoPath: videoPath,
                videoTitle: videoTitle,
                duration: _duration,
                index: index,
                isFoldervideo: true,
              );
            },
          );
        },
      ),
    );
  }
}
