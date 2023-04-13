// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
 part 'listdb.g.dart';


@HiveType(typeId: 0)
class Songs {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;

  Songs({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songurl,
  });
}

String boxname = 'Songs';

// creating the instance of
class Songbox {
  static Box<Songs>? box; //creating the object
  static Box<Songs> getInstance() {
    //return the values into the list by using _box object.
    return box ??= Hive.box(boxname);
  }
}