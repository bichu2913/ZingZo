import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/mostplayed.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../db/db_function.dart';

class MosltlyPlayedScreen extends StatefulWidget {
  const MosltlyPlayedScreen({super.key});
  @override
  State<MosltlyPlayedScreen> createState() => _MosltlyPlayedScreenState();
}

List<MostPlayed> finalmsongs = [];

class _MosltlyPlayedScreenState extends State<MosltlyPlayedScreen> {
  List<Audio> songs = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  @override
  void initState() {
    
    List<MostPlayed> songlist =
        mostlyplayedbox.values.toList().reversed.toList();
    log(songlist.toString());
    int i = 0;
    for (var item in songlist) {
      if (item.count > 3) {
        
        finalmsongs.remove(item);
        
        finalmsongs.insert(i, item);
        i++;
      }
    }
    for (var items in finalmsongs) {
      
      songs.add(
        Audio.file(
          items.songurl,
          metas: Metas(
            title: items.songname,
            artist: items.artist,
            id: items.id.toString(),
          ),
        ),
      );
      super.initState();
    }
  }
  
  @override
  Widget build(BuildContext context) {
   final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return  Scaffold( 
      backgroundColor: Colors.black,
  
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
                          'Mostly Played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: width1 * 0.2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: mostlyplayedbox.listenable(),
                builder: (context, Box<MostPlayed> datamsongs, _) {
                  
                  if (finalmsongs.isNotEmpty) {
                    return ListView.builder(
                      
                      shrinkWrap: true,
                      itemCount: finalmsongs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 6, 0, 3),
                          child: ListTile(
                            textColor: Colors.black,
                              iconColor: Colors.black,
                              tileColor: const Color.fromARGB(255, 220, 186, 228),
                            onTap: () {
                              player.open(
                                  Playlist(
                                    audios: songs,
                                    startIndex: index,
                                  ),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                  loopMode: LoopMode.playlist);
                              setState(() {});
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Nowplay(
                                    index: index,
                                  );
                                },
                              ));
                            },
                            leading: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: finalmsongs[index].id,
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
                                finalmsongs[index].songname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 13.43,
                                      
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                           
                          ),
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                          child: Text(
                            '''Your most played songs will be listed here ''',
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    );
                  }
                },
                
              ),
            )
          ],
        ),
      ),
    );
      
    
  }
  }