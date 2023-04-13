import 'package:flutter/material.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/listdb.dart';
import 'package:music_player/db/playlistmodel.dart';
import 'package:music_player/db/recentlyplayed.dart';
import 'package:music_player/screens/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/favouritelistdb.dart';
import 'db/mostplayed.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname); 
  runApp(const MyApp());
   Hive.registerAdapter(FavSongsAdapter());
  openFavouritePlayedDb();
  Hive.registerAdapter(MostPlayedAdapter());
  openMostlyPlayedDb();
  Hive.registerAdapter(PlaylistSongsAdapter());
  opendatabase();
  Hive.registerAdapter(RecentPlayedAdapter());
  openrecentlyplayedDb(); 
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZING ZOO',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const SplashScreen(title:" hello"),
    );
  }
}
