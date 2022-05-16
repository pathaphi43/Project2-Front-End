import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:homealone/pages/Navbar/addbar.dart';
import "package:homealone/pages/Navbar/mainpages.dart";
import 'package:homealone/pages/addhome.dart';
import 'package:homealone/pages/addrent.dart';
import 'package:homealone/pages/adduser.dart';

import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/house/HouseListForRent.dart';
import 'package:homealone/pages/house/edithouse.dart';
import 'package:homealone/pages/house/homeInfo.dart';
import 'package:homealone/pages/house/myhouse.dart';
import 'package:homealone/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/payment/elecpay.dart';
import 'package:homealone/pages/payment/elecpay_tenant.dart';
import 'package:homealone/pages/payment/rentpay.dart';
import 'package:homealone/pages/payment/rentpay_tenant.dart';
import 'package:homealone/pages/payment/waterpay.dart';
import 'package:homealone/pages/prelogin.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/register.dart';
import 'package:homealone/pages/regmanager.dart';
import 'package:homealone/pages/reviewhome/reviewpage.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:homealone/pages/users/ManagerEditProfile.dart';
import 'package:homealone/pages/users/editmanager.dart';

import 'pages/Navbar/mainpages.dart';
import 'pages/income.dart';
import 'pages/payment/addelec.dart';
import 'pages/payment/addrent.dart';
import 'pages/payment/addwater.dart';
import 'pages/payment/waterpay_tenant.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThailandProvincesDatabase.init();
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
        '/Review-page': (context) => ReviewPage(),
        '/Myhouse-page': (context) => MyHouse(),
        '/Editmanager-page': (context) => EditManager(),
        '/Edithouse-page': (context) => EditHouse(),
        '/Homeinfo-page': (context) => InfoPage(),
        '/ManagerEditProfile-page':(context) => ManagerEditProfile(),
        '/PreRent-page':(context) => PreRent(),
        '/Income-page':(context) => IncomePage(),
        '/addelec-page':(context) => AddElecPage(),
        '/addrent-page':(context) => addRentPage(),
        '/addwater-page':(context) => addWaterPage(),
// IncomePage
      },
    );
  }
}
