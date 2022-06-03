import 'package:anime_app/Service/data_source.dart';
import 'package:anime_app/Widget/manga_card.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class MangaList extends StatefulWidget {
  final String username;
  final bool isLogin;

  const MangaList({Key? key, required this.username, required this.isLogin}) : super(key: key);

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {

  Future<void> getData(String category) async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeManga(category: category);
  }

  @override
  void initState() {
    super.initState();
    getManga();
  }
  Future<void> getManga() async {
    await Provider.of<AnimeProvider>(context, listen: false).getHomeManga();
  }

  int _selectedIndex = 0;

  void searchData(String query) {
    Provider.of<AnimeProvider>(context, listen: false).searchManga(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        colorOnScroll: Colors.white,
        elevation: 0,
        hideKeyboardOnDownScroll: true,
        title: Container(),
        hint: 'Search manga ...',
        iconColor: Colors.lightBlueAccent,
        autocorrect: false,
        onFocusChanged: (isFocused) {
          if (!isFocused) {
            setState(() {
              getData('manga');
            });
          }
        },
        leadingActions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(
                  Icons.menu_book_outlined,
                  color: Colors.pinkAccent
                ),
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    getData('manga');
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
                child: _mangaList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mangaList(){
    final mangaData = Provider.of<AnimeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: RefreshIndicator(
          onRefresh: getManga,
          child: ListView.builder(
            itemCount: mangaData.searchList2.length,
            itemBuilder: (context, index) {
              return MangaCard(
                mangaData: mangaData.searchList2[index],
                cardIndex: index,
              );
            },
          ),
        ),
      ),
    );
  }
}