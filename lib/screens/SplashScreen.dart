import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/mostplayed.dart';
import 'package:music_player/screens/bottomnavigation.dart';

import '../db/listdb.dart';






class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
final audioQuery = OnAudioQuery();
final box = Songbox
    .getInstance(); //this is the copy of songbox it contain all songs of Songs class.

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
     requestStoragePermission();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Image(image: AssetImage('assets/images/splash.png')),
      ),
    );
  }
  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    //here we checking the permission status if it is false we need to request to access our internal storage musics
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();
      //here we fetching the songs from our internal storage
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
          //here we add all songs into database.
        }
      }
      for (var element in allSongs) {
        mostlyplayedbox.add(
          MostPlayed(
            songname: element.title,
            songurl: element.uri!,
            duration: element.duration!,
            artist: element.artist!,
            count: 0,
            id: element.id,
          ),
        );
      }
      

      for (var element in allSongs) {
        box.add(
          Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri,

           
          ),
        );
      }
    }
  }



  Future login() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) =>const BottomScreen()));
  }
}