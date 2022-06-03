import 'package:anime_app/Model/user_model.dart';
import 'package:anime_app/View/navbar_button.dart';
import 'package:anime_app/View/register_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final bool status;

  const LoginPage({Key? key, required this.status}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<UserModel> localDB = Hive.box<UserModel>("user");
  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String password = "";

  late bool isLogin = widget.status;

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      String currentUsername = _usernameController.value.text;
      String currentPassword = _passwordController.value.text;

      _prosesLogin(currentUsername, currentPassword);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bck.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(100, 100, 100, 120),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12))),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Username",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Username Can\'t be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Password Can\'t be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  _buildButtonLogin(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _buildButtonRegister(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
        child: Center(
            //width of button
            child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: Size(500, 40),
          //background color of button
          side: BorderSide(color: Colors.black),
          //elevation of button
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(20) //content padding inside button
          ),
      onPressed: () {
        _submit();
      },
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    )));
  }

  Widget _buildButtonRegister() {
    return Container(
        child: Center(
            //width of button
            child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize: Size(500, 40),
          //background color of button
          side: BorderSide(color: Colors.black54),
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(20) //content padding inside button
          ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    )));
  }

  void _prosesLogin(String username, String password) async {
    for (int index = 0; index < localDB.length; index++) {
      if (username == localDB.getAt(index)!.username &&
          password == localDB.getAt(index)!.password) {
        isLogin = true;
        SharedPreferences getPref = await _myPref;
        await getPref.setBool("LoginStatus", isLogin);
        await getPref.setString("Username", username);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return NavbarButton(
            username: username,
            isLogin: isLogin,
          );
        }), (_) => false);
      }
    }
  }
}
