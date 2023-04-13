import 'package:hive/hive.dart';
import 'package:music_player/db/listdb.dart';

part 'playlistmodel.g.dart';

@HiveType(typeId: 4)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistssongs; //?
  PlaylistSongs({required this.playlistname, required this.playlistssongs});
}