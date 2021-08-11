import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Widget> showWidgets = [
    SearchPage(),
    MapPage(),
    HomePage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(child: Row(children: <Widget>[
       AnimSearchBar(
        width: MediaQuery.of(context).size.width,
        textController: textController,

        onSuffixTap: () {
          setState(() {
            print(textController.text);
            textController.clear();
          });

        },
      ),
    ],),
    );

  }
}
