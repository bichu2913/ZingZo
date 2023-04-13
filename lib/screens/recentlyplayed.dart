import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/recentlyplayed.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  List<Audio> resongconvert = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    List<RecentPlayed> rdbsongs =
        recentlyplayedbox.values.toList().reversed.toList();
    for (var item in rdbsongs) {
      resongconvert.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          'Recently Played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
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
                valueListenable: recentlyplayedbox.listenable(),
                builder: (context, Box<RecentPlayed> resongs, child) {
                  // final height = MediaQuery.of(context).size.height;
                  List<RecentPlayed> rsongs =
                      resongs.values.toList().reversed.toList();

                  if (rsongs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                          child: Text(
                            "You haven't played anything ! Try playing something.",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rsongs.length,
                      itemBuilder: ((context, index) {
                        return ListTile(tileColor: const Color.fromARGB(255, 220, 186, 228),
                          onTap: () {
                            player.open(
                              Playlist(
                                audios: resongconvert,
                                startIndex: index,
                              ),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                            );
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => Nowplay(
                                      index: index,
                                    )),
                              ),
                            );
                          },
                          leading: QueryArtworkWidget(
                            artworkFit: BoxFit.cover,
                            id: rsongs[index].id!,
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
                              rsongs[index].songname!,
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 13.43,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          // trailing: IconButton(
                          //   onPressed: (() {
                          //     // showModalBottomSheet(
                          //     //   backgroundColor: Colors.black,
                          //     //   shape: const RoundedRectangleBorder(
                          //     //     borderRadius: BorderRadius.vertical(
                          //     //       top: Radius.circular(20),
                          //     //     ),
                          //     //   ),
                          //     //   context: context,
                          //     //   builder: ((context) {
                          //     //     return SizedBox(
                          //     //       height: 150 /* height * 0.13 */,
                          //     //       child: Column(
                          //     //         children: [
                          //     //           SizedBox(
                          //     //             height: height1 * 0.05,
                          //     //           ),
                          //     //           const Text(
                          //     //             'Add To Playlist',
                          //     //             style: TextStyle(
                          //     //               color: Colors.white,
                          //     //               fontSize: 18,
                          //     //             ),
                          //     //           ),
                          //     //           SizedBox(
                          //     //             height: height1 * 0.011,
                          //     //           ),
                          //     //           AddtoFavourite(index: index),
                          //     //         ],
                          //     //       ),
                          //     //     );
                          //     //   }),
                          //     // );
                          //   }),
                          //   icon: const Icon(
                          //     Icons.more_vert,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
//how to set inkwell in flutter?

