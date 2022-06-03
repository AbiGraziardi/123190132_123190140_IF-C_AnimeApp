import 'package:anime_app/Model/anime_model.dart';
import 'package:anime_app/Service/data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeDetailScreen extends StatefulWidget {
  static const routeName = '/animedetailscreen';

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  var _isInit = true;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      late int animeId = ModalRoute.of(context)!.settings.arguments as int;
      Provider.of<AnimeProvider>(context, listen: false).getAnimeData(animeId);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<AnimeProvider>(context);
    final AnimeModel animeData = dataProvider.animeData;
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
                            animeData.imageUrl,
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
                      animeData.title,
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
                      animeData.episodes <= 0
                          ? 'Ongoing'
                          : animeData.episodes.toString() + ' Episodes',
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
                          child: InkWell(
                            onTap: () async {
                              final url = animeData.trailerUrl;

                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceSafariVC: true,
                                  forceWebView: true,
                                  enableJavaScript: true,
                                );
                              }
                            },
                            child: Container(
                              color: Colors.lightBlueAccent,
                              height: 120,
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.play_circle_outline_rounded,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Watch Trailer',
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
                                    Icons.star_border_outlined,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${animeData.score}',
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
                      animeData.synopsis,
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
