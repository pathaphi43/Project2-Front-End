import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:http/http.dart' as http;
import 'package:homealone/model/house/HouseAndImageModel.dart';

import 'dart:async';

class PreRent extends StatefulWidget {
  const PreRent({Key key}) : super(key: key);

  @override
  State<PreRent> createState() => _PreRentState();
}

class _PreRentState extends State<PreRent> {
  int args;
  List<HouseAndImageModel> homes;
 bool checkSend= true;
  @override
  void didChangeDependencies() async {
    args = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }
  void onRefresh(){
    getHome();

  }
  Future<void> onRefresh2 () {
    setState(() {
      getHome();
    });
    return Future.delayed(Duration(seconds: 1));
  }
  Future<List<HouseAndImageModel>> getHome() async {
    var model = HouseAndImageModel();
    model.mid = args;
    model.houseStatus = 2;
    var jsonModel = houseAndImageToJson(model);
    final response = await http.post(
        Uri.parse('https://home-alone-csproject.herokuapp.com/house/prerent'),
        body: jsonModel,
        headers: {
          'Content-Type': 'application/json',
          // 'Content-Type':  'application/x-www-form-urlencoded'
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return homes =
          houseAndImageModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
      ),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: getHome(),
          builder: (BuildContext context,
              AsyncSnapshot<List<HouseAndImageModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                                  IconSlideAction(
                                    caption: 'ยืนยัน',
                                    color: Colors.green,
                                    icon: Icons.check,
                                    onTap: () {
                                      print(e.houseName);
                                      Navigator.pushNamed(context, '/Addrent-page',
                                          arguments: [e.hid, e.houseStatus]);
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'ยกเลิก',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => showDialog<String>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('ยืนยันการยกเลิก '),
                                        content: Text('ยืนยันการยกเลิก '+e.houseName),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                            child: const Text('ยกเลิก'),
                                          ),
                                          TextButton(
                                            onPressed: ()async {
                                              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                                duration: new Duration(seconds: 4),
                                                content: new Row(
                                                  children: <Widget>[
                                                    new CircularProgressIndicator(),
                                                    new Text("กำลังโหลด...")
                                                  ],
                                                ),
                                              ));
                                              print("ยืนยัน"+e.hid.toString());
                                              var response = await http.get(
                                                  Uri.parse('https://home-alone-csproject.herokuapp.com/house/cancelrent/'+e.hid.toString()),
                                                  headers: {
                                                    'Content-Type': 'application/json'
                                                  });
                                              if (response.statusCode == 200){
                                                setState(() {
                                                  getHome();
                                                });
                                                Navigator.pop(context, 'ยืนยัน');
                                              }else print("Upload fail"+ response.statusCode.toString());
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
            }
            return LinearProgressIndicator();
          }),
    );
  }

  Widget _getSlidableWithLists(HouseAndImageModel e) => Builder(
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
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child:Text(homeall.houseAddress == null ?"" :homeall.houseAddress,style: TextStyle(
                  //     color: Color.fromRGBO(250, 120, 186, 1),
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'Kanit',
                  //   ),),),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.houseArea == null ? "" : e.houseArea + " ",
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
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
