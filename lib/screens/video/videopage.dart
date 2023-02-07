import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/screens/video/video_list.dart';

import 'folder_videos/folder_video_list.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                // // backgroundColor: Colors.black,
                // systemOverlayStyle: const SystemUiOverlayStyle(
                //   // statusBarColor: Colors.black,
                // ),
                elevation: 0,
                titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                title: const Text('VIDEO'),
                actions: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.history),
                  // ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                snap: true,
                bottom: const TabBar(indicatorColor: Colors.white, tabs: [
                  Tab(child: Text("Video",style:TextStyle(fontSize: 17))),
                  Tab(child: Text("Folder",style:TextStyle(fontSize: 17))),
                ]),
              ),
            ],
            body: const TabBarView(
              children: [
                VideoList(),
                FolderVideoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
