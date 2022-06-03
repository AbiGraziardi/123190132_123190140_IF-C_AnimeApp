import 'package:anime_app/Model/home_manga_model.dart';
import 'package:anime_app/View/manga_detail.dart';
import 'package:flutter/material.dart';

class HomeManga extends StatelessWidget {
  final HomeMangaModel homeData2;
  final int cardIndex;

  HomeManga({
    required this.homeData2,
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
        arguments: homeData2.malId,
      ),
      child:
      Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 25),
      child: Container(
        child: Image.network(
          homeData2.imageUrl,

          height: 15,
          fit: BoxFit.cover,
        ),
        ),
      ),
    );
  }
}
