import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music_player/db/addbottumplaylist.dart';
import 'package:music_player/db/favouriteaddlist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../db/listdb.dart';




// ignore: must_be_immutable
class Nowplay extends StatefulWidget {
  int index;
    Nowplay({super.key, required this.index   });
 

  @override
  State<Nowplay> createState() => _NowplayState();
}

class _NowplayState extends State<Nowplay> {
   late List<Songs> dbsongs;
   
   
  final box = Songbox.getInstance();
 bool onPress = false;
  bool isNext = false;
bool _isPlaying = true;
AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
@override
  void initState() {
    setState(() {});
    dbsongs = box.values.toList();
    super.initState();
    setState(() {});
  }
  @override
  
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    setState(() {});
    return player.builderCurrent(builder: (context, playing) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Container(
            width: width1*1 ,
            color:  Colors.black,
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width1*0.96  ,
                height: height1*0.70  ,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/images.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 20), 
                Text( player.getCurrentAudioTitle), 
            
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: PlayerBuilder.realtimePlayingInfos(
                  player: player,
                  builder: (context, realtimePlayingInfos) {
                    final duration = realtimePlayingInfos.current!.audio.duration;
                    final position = realtimePlayingInfos.currentPosition;
                    return ProgressBar(
                      progress: position,
                      total: duration,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
              ),
              
              SingleChildScrollView(
                child: Container(
                  height: 50,
                  width: width1*1,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 220, 186, 228)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 50,
                        width: 50, 
                        child: QueryArtworkWidget(
                      id:int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                    ),
                      ),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            child: const Icon(
                                Icons.skip_previous,size: 40,),
                            onTap: () {
                                   
                                  player.previous();
                                
                            },
                          )),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            child:  Icon(
                             _isPlaying ?  Icons.pause : Icons.play_arrow ,size: 40,),
                            onTap: () {
                              setState(() {
                                if(_isPlaying){
                                  player.pause();
                                }
                                else{
                                  player.play();
                                }
                                _isPlaying =!_isPlaying;
                              });
                              
                            },
                          )),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            child: const Icon(Icons.skip_next,size: 40,),
                            onTap: () {
                              
                             
                             player.next();
                                
                            }
                                  
                            
                          )),
                      SizedBox(
                        height: 50,
                        width: 50,
                       
                             child : IconButton(
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
                              AddtoPlaylist1(songIndex:dbsongs.indexWhere((element) =>
                            element.songname == playing.audio.audio.metas.title),),
                              SizedBox(
                                height: height1 * 0.02 ,
                              ),
                              AddFavourite(index: dbsongs.indexWhere((element) =>
                            element.songname == playing.audio.audio.metas.title),)
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
                )
                        ),
                      
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
    }
    );
  }
}





