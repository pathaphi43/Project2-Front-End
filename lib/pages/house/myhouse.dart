import 'dart:convert';
import 'dart:ui';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:homealone/model/homemodel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';

import 'package:http/http.dart' as http;

import 'dart:async';

String args;

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

  }
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _blueFont = const TextStyle(color: Colors.blueAccent);
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
    args = ModalRoute.of(context).settings.arguments;
    print(args);
    // gethomeAll(args);
  }
  Future<List<House>> gethomeAll(String id) async {
    final response = await http
        .get(Uri.http('home-alone-csproject.herokuapp.com', '/house/manager/'+id));
    print(response.statusCode);
    if (response.statusCode == 200) {
     return  homeall = housesFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
      ),
      resizeToAvoidBottomInset: false,
      body:FutureBuilder(
          future: gethomeAll(args),
          builder: (BuildContext context, AsyncSnapshot<List<House>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("snapshot OK");
              return SingleChildScrollView(
                child: Container(
                  color: Color.fromRGBO(247, 207, 205, 1),
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                  padding:
                  EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                  // height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    children: <Widget>[
                      (snapshot.hasData)
                          ? Column(
                          children: snapshot.data.map((e) {
                            return Slidable(
                              closeOnScroll: true,
                              // key:ValueKey(e.hid),
                              key: Key(e.hid.toString()),
                              actionPane: SlidableDrawerActionPane(),
                              // actionExtentRatio: 0.1,
                              secondaryActions: <Widget>[
                               if(e.houseStatus == 0 || e.houseStatus == 1 || e.houseStatus == 2) IconSlideAction(
                                  caption: 'แก้ไข',
                                  color: Colors.green,
                                  icon: Icons.check,
                                  onTap: () => showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('การแก้ไข '),
                                      content: Text('เลือกการแก้ไขบ้าน '+e.houseName),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: ()async {
                                            Navigator.pushNamed(context, '/Edithouse-page',
                                                arguments: e);
                                          },
                                          child: const Text('แก้ไขข้อมูล'),
                                        ),
                                        TextButton(
                                          onPressed: ()async {
                                            Navigator.pushNamed(context, '/EditImageHouse-page',arguments: e);
                                          },
                                          child: const Text('แก้ไขรูป'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('ยกเลิก'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                               if(e.houseStatus == 0) IconSlideAction(
                                  caption: 'ลบบ้านเช่า',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () => showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('ยืนยันลบ '),
                                      content: Text('ยืนยันการลบ '+e.houseName),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('ยกเลิก'),
                                        ),
                                        TextButton(
                                          onPressed: ()async {
                                          print('onPressed');
                                          },
                                          child: const Text('ยืนยัน'),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                              child: _getSlidableWithLists(e),
                            );
                          }).toList())
                          : Container()
                    ],
                  ),
                ),
              );


            } return LinearProgressIndicator();
          }),
    );

  }
  Widget _getSlidableWithLists(House e) => Builder(
    builder: (context) =>  Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        onTap: () {
          final slidable = Slidable.of(context);
          final isClosed = slidable.renderingMode == SlidableRenderingMode.none;
          if(isClosed){
            Future.delayed(Duration.zero,(){
              if(slidable.mounted){
                slidable.open(actionType: SlideActionType.secondary);
              }
            });

          }
          else{
            slidable.close();
          }
        },
        leading: Image.network(e.houseImage),
        title: Text(
          e.houseName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(children: <Widget>[
          Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e.houseProvince == null ? "" : "จ." + e.houseProvince,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e.houseDistrict == null
                              ? ""
                              : " อ." + e.houseDistrict,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.houseType == null ? "" : e.houseType + " ",
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.king_bed,
                              color: Color.fromRGBO(250, 120, 186, 1),
                              size: 25,
                            ),
                            Text(
                              e.houseBedroom == null
                                  ? " "
                                  : e.houseBedroom.toString() + " ",
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            )
                          ],
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.bathtub,
                              color: Color.fromRGBO(250, 120, 186, 1),
                              size: 20,
                            ),
                            Text(
                              e.houseBathroom == null
                                  ? " "
                                  : e.houseBathroom.toString() + " ",
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            )
                          ],
                        )),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     e.houseArea == null ? "" : e.houseArea + " ",
                    //     style: TextStyle(
                    //       color: Color.fromRGBO(250, 120, 186, 1),
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: 'Kanit',
                    //     ),
                    //   ),
                    // ),
                  ])
                ],
              )),
        ]),
        trailing: Text(
          (e.houseStatus == 0)
              ? 'ว่าง'
              : (e.houseStatus == 1)
              ? 'กำลังเช่า'
              : (e.houseStatus == 2)
              ? 'ติดจอง'
              : 'ยกเลิก',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: (e.houseStatus == 0)
                ? Colors.green
                : (e.houseStatus == 1)
                ? Colors.yellow[600]
                : (e.houseStatus == 2)
                ? Colors.orange
                : Colors.red,
          ),
        ),
      ),
    ),
  );
}



