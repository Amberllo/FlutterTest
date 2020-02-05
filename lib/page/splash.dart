import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SplashState();

}

class _SplashState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff34c094),
      body: Center(child: Image.asset("images/ic_app_splash_logo.png")),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      print('initState');
      Navigator.of(context).pushNamedAndRemoveUntil('/router/login', (route) => route == null);
      timer.cancel();
    });
  }
}
