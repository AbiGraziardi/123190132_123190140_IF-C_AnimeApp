import 'package:anime_app/Model/home_anime_model.dart';
import 'package:anime_app/View/anime_detail.dart';
import 'package:flutter/material.dart';

class HomeAnime extends StatelessWidget {
  final HomeAnimeModel homeData;
  final int cardIndex;

  HomeAnime({
    required this.homeData,
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
        arguments: homeData.malId,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 25),
        child: Container(
          child: Image.network(
            homeData.imageUrl,

            height: 15,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}