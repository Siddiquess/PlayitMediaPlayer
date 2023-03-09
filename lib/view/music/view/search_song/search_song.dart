import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/database/song_favorite_db.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:playit/view/music/view/music_page/songs/song_list_builder.dart';
import 'package:provider/provider.dart';

class SearchSongPage extends StatefulWidget {
  const SearchSongPage({super.key, required this.isFavSong});
  final bool isFavSong;

  @override
  State<SearchSongPage> createState() => _SearchSongPageState();
}

class _SearchSongPageState extends State<SearchSongPage> {
  List<SongModel> allSongs = [];
  List<SongModel> foundSongs = [];
  final audioQuery = OnAudioQuery();
  TextEditingController searchtext = TextEditingController();

  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  void updateList(String searchText) {
    List<SongModel> result = [];
    if (searchText.isEmpty) {
      result = allSongs;
    } else {
      result = allSongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundSongs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchtext,
                onChanged: (value) => updateList(value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  hintText: 'Search Song',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  prefixIconColor: Colors.white,
                  suffixIcon: searchtext.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              searchtext.clear();
                              loadSongs();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Results',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            foundSongs.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.7 / 2),
                    child: const Center(child: Text('No Result')),
                  )
                : Expanded(
                    child: SongListBuilder(
                      songModel: foundSongs,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  loadSongs() async {
    allSongs = widget.isFavSong
        ? Provider.of<MusicFavController>(context,listen: false).favoriteSongs
        : GetAllSongController.songscopy;
    foundSongs = allSongs;
  }
}
