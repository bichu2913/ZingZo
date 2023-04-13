import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/mostplayed.dart';
import 'package:music_player/db/playlistmodel.dart';
import 'package:music_player/db/recentlyplayed.dart';

import 'favouritelistdb.dart';

late Box<FavSongs> favsongbox;
openFavouritePlayedDb() async {
  favsongbox = await Hive.openBox('Favouritesongs');
}
late Box<MostPlayed> mostlyplayedbox;
openMostlyPlayedDb() async {
  mostlyplayedbox = await Hive.openBox('mostlyplayed');
}
late Box<PlaylistSongs> playlistbox;
opendatabase() async {
  playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
}
late Box<RecentPlayed> recentlyplayedbox;
openrecentlyplayedDb() async {
  recentlyplayedbox = await Hive.openBox('recentlyplayed');
}


updateRecentlyPlayed(RecentPlayed value, index) {
  List<RecentPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready = list.where(
    (songs) {
      return songs.songname == value.songname;
     
    },
  ).isEmpty;
  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index = list.indexWhere((songs) => songs.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}



updatePlayedSongCount(MostPlayed value, int index) {
 
  int clickCount = value.count;
  
  value.count = clickCount + 1;
  mostlyplayedbox.put(index, value);
}
