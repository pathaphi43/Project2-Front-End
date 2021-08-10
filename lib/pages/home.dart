import 'dart:ui';

import 'package:homealone/model/homemodel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'dart:async';


List<House> homeall;
List<House> homedata;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    gethomeAll();
  }

  Future<House> gethomeAll() async {
    final response = await http
        .get(Uri.http('homealone.comsciproject.com', '/home/allhome'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      homeall = houseFromJson(response.body);

    } else {
      throw Exception('Failed to load homedata');
    }
    return homeall.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:FutureBuilder(
          future: gethomeAll(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              return new Container(
                  child: new Center(
                child: new RefreshIndicator(
                  child:  SingleChildScrollView( child: Container(child: Column(children: <Widget>[(homeall != null)
                      ? Column(
                      children: homeall.map((homeall) {
                        return Card(
                            child: ListTile(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(''),
                                  duration: const Duration(seconds: 1),
                                  action: SnackBarAction(
                                    label: 'ShowHomeID:' +
                                        homeall.hid.toString(),
                                    onPressed: () {
                                      print(homeall.hid);
                                    },
                                  ),
                                ));
                              },
                              leading: Image.network(homeall.houseImage),
                              title: Text(homeall.houseName),
                              subtitle: Row(
                                children: <Widget>[Text(homeall.houseAdd)],
                              ),
                              trailing: Text(
                                (homeall.houseStatus == 0)
                                    ? 'ว่าง'
                                    : (homeall.houseStatus == 1)
                                    ? 'กำลังเช่า'
                                    : (homeall.houseStatus == 2)
                                    ? 'ติดจอง'
                                    : 'ยกเลิก',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (homeall.houseStatus == 0)
                                      ? Colors.green
                                      : (homeall.houseStatus == 1)
                                      ? Colors.yellow[600]
                                      : (homeall.houseStatus == 2)
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                              ),
                            ));
                      }).toList())
                      : Container()],),),

                  ),
                  onRefresh: gethomeAll,
                ),
              ));
            }
            return LinearProgressIndicator();
          }),
    );
  }
}
