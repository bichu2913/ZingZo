
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/addbottumplaylist.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/mostplayed.dart';
import 'package:music_player/db/recentlyplayed.dart';
import 'package:music_player/screens/miniscreen.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../db/favouriteaddlist.dart';
import '../db/listdb.dart';

class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  SongsState createState() =>SongsState();
  
}

class SongsState extends State<list> {
  late bool isplaying;
  late bool playerVisibility;
  final box = Songbox.getInstance();

 List<Audio> convertAudios = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
     List<Songs> dbSongs = box.values.toList();
     
    for (var item in dbSongs) {
      // here converting audios using the package of assrt audio player
      convertAudios.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    setState(() {});
    super.initState();
    
   
  }
  @override
  
  Widget build(BuildContext context) {
       final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
   

    
    return ValueListenableBuilder<Box<Songs>>(
      valueListenable: box.listenable(),
      builder: (context, Box<Songs> data, child) {
        List<Songs> alls = data.values.toList();
        List<MostPlayed> mostoftimeplayed = mostlyplayedbox.values.toList();
        
        if (alls.isEmpty) {
          return const CircularProgressIndicator();
        }
        return  Scaffold(
          backgroundColor: Colors.black,
          bottomSheet: const MiniPlayer(),
          
      body: 
         Column(
           children: [
            Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'All Song List',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
             Expanded(
               child: ListView.separated(
                    itemCount: alls.length,
                    itemBuilder: ( context,  index) {
                     Songs songs = alls[index];
                     MostPlayed MPsongs = mostoftimeplayed[index];
                      RecentPlayed rsongs;
                     
                      return SizedBox(
                        width: width1 * 1,
                        
                        child: ListTile(
                            textColor: Colors.black,
                            iconColor: Colors.black,
                            tileColor: const Color.fromARGB(255, 220, 186, 228),
                            
                           
                            leading: QueryArtworkWidget(
                              id: songs.id!,
                              type: ArtworkType.AUDIO,
                            ),
                            trailing: IconButton(
                  onPressed: (() {
                    setState(() {});
                    showModalBottomSheet(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: ((context) {
                        return SizedBox(
                           
                          child: Column(
                            children: [
                              SizedBox(
                                height: height1 * 0.02 ,
                              ),
                              AddtoPlaylist1(songIndex: index),
                              SizedBox(
                                height: height1 * 0.02 ,
                              ),
                              AddFavourite(index: index),
                            ],
                          ),
                        );
                      }),
                    );
                  }),
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black ,
                  ),
                ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(songs.songname!),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                IconButton(
                                  onPressed: () {
                                    rsongs = RecentPlayed(
                      songname: songs.songname,
                      artist: songs.artist,
                      id: songs.id,
                      duration: songs.duration,
                      songurl: songs.songurl);
                  // updatePlayedSongCount(rsongs, index);
                  updateRecentlyPlayed(rsongs, index);
                    updatePlayedSongCount(MPsongs, index);
                                    audioPlayer.open(
                      Playlist(audios: convertAudios, startIndex: index,),
                      showNotification: true
                       
                      
                      );
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                     return Nowplay(index: index);
                                   },),);
                                  },
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        
                      );
                    }
               ),
             ),
           ],
         )
              );
        
        },
      ); 
  }
}
