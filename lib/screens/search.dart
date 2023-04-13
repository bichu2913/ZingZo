import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/db/listdb.dart';
import 'package:music_player/screens/nowplay.dart';
final TextEditingController searchController = TextEditingController();
final box = Songbox.getInstance();
late List<Songs> dbSongs;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Audio> allSongs = [];
List<Songs> another = List.from(dbSongs);

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  @override
  void initState() {
    dbSongs = box.values.toList();
    for (var item in another) {
      allSongs.add(
        Audio.file(
          item.songurl.toString(),
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
    }
   
    log(another.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
     
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width1 * 1,
              height: height1 * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  child: TextFormField(
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    
                    controller: searchController,
                    onChanged: (value) => updateList(value),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      hintText: 'What do you want to listen to?',
                      hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(113, 158, 158, 158))),
                      filled: true,
                      fillColor: const Color.fromARGB(146, 50, 50, 50),
                    ),
                  ),
                )),
            Expanded(child: searchHistory())

            // listView(context)
          ],
        ),
      ),
    );
  }

  searchHistory() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: another.isEmpty
          ? Center(
              child: Text(
              "No Songs Found",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ))
          : ListView.builder(
              
              shrinkWrap: true,
              itemCount: another.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    textColor: Colors.black,
                              iconColor: Colors.black,
                              tileColor: const Color.fromARGB(255, 220, 186, 228),
                              horizontalTitleGap: 1,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 20),
                                borderRadius: BorderRadius.circular(10),
                              ),
                    onTap: () {
                      audioPlayer.open(
                          Playlist(audios: allSongs, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);

                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => Nowplay(index: index)),
                        ),
                      );
                      FocusScope.of(context).unfocus();
                    },
                    leading: QueryArtworkWidget(
                      artworkFit: BoxFit.cover,
                      id: another[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(50),
                      nullArtworkWidget: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          'assets/images/studio.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SingleChildScrollView(
                      child: Text(
                        another[index].songname!,
                        maxLines: 1,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 13.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  void updateList(String value) {
    setState(() {
      another = dbSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
          
      allSongs.clear();
      for (var item in another) {
        allSongs.add(
          Audio.file(
            item.songurl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString(),
            ),
          ),
        );
      }
      log(allSongs.toString());
    });
  }
}