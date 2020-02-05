import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test_1/base/ApiExecutor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var _username = "";
  var _password = "";
  var _loginEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: PreferredSize(
//          preferredSize:
//              Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
//          child: SafeArea(
//            top: true,
//            child: Offstage(),
//          ),
//        ),
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          loginHeader(context),
          loginUserName(context),
          loginPassword(context),
          MaterialButton(
            textColor: Color(0xffffffff),
            color: Color(0xff34c094),
            child: Text("登录"),
            disabledColor: Color(0x8034c094),
            onPressed: () => _loginEnabled ? attampLogin() : null,
          )
        ],
      ),
    ));
  }

  Widget loginUserName(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
        child: TextField(
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(hintText: "请输入用户名", hintMaxLines: 1),
          onChanged: (text) {
            _username = text;
          },
        ));
  }

  Widget loginPassword(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
      child: TextField(
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(hintText: "请输入密码", hintMaxLines: 1),
        obscureText: true,
        maxLines: 1,
        onChanged: (text) {
          _password = text;
        },
      ),
    );
  }

  Widget loginHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 220,
          decoration: BoxDecoration(color: Color(0xff34c094)),
          child: Center(
            child: Image.asset("images/ic_app_logo.png",
                width: MediaQuery.of(context).size.width),
          ),
        ),
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: Center(
              child: Image.asset("images/ic_app_splash_logo.png", width: 100),
            )),
      ],
    );
  }

  void attampLogin() {
    if (_username.isEmpty) {
      showToast("请输入用户名");
    } else if (_password.isEmpty) {
      showToast("请输入密码");
    } else {
//      showLoading();
      loginAsync();
    }
  }

  bool validate() {
    return _username.isNotEmpty && _password.isNotEmpty;
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void loginAsync() {
    Map<String, String> body = {'phone': _username, 'password': _password};
    ApiExecutor.exec("login", true, body, (result) {
      print(result);
      onLoginSuccess();

    }, (e) => showToast(e.toString()));
  }

  void onLoginSuccess() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("KEY_LOGIN_USERNAME", _username);
      sharedPreferences.setString("KEY_LOGIN_PASSWORD", _password);
      Navigator.of(context).pushNamedAndRemoveUntil('/router/home', (route) => route == null);
  }

  void initUserName() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    setState(() {
//      _username = sharedPreferences.getString("KEY_LOGIN_USERNAME");
//      _password = sharedPreferences.getString("KEY_LOGIN_PASSWORD");
//    });

  }

  @override
  void initState() {
    super.initState();
    initUserName();
  }


}
