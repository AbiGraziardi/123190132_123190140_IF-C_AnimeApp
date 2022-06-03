import 'dart:io';

import 'package:anime_app/Model/image_picker_helper.dart';
import 'package:anime_app/View/login_page.dart';
import 'package:anime_app/View/navbar_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String imagePath;
  final String username;
  final bool isLogin;

  const ProfilePage({Key? key, required this.username, required this.isLogin, required this.imagePath}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  late SharedPreferences logindata;
  String? username;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: _profileDetail());
  }

  Widget _profileDetail() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                _imageSection(),
                SizedBox(
                  height: 10,
                ),
                _name(),
                SizedBox(
                  height: 50,
                ),
                _logoutButton(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _imageSection() {
    return Container(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Choose Avatar Image'),
              content: Container(
                  color: Colors.white,
                  width: 50.0,
                  height: 130.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        _buttonCamera(),
                        SizedBox(
                          height: 30,
                        ),
                        _buttonGallery(),
                      ],
                    ),
                  )),
              actions: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return NavbarButton(username: '${widget.username}', isLogin: false, imagePath: _imagePath);
                            }));
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return NavbarButton(username: '${widget.username}', isLogin: false, imagePath: _imagePath);
                            }));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(130), child: _avatarImage()),
      ),
      width: 230,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(130),
        color: Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 4.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }

  Widget _avatarImage() {
    if (_imagePath.isEmpty) {
      return Container(
        child: Image.network(
          "https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      );
    } else {
      return Container(
        child: Image.file(
          File(_imagePath),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      );
    }
  }

  void _processImage(String? value) {
    if (value != null) {
      setState(() {
        _imagePath = value;
      });
    }
  }

  Widget _buttonCamera() {
    return TextButton(
      child: Text(
        'Take a Picture',
        style: TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 17,
        ),
      ),
      onPressed: () {
        ImagePickerHelper().getImageFromCamera((value) => _processImage(value));
      },
    );
  }

  Widget _buttonGallery() {
    return TextButton(
        child: Text(
          'Select From Gallery',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 17,
          ),
        ),
        onPressed: () {
          ImagePickerHelper().getImageFromGallery((value) {
            _processImage(value);
          });
        });
  }

  Widget _name() {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text(
          '${widget.username}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Container(
        child: Center( //width of button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  //background color of button
                  side: BorderSide(width: 3, color: Colors.black),
                  //border width and color
                  elevation: 3,
                  //elevation of button
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                  EdgeInsets.all(20) //content padding inside button
              ),
              onPressed: () {
                bool status = false;
                _prosesLogout(status, widget.username);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return LoginPage(status: status);
                }));
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            )));
  }

  void _prosesLogout(bool status, String username) async {
    SharedPreferences getPref = await _myPref;
    await getPref.setBool("LoginStatus", status);
    await getPref.setString("Username", username);
  }
}