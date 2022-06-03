import 'package:anime_app/Model/home_anime_model.dart';
import 'package:anime_app/View/anime_detail.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final HomeAnimeModel animeData;
  final int cardIndex;

  AnimeCard({
    required this.animeData,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    // final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    // final screenWidth = device.size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AnimeDetailScreen.routeName,
        arguments: animeData.malId,
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  child: Image.network(
                    animeData.imageUrl,
                    width: 700,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 20
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(animeData.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.2,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${animeData.score}',
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(animeData.startDate,
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}