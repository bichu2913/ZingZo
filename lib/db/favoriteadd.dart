import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:music_player/db/db_function.dart';
import 'package:music_player/db/listdb.dart';

import 'favouritelistdb.dart';

// ignore: must_be_immutable
class AddtoFavourite extends StatefulWidget {
  int index;
  AddtoFavourite( {super.key, required this.index  }); 

  @override
  State<AddtoFavourite> createState() => _AddtoFavouriteState();
}
class _AddtoFavouriteState extends State<AddtoFavourite> {
  List<FavSongs> fav = [];
  
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
            .isEmpty 
        ? IconButton(
            onPressed: () {
              
              favsongbox.add(
                FavSongs(
                  songname: dbsongs[widget.index].songname,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id,
                ),
              );
              setState(() {});
              
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 35,
            ),
          )
        : IconButton(
            onPressed: () {
              int currentIndex = fav.indexWhere(
                  (element) => element.id == dbsongs[widget.index].id);
              fav.removeAt(currentIndex);
              favsongbox.deleteAt(currentIndex);
              log(currentIndex.toString());
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed From Favorites")));
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 35,
            ));
}
}