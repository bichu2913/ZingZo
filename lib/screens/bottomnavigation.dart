import 'package:flutter/material.dart';

import 'package:music_player/screens/HomeScreen.dart';
import 'package:music_player/screens/libraryScreen.dart';
import 'package:music_player/screens/list.dart';


class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int currentSelectIndex = 0;

  List pages = [
    const HomeScreen(),
    const list(), 
    const LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
        child: NavigationBar(
          selectedIndex: currentSelectIndex,
          onDestinationSelected: (indexx) =>
              setState(() => currentSelectIndex = indexx),
          height: 65,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.queue_music_outlined,
                color: Colors.white,
              ),
              label: '',
            ),
           
            NavigationDestination(
              icon: Icon(
                Icons.remove_from_queue,
                color: Colors.white,
              ),
              label: '',
            )
          ],
        ),
      ),
    );
  }
}
 

