import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/search/search.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> showWidgets = [
      SearchPage(),
      MapPage(),
      HomePage(),
      PaymentPage(),
      ProfilePage()
    ];
    int index = 0;
    return Text('Map');
  }
}
