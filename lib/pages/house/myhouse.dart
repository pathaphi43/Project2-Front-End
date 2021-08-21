import 'dart:ui';

import 'package:homealone/model/homemodel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'dart:async';

class MyHouse extends StatefulWidget {
  const MyHouse({Key key}) : super(key: key);

  @override
  _MyHouseState createState() => _MyHouseState();
}

class _MyHouseState extends State<MyHouse> {
  List<House> homeall;

  @override
  void initState() {
    super.initState();
    gethomeAll();
  }
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _blueFont = const TextStyle(color: Colors.blueAccent);

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
              print("snapshot OK");
              return new RefreshIndicator(
                  child:  SingleChildScrollView( child: Container(
                    color: Color.fromRGBO(247, 207, 205, 1),
                    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                    // height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(children: <Widget>[
                      (homeall != null)
                          ? Column(
                          children: homeall.map((homeall) {
                            return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                child:
                                ListTile(
                                  leading:FittedBox(
                                    fit: BoxFit.contain,child: Image.network(homeall.houseImage),alignment: Alignment.center, ) ,
                                  title: Text(homeall.houseName,style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text(homeall.houseAdd == null ?"" :homeall.houseAdd,style: TextStyle(
                                                    color: Color.fromRGBO(250, 120, 186, 1),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Kanit',
                                                  ),),),
                                                Row(children: <Widget>[
                                                  Align(alignment: Alignment.centerLeft,
                                                    child:
                                                    Text(homeall.houseProvince == null ?"" :"จ."+homeall.houseProvince,style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),),
                                                  ),Align(alignment: Alignment.centerLeft,
                                                    child:
                                                    Text(homeall.houseDistrict == null ?"" :" อ."+homeall.houseDistrict,style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),),
                                                  ),
                                                ],),



                                                Row(children: <Widget>[
                                                  Align(alignment: Alignment.centerLeft,
                                                    child: Text(homeall.houseType == null ? "":homeall.houseType+" ",style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),),
                                                  ),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Row(children: <Widget>[
                                                        Icon(Icons.king_bed,color: Color.fromRGBO(250, 120, 186, 1),size: 25,),Text(homeall.houseBedroom == null ? " ":homeall.houseBedroom.toString()+" ",style: TextStyle(
                                                          color: Color.fromRGBO(250, 120, 186, 1),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Kanit',
                                                        ),) ],)  ),

                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Row(children: <Widget>[
                                                        Icon(Icons.bathtub,color: Color.fromRGBO(250, 120, 186, 1),size: 20,),Text(homeall.houseBathroom == null ? " " :homeall.houseBathroom.toString()+" ",style: TextStyle(
                                                          color: Color.fromRGBO(250, 120, 186, 1),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Kanit',
                                                        ),) ],)  ),

                                                  Align(alignment: Alignment.centerLeft,
                                                    child: Text(homeall.houseArea == null ? "":homeall.houseArea+" ",style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),),
                                                  ),

                                                ])



                                              ],

                                            )) ,
                                      ]),
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
                                )
                            );
                          }).toList())
                          : Container()],),),

                  ),
                  onRefresh:gethomeAll
              );
            } return LinearProgressIndicator();
          }),
    );
  }
}
