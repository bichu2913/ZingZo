import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import 'package:music_player/screens/nowplay.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
   
    final width1 = MediaQuery.of(context).size.width;
    return player.builderCurrent(
      builder: (context, playing) {
        return Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 220, 186, 228),
          child: ListTile(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Nowplay(
                        index: playing.index,
                      )),
                ),
              );
            }),
             contentPadding: const EdgeInsets.fromLTRB(5, 3, 5, 10),
            leading: QueryArtworkWidget(
              id: int.parse(playing.audio.audio.metas.id!),
              type: ArtworkType.AUDIO,
              artworkWidth: 60,
              artworkHeight: 60,
              artworkFit: BoxFit.fill,
              nullArtworkWidget: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/studio.png"),
              ),
            ),
              title: Marquee(
              text: player.getCurrentAudioTitle,
              style: const TextStyle(color: Colors.black),
              blankSpace: 80,
              pauseAfterRound: const Duration(seconds: 2),
            ),
            trailing: PlayerBuilder.isPlaying(
              player: player,
              builder: (context, isPlaying) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: playing.index == 0
                            ? const Icon(
                                Icons.skip_previous,
                                color: Colors.black,
                                size: 50,
                              )
                            : const Icon(
                                Icons.skip_previous,
                                color: Colors.black,
                                size: 50,
                              ),
                        onPressed: playing.index == 0
                            ? () {}
                            : () async {
                                await player.previous();
                                if (isPlaying == false) {
                                  player.pause();
                                  setState(() {});
                                }
                              }),
                    SizedBox(
                      width: width1 * 0.02,
                    ),
                    IconButton(
                      onPressed: () {
                        player.playOrPause();
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(left: width1 * 0.02),
                        child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      ),
                      color: Colors.black,
                      iconSize: 50,
                    ),
                    IconButton(
                      icon: playing.index == playing.playlist.audios.length - 1
                          ? Icon(
                              Icons.skip_next,
                              color: Colors.black.withOpacity(0.4),
                              size: 50,
                            )
                          : const Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 50,
                            ),
                      onPressed:
                          playing.index == playing.playlist.audios.length - 1
                              ? () {}
                              : () async {
                                  await player.next();
                                  if (isPlaying == false) {
                                    player.pause();
                                    setState(() {});
                                  }
                                },
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}