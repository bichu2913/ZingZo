import 'package:flutter/material.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/favouritelistdb.dart';
import 'package:music_player/db/listdb.dart';


// ignore: must_be_immutable
class AddFavourite extends StatefulWidget {
  int index;
  AddFavourite({super.key, required this.index}); //here pass the index

  @override
  State<AddFavourite> createState() => _AddFavouriteState();
}

class _AddFavouriteState extends State<AddFavourite> {
  List<FavSongs> fav = [];
  // bool favorited = false;
  final box = Songbox.getInstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    fav = favsongbox.values.toList();
    return fav
            .where((element) => element.id == dbsongs[widget.index].id)
            .isEmpty //here we checking the fav songs list if any song matches to songs list song the song will never add/is it empty the index song will be added.
        ? TextButton(
            onPressed: () {
              favsongbox.add(
                FavSongs(
                    songname: dbsongs[widget.index].songname,
                    artist: dbsongs[widget.index].artist,
                    duration: dbsongs[widget.index].duration,
                    songurl: dbsongs[widget.index].songurl,
                    id: dbsongs[widget.index].id),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            child: const Text('Add to Favourite'))
        : TextButton(
            onPressed: () {
              int currentIndex = fav.indexWhere(
                  (element) => element.id == dbsongs[widget.index].id);
              favsongbox.deleteAt(currentIndex);
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Removed From Favourites"),
                ),
              );
            },
            child: const Text("Remove From Favourites"));
  }
}
