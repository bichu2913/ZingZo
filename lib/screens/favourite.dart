
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/screens/nowplay.dart';
import '../db/db_function.dart';
import '../db/favouritelistdb.dart';

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

class FavoritePagelist extends StatefulWidget {
   const FavoritePagelist({Key? key}) : super(key: key);

  @override
  FavoritePagelistState createState() =>FavoritePagelistState();
  
}
  
class FavoritePagelistState extends State<FavoritePagelist> {
  List<Audio> fsongs = [];
   AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    List<FavSongs> fasongs = favsongbox.values.toList();
    for (var item in fasongs) {
      fsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width; 
   
    
    return  ValueListenableBuilder(
              valueListenable: favsongbox.listenable(),
              builder: (context, Box<FavSongs> favsongs, child) {
                List<FavSongs> allDbSongs = favsongs.values.toList();
        if (favsongbox.isEmpty) {
          return const Text('No Favourites');
        }
        return  Scaffold(backgroundColor: Colors.black ,
      body: 
      
         Column(
           children: [
            Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'favourites',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
             Expanded(
               child: Container(
                 child: ListView.separated(
                      itemCount: allDbSongs.length,
                      itemBuilder: ( context,  index) {
                        
                       
                        return SizedBox(
                          height: 100,
                          width: 30,
                          child: ListTile(
                              textColor: Colors.black,
                              iconColor: Colors.black,
                              tileColor: const Color.fromARGB(255, 220, 186, 228),
                              horizontalTitleGap: 1,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 20),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: QueryArtworkWidget(
                                id:  allDbSongs[index].id!,
                                type: ArtworkType.AUDIO,
                              ),
                              trailing: IconButton(
                                  onPressed: ()  {
                                          fsongs.removeAt(index);
                                          favsongbox.deleteAt(index);
                                          log(player.playlist!.audios
                                              .toString());
                                          Navigator.pop(context);
                                    fsongs.removeAt(index);
                                     
                                          Navigator.pop(context);
                                      
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(allDbSongs[index].songname!),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      player.open(
                        Playlist( 
                          audios: fsongs,
                          startIndex: index
                        ),
                        showNotification: true,
                        
                        
                       );
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                       return Nowplay(index: index);
                                     },));
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.black,
                          thickness: 16,
                        );
                      }
                 ),
               ),
             ),
           ],
         )
              );
        
        },
      ); 
  }
}
