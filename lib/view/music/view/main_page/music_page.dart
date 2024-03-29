import 'package:flutter/material.dart';
import 'package:playit/core/colors.dart';
import 'package:playit/view/music/view/music_page/albums/albums.dart';
import 'package:playit/view/music/view/music_page/artist/artists.dart';
import 'package:playit/view/music/view/music_page/recent/recent_page.dart';
import 'package:playit/view/music/view/music_page/songs/songs_list_page.dart';
import 'package:playit/view/music/view/search_song/search_song.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.black,
                titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                title: const Text("MUSIC"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                               SearchSongPage(isFavSong: false),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                snap: true,
                bottom: TabBar(
                  
                  indicatorColor: Colors.deepOrange,
                  tabs: [
                    Tab(child: tabNames('Songs')),
                    Tab(child: tabNames('Artist')),
                    Tab(child: tabNames('Albums')),
                    Tab(child: tabNames('Recent')),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              children: [
                SongList(),
                SongArtisPage(),
                SongAlbumsPage(),
                RecentlyPlayedWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tabNames(String tabName) {
    return Text(
      tabName,
      style: const TextStyle(fontSize: 15,color: kWhiteColor),
    );
  }
}
