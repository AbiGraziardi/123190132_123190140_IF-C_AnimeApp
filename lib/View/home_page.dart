import 'package:anime_app/Service/data_source.dart';
import 'package:anime_app/Widget/home_anime.dart';
import 'package:anime_app/Widget/home_manga.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final bool isLogin;

  const HomeScreen({Key? key, required this.username, required this.isLogin})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getAnime();
    getManga();
  }

  Future<void> getAnime() async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeAnime();
  }

  Future<void> getManga() async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeManga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'What would you \n like to see, ${widget.username}?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            'Recommended Anime',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
            child: _animeList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            'Recommended Manga',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
            child: _mangaList(),
          ),
        ),
      ],
    ));
  }

  Widget _animeList() {
    final homeData = Provider.of<AnimeProvider>(context);

    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: getAnime,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeData.searchList.length,
            itemBuilder: (context, index) {
              return HomeAnime(
                homeData: homeData.searchList[index],
                cardIndex: index,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _mangaList() {
    final homeData = Provider.of<AnimeProvider>(context);

    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: getManga,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeData.searchList.length,
            itemBuilder: (context, index) {
              return HomeManga(
                homeData2: homeData.searchList2[index],
                cardIndex: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
