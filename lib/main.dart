import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/splash_screen/splash_screen.dart';
import 'screens/bottom_navbar/bottom_navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(PlayItSongModelAdapter().typeId)) {
    Hive.registerAdapter(PlayItSongModelAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoFavouriteAdapter().typeId)) {
    Hive.registerAdapter(VideoFavouriteAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoFavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(VideoFavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoPlaylistModelAdapter().typeId)) {
    Hive.registerAdapter(VideoPlaylistModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AllVideosAdapter().typeId)) {
    Hive.registerAdapter(AllVideosAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoPlayListItemAdapter().typeId)) {
    Hive.registerAdapter(VideoPlayListItemAdapter());
  }

 

  await Hive.initFlutter();
  await Hive.openBox<int>('SongFavoriteDB');
  await Hive.openBox<String>('VideoFavoriteDataB');
  await Hive.openBox('recentSongNotifier');
  await Hive.openBox<PlayItSongModel>('songPlaylistDb');
  await Hive.openBox<VideoPlaylistModel>('VideoPlaylistDb');
  await Hive.openBox<VideoPlayListItem>('VideoListItemsBox');
  videoDB = await Hive.openBox<AllVideos>('videoplayer');

  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  runApp(const MyApp());
}

late Box<AllVideos> videoDB;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.black,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
        ),
      ),
      title: 'PlayIt App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/VideoPage': (context) => const BottomNavBarScreen()
      },
    );
  }
}