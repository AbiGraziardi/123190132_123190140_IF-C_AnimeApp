import 'package:anime_app/Model/user_model.dart';
import 'package:anime_app/Service/data_source.dart';
import 'package:anime_app/View/anime_detail.dart';
import 'package:anime_app/View/home_page.dart';
import 'package:anime_app/View/login_page.dart';
import 'package:anime_app/View/manga_detail.dart';
import 'package:anime_app/View/navbar_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>("user");
}

Future<void> main() async {
  initiateLocalDB();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool status =  pref.getBool("LoginStatus") ?? false;
  String username = pref.getString("Username") ?? "";
  runApp(ChangeNotifierProvider(
    create: (context) => AnimeProvider(),
    child: MaterialApp(
      title: 'AnimSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        primarySwatch: Colors.grey,
      ),
      home: status == true ? NavbarButton(username: username, isLogin: status) : LoginPage(status: false),
      routes: {
        AnimeDetailScreen.routeName: (context) => AnimeDetailScreen(),
        MangaDetailScreen.routeName: (context) => MangaDetailScreen(),
      },
    ),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

