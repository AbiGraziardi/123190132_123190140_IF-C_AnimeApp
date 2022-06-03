import 'package:anime_app/View/anime_list.dart';
import 'package:anime_app/View/home_page.dart';
import 'package:anime_app/View/manga_list.dart';
import 'package:anime_app/View/profile_page.dart';
import 'package:flutter/material.dart';

class NavbarButton extends StatefulWidget {
  final String imagePath;
  final String username;
  final bool isLogin;

  const NavbarButton({Key? key, required this.username, required this.isLogin, this.imagePath = ''}) : super(key: key);

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    bool status = false;
    final screens = [
      HomeScreen(username: "${widget.username}", isLogin: status),
      AnimeList(username: "${widget.username}", isLogin: status),
      MangaList(username: "${widget.username}", isLogin: status),
      ProfilePage(username: "${widget.username}", isLogin: status, imagePath: widget.imagePath),
      // ProfilePage(imagePath: widget.imagePath),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home',
            backgroundColor: Colors.pinkAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_outlined),
            label: 'Anime',
            backgroundColor: Colors.pinkAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Manga',
            backgroundColor: Colors.pinkAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}