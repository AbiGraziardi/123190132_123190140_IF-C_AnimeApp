import 'package:anime_app/Model/manga_model.dart';
import 'package:anime_app/Service/data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MangaDetailScreen extends StatefulWidget {
  static const routeName = '/mangadetailscreen';

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  var _isInit = true;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      late int mangaId = ModalRoute.of(context)!.settings.arguments as int;
        Provider.of<AnimeProvider>(context, listen: false).getMangaData(mangaId);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<AnimeProvider>(context);
    final MangaModel mangaData = dataProvider.mangaData;
    final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    final screenWidth = device.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: !dataProvider.isLoading
          ? Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 450,
                    width: 300,
                    child: Image.network(
                      mangaData.imageUrl,
                      width: 700,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                mangaData.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                mangaData.volumes.toString() + ' Volumes, ' +mangaData.chapters.toString() + ' Chapters',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                      color: Colors.lightBlueAccent,
                      height: 120,
                      width: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.star_border_outlined,
                              size: 45,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${mangaData.score}',
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      color: Colors.lightBlueAccent,
                      height: 120,
                      width: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 45,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${mangaData.favorites}',
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                mangaData.synopsis,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      )
          : Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 5,
          )),
    );
  }
}