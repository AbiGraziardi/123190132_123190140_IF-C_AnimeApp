import 'package:anime_app/Model/home_manga_model.dart';
import 'package:anime_app/View/manga_detail.dart';
import 'package:flutter/material.dart';

class MangaCard extends StatelessWidget {
  final HomeMangaModel mangaData;
  final int cardIndex;

  MangaCard({
    required this.mangaData,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    // final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    // final screenWidth = device.size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        MangaDetailScreen.routeName,
        arguments: mangaData.malId,
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
                    mangaData.imageUrl,
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
                        Text(mangaData.title,
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
                            Text('${mangaData.score}',
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
                            Text(mangaData.startDate,
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