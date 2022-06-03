import 'package:anime_app/Model/anime_model.dart';
import 'package:anime_app/Model/home_anime_model.dart';
import 'package:anime_app/Model/home_manga_model.dart';
import 'package:anime_app/Model/manga_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AnimeProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';
  List<HomeAnimeModel> searchList = [];
  List<HomeMangaModel> searchList2 = [];
  late AnimeModel animeData = AnimeModel();
  late MangaModel mangaData = MangaModel();

  Future<void> getHomeAnime({String category = 'airing'}) async {
    final String url = 'https://api.jikan.moe/v3/top/anime/1/$category';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<HomeAnimeModel> tempData = [];
      List items = response.data['top'];
      tempData = items.map((data) => HomeAnimeModel.fromJson(data)).toList();
      searchList = tempData;
      print(searchList.length);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchAnime(String query) async {
    final String url =
        'https://api.jikan.moe/v3/search/anime?q=$query&page=1&limit=12';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<HomeAnimeModel> tempData = [];
      List items = response.data['results'];
      tempData = items.map((data) => HomeAnimeModel.fromJson(data)).toList();
      searchList = tempData;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAnimeData(int malId) async {
    final String url = 'https://api.jikan.moe/v3/anime/$malId';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      animeData = AnimeModel.fromJson(response.data);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }


  Future<void> getHomeManga({String category = 'manga'}) async {
    final String url = 'https://api.jikan.moe/v3/top/manga/1/$category';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<HomeMangaModel> tempData = [];
      List items = response.data['top'];
      tempData = items.map((data) => HomeMangaModel.fromJson(data)).toList();
      searchList2 = tempData;
      print(searchList2.length);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchManga(String query) async {
    final String url =
        'https://api.jikan.moe/v3/search/manga?q=$query&page=1&limit=12';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<HomeMangaModel> tempData = [];
      List items = response.data['results'];
      tempData = items.map((data) => HomeMangaModel.fromJson(data)).toList();
      searchList2 = tempData;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMangaData(int malId) async {
    final String url = 'https://api.jikan.moe/v3/manga/$malId';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      mangaData = MangaModel.fromJson(response.data);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.other) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }
}