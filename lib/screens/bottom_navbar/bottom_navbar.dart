import 'package:flutter/material.dart';
import 'package:playit/screens/music/music_page/songs/now_playint_bottom_sheet.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import 'package:playit/screens/music/music_page/songs/songs_list_page.dart';
import 'package:playit/screens/playlist_screen/play_list-page.dart';
import 'package:playit/screens/video/videopage.dart';
import '../music/music_page.dart';
import '../settings/settings_page.dart';


class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int pageindex = 0;
  static const List<Widget> pages = [
    VideoPage(),
    MusicPage(),
    PlayList(),
    SettingsPage(),
  ];

  changePage(int index) {
    setState(() {
      pageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: IndexedStack(
          index: pageindex,
          children: pages,
        ),
        bottomSheet:  const NowPlayingBottomSheet(),
        // BottomNavBarScreen.pages.elementAt(pageindex),
        resizeToAvoidBottomInset: true,

        bottomNavigationBar: NavigationBar(
          selectedIndex: pageindex,
          backgroundColor: Colors.white,
          // surfaceTintColor: Colors.amber,
          onDestinationSelected: (value) => changePage(value),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.play_circle), label: 'Video'),
            NavigationDestination(icon: Icon(Icons.headphones), label: 'Music'),
            NavigationDestination(
                icon: Icon(Icons.queue_music), label: 'Playlist'),
            NavigationDestination(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),

        // bottomNavigationBar:
        // BottomNavigationBar(
        //     onTap: (index) => changePage(index),
        //     selectedItemColor: Colors.blue,
        //     unselectedItemColor: Colors.grey,
        //     showUnselectedLabels: true,
        //     currentIndex: pageindex,
        //     selectedFontSize: 12,
        //     items: const [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.play_arrow), label: 'Video'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.music_note), label: 'Music'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.playlist_add), label: 'Playlist'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.settings), label: 'Settings'),
        //     ]),
      ),
    );
  }
}
