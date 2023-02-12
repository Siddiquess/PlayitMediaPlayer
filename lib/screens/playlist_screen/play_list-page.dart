import 'package:flutter/material.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/new_music_playlist.dart';
import 'package:playit/screens/playlist_screen/favorite_music/favorite_songs.dart';
import 'package:playit/screens/playlist_screen/floating_button.dart/floating_button.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/play_list_of_video.dart';

import 'favorite_video/favorite_videos.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text('Playlist'),
        
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          secondHeading('Favorites'),
          const SizedBox(
            height: 20,
          ),
          // ------------ container for Favorite music--------------
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const FavoriteSongs(),
                )),
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 229, 12, 12),
                    Color.fromARGB(161, 205, 25, 25),
                    Color.fromARGB(113, 215, 21, 21),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Favorite Songs",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          const SizedBox(height: 20),
          // ------------ container for liked videos--------------
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteVideos(),
                )),
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 12, 63, 229),
                    Color.fromARGB(160, 25, 88, 205),
                    Color.fromARGB(112, 21, 66, 215),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Liked Videos",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          secondHeading("PlayList"),
          const SizedBox(
            height: 20,
          ),
          // ------------ New Playlist view -----------
         const NewMuciPlaylist(),
          const PlaylistOfVideo(),
        ],
      ),
      // ---------- Floating Button ---------------
      floatingActionButton:const FloatingButton(),
    );
  }
  secondHeading(data) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        data,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }
}
