import 'package:homealone/model/homemodel.dart';
import 'package:homealone/model/testhomemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var reqhouse = House();

    reqhouse.hid = 1;
    reqhouse.houseName = 'PPTown';
    reqhouse.houseAdd =
        '235 หมู่ที่ 15 ต.ขามเรียง อ.กันทรวิชัย จ.มหาสารคาม 44150';
    reqhouse.houseStatus = 0;
    List<String> args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
          color: Colors.amber[50],
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'images/home.jpg',
                    ),
                    title: Text(reqhouse.houseName),
                    subtitle: Text(reqhouse.houseAdd),
                    trailing: Text(
                      'ติดจอง',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'images/ud.jpg',
                    ),
                    title: Text('UDTOWN'),
                    subtitle: Text(reqhouse.houseAdd),
                    trailing: Text(
                      'กำลังเช่า',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[600]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                      leading: Image.asset(
                        'images/fr.jpg',
                      ),
                      title: Text('ฟอเรสท์ เพลส'),
                      subtitle: Text(
                          '235 หมู่ที่ 15 ต.ขามเรียง อ.กันทรวิชัย จ.มหาสารคาม'),
                      trailing: Text(
                        'ว่าง',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      )),
                ),
              ),
            ],
          )),
    );
  }

  // List<Testh> getphoto() {
  //   Future<String> photosJson = rootBundle.loadString('Json/photo.json');
  //   photosJson.then((value) {
  //     List<Testh> photos = testhFromJson(value);
  //   });

  //   return;
  // }
}
