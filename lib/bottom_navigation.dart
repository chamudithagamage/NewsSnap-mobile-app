import 'package:flutter/material.dart';
class BottomNavigation extends StatelessWidget {

  late  int currentIndex = 0;
  final Function onTap;
  BottomNavigation({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap(),

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmarks',
        ),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.black38,
    );
  }
  }
