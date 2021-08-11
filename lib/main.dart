import 'package:homealone/pages/Navbar/addbar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:homealone/pages/addhome.dart';
import 'package:homealone/pages/addrent.dart';
import 'package:homealone/pages/adduser.dart';

import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment/elecpay.dart';
import 'package:homealone/pages/payment/rentpay.dart';
import 'package:homealone/pages/payment/waterpay.dart';
import 'package:homealone/pages/prelogin.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/register.dart';
import 'package:homealone/pages/regmanager.dart';
import 'package:homealone/pages/reviewhome/reviewpage.dart';
import 'package:homealone/pages/search/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: MainPages(),
      title: 'Home Alone',
      routes: {
        '/home-page': (context) => HomePage(),
        '/login-page': (context) => LoginPage(),
        '/main-page': (context) => MainPages(),
        '/Addrent-page': (context) => AddRent(),
        '/Adduser-page': (context) => AddUser(),
        '/Addhome-page': (context) => AddHome(),
        '/Profile-page': (context) => ProfilePage(),
        '/Search-page': (context) => SearchPage(),
        '/Map-page': (context) => MapPage(),
        '/Prelogin-page': (context) => PreLogin(),
        '/Register-page': (context) => RegisterPage(),
        '/Regmanager-page': (context) => RegManagerPage(),
        '/Waterpay-page': (context) => WaterpayPage(),
        '/Elecpay-page': (context) => ElecpayPage(),
        '/Rentpay-page': (context) => RentpayPage(),
        '/Review-page': (context) => ReviewPage()
      },
    );
  }
}
