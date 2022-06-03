import 'package:anime_app/Model/user_model.dart';
import 'package:anime_app/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Box<UserModel> localDB = Hive.box<UserModel>("user");

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String password = "";

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  status: false,
                )),
        (_) => false,
      );
      localDB.add(UserModel(
          username: _usernameController.text,
          password: _passwordController.text));
      _usernameController.clear();
      _passwordController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
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
                                    "Register",
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
                                      onChanged: (text) =>
                                          setState(() => username = text),
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
                                        }
                                        if (text.length < 8) {
                                          return 'Your Password is Weak (<8)';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (text) =>
                                          setState(() => password = text),
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

  Widget _buildButtonRegister() {
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
        "Create Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    )));
  }
}
