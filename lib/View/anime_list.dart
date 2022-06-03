import 'package:anime_app/Service/data_source.dart';
import 'package:anime_app/Widget/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatefulWidget {

  final String username;
  final bool isLogin;

  const AnimeList({Key? key, required this.username, required this.isLogin}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {

  Future<void> getData(String category) async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeAnime(category: category);
  }

  @override
  void initState() {
    super.initState();
    getAnime();
  }
  Future<void> getAnime() async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeAnime();
  }

  int _selectedIndex = 0;

  void searchData(String query) {
    Provider.of<AnimeProvider>(context, listen: false).searchAnime(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        colorOnScroll: Colors.white,
        elevation: 0,
        hideKeyboardOnDownScroll: true,
        title: Container(),
        hint: 'Search anime ....',
        iconColor: Colors.lightBlueAccent,
        autocorrect: false,
        onFocusChanged: (isFocused) {
          if (!isFocused) {
            setState(() {
              getData('airing');
            });
          }
        },
        leadingActions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(
                  Icons.live_tv,
                  color: Colors.pinkAccent,
                ),
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    getData('airing');
                  });
                }),
          ),
        ],
        onSubmitted: (query) {
          setState(() {
            _selectedIndex = 0;
            searchData(query);
          });
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: _animeList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animeList(){
    final animeData = Provider.of<AnimeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: RefreshIndicator(
          onRefresh: getAnime,
          child: ListView.builder(
            itemCount: animeData.searchList.length,
            itemBuilder: (context, index) {
              return AnimeCard(
                animeData: animeData.searchList[index],
                cardIndex: index,
              );
            },
          ),
        ),
      ),
    );
  }
}