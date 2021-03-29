import 'package:homealone/pages/Navbar/addbar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:homealone/pages/addhome.dart';
import 'package:homealone/pages/addrent.dart';
import 'package:homealone/pages/adduser.dart';

import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: LoginPage(),
      title: 'Home Alone',
      routes: {
        '/home-page': (context) => HomePage(),
        '/login-page': (context) => LoginPage(),
        '/main-page': (context) => MainPages(),
        '/manu-page': (context) => AddMenu(),
        '/Addrent-page': (context) => AddRent(),
        '/Adduser-page': (context) => AddUser(),
        '/Addhome-page': (context) => AddHome()
      },
    );
  }
}
