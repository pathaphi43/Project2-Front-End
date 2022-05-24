import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:homealone/model/AmphureThailand.dart';
import 'package:homealone/model/Thailand.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _ChoseValue;
  var _ChoseValueAmphureThailand;


  List<Widget> showWidgets = [
    SearchPage(),
    MapPage(),
    HomePage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;
  TextEditingController textController = TextEditingController();
  String getText(){
    return textController.text;
  }
  String _searchText = "";
  List<House> homedata;
  Stream<List<dynamic>> onCurrentUserChanged;
  StreamController<List<dynamic>> currentUserStreamCtrl = new StreamController<List<dynamic>>.broadcast();

  Future<List<House>> gethomeAll(String search) async {
    // http://homealone.comsciproject.com/searchhouse/name/ส
    // print('homealone.comsciproject.com/searchhouse/name/'+search);
    final response = await http
        .get(Uri.http('home-alone-csproject.herokuapp.com','/house/search/'+search));
    print(response.statusCode);
    if (response.statusCode == 200) {
      currentUserStreamCtrl.sink.add(housesFromJson(utf8.decode(response.bodyBytes)));
      return homedata = housesFromJson(utf8.decode(response.bodyBytes));
      print(homedata[0].houseName);
    } else {
      throw Exception('Failed to load homedata');
    }
    // return homeall.first;
  }


  void initState() {
    // super.initState();
    _Thailand();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<Thailand> province_th =[];
  List<AmphureThailand> Amphurethai =[];

  _Thailand() async{
    var list = await ProvinceProvider.all();
    ProvinceDao province ;
    for(province in list){
      // province.nameTh;
      // province.nameEn;
      // province.id;
      print("111111111111111111111111111");
      province_th.add(new Thailand(
        name: province.nameTh.toString(),
        id: province.id.toString(),
      ));
    }
    // var lists = await AddressProvider.all();
    setState(() {

    });
    // print(province_th);
  }
  _Amphure(value) async{
    // var Amphuree = await AmphureProvider.searchInProvince(provinceId: 1);

    // AmphureDao amphure ;
    var list = await AmphureProvider.all(provinceId: int.parse(value));

    Amphurethai.removeRange(0,Amphurethai.length);


    // Future<void> onRefresh () {
    //   setState(() {
    //     gethomeAll();
    //   });
    //   return Future.delayed(Duration(seconds: 1));
    // }

    for(AmphureDao amphure in list){
      // amphure.id;
      // amphure.provinceId;
      // amphure.nameTh;
      // amphure.nameEn;
      Amphurethai.add(new AmphureThailand(
        name: amphure.nameTh.toString(),
        id: amphure.id.toString(),
      ));
      print(amphure.nameTh);
    }

    setState(() {

    });
    // print(Amphuree);
  }

  String dropdownValue1 = 'กรุงเทพฯ';
  void startHammering() {
    print('success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView(children: <Widget>[
          Column(children: <Widget>[

            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height/4,
              width: 350.0,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                //////// tab bar
                     ButtonsTabBar(
                      backgroundColor: Color.fromRGBO(250, 120, 186, 1),
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle: TextStyle(color: Colors.white),
                      labelStyle:
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      ),
                      //borderWidth: 4,
                      tabs: [
                        Tab(icon: Icon(Icons.home),
                          text: "ชื่อบ้าน",),
                        Tab(icon: Icon(Icons.playlist_add_check),
                          text: "สถานะ",),
                        Tab(icon: Icon(Icons.add_location),
                          text: "ตำแหน่ง",),
                      ],
                    ),

                /////// show page tab bar
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Center(
                          child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.0),
                                  new Container(
                                    alignment: Alignment.center,
                                    height: 45.0,
                                    width: 300.0,
                                    child: Center(
                                      child: TextField(
                                        cursorColor: Color.fromRGBO(250, 120, 186, 1),
                                        style: TextStyle(
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Kanit',
                                        ),
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color.fromRGBO(250, 120, 186, 1), width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(250, 120, 186, 1),
                                                width: 2.0),
                                          ),
                                          hintText: 'ค้นหาชื่อบ้าน',
                                          hintStyle: TextStyle(
                                            color: Color.fromRGBO(250, 120, 186, 1),
                                            fontSize: 14.0,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Kanit',
                                          ),
                                          prefixIcon: Icon(Icons.search,
                                            color: Color.fromRGBO(250, 120, 186, 1),
                                          ),
                                        ),
                                        onSubmitted: (value) {
                                          setState(() {
                                            _searchText = value;
                                            gethomeAll(value);
                                          });
                                        },
                                      ),
                                    ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     new Text('จังหวัด',
                                    //       style: TextStyle(
                                    //         color: Color.fromRGBO(250, 120, 186, 1),
                                    //         fontSize: 18.0,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontFamily: 'Kanit',
                                    //       ),
                                    //     ),
                                    //
                                    //     new Container(
                                    //       alignment: Alignment.centerRight,
                                    //       height: 70.0,
                                    //       width: 220.0,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(200),
                                    //       ),
                                    //       child: DropdownButton<String>(
                                    //         icon: const Icon(
                                    //           Icons.arrow_circle_down,
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //         ),
                                    //         //iconSize: 25,
                                    //         //iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                    //         elevation: 10,
                                    //         style: const TextStyle(
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //           fontSize: 18,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontFamily: 'Kanit',
                                    //         ),
                                    //         underline: Container(
                                    //           height: 1,
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //         ),
                                    //         value: _ChoseValue,
                                    //         hint: Text(
                                    //           "  -- โปรดเลือก --  ",
                                    //           style: TextStyle(
                                    //               color: Color.fromRGBO(250, 120, 186, 1),
                                    //               fontSize: 18,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //         // value: dropdownValue1,
                                    //
                                    //         items: province_th.map((item) {
                                    //           return DropdownMenuItem<String>(
                                    //             value: item.id,
                                    //             child: Text(item.name,
                                    //                 style: TextStyle(
                                    //                     color: Color.fromRGBO(250, 120, 186, 1),
                                    //                     fontSize: 18)
                                    //             ),
                                    //
                                    //             // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                    //           );
                                    //         })?.toList(),
                                    //
                                    //         onChanged: (value) {
                                    //           setState(() {
                                    //             _ChoseValue = value;
                                    //             // print(_ChoseValue);
                                    //             _Amphure(_ChoseValue);
                                    //           });
                                    //         },
                                    //
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     new Text('อำเภอ',
                                    //       style: TextStyle(
                                    //         color: Color.fromRGBO(250, 120, 186, 1),
                                    //         fontSize: 18.0,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontFamily: 'Kanit',
                                    //       ),
                                    //     ),
                                    //     new Container(
                                    //       alignment: Alignment.centerRight,
                                    //       height: 70.0,
                                    //       width: 220.0,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(200),
                                    //       ),
                                    //
                                    //       child: DropdownButton<String>(
                                    //         icon: const Icon(
                                    //           Icons.arrow_circle_down,
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //         ),
                                    //         //iconSize: 25,
                                    //         //  iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                    //         elevation: 10,
                                    //         style: const TextStyle(
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //           fontSize: 18,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontFamily: 'Kanit',
                                    //         ),
                                    //         underline: Container(
                                    //           height: 1,
                                    //           color: Color.fromRGBO(250, 120, 186, 1),
                                    //         ),
                                    //         value: _ChoseValueAmphureThailand,
                                    //         hint: Text(
                                    //           "  -- โปรดเลือก --  ",
                                    //           style: TextStyle(
                                    //               color: Color.fromRGBO(250, 120, 186, 1),
                                    //               fontSize: 18,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //         // value: dropdownValue1,
                                    //
                                    //         items: Amphurethai.map((item) {
                                    //           return DropdownMenuItem<String>(
                                    //             value: item.id,
                                    //             child: Text(item.name,
                                    //                 style: TextStyle(
                                    //                     color: Color.fromRGBO(250, 120, 186, 1),
                                    //                     fontSize: 18)
                                    //             ),
                                    //
                                    //             // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                    //           );
                                    //         })?.toList(),
                                    //
                                    //         onChanged: (value) {
                                    //           setState(() {
                                    //             _ChoseValueAmphureThailand = value;
                                    //             // print(_ChoseValue);
                                    //
                                    //           });
                                    //         },
                                    //
                                    //       ),
                                    //     ),
                                    //   ],
                                  ),
                                ],
                              ),
                            ),
                        ),
                        Center(
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) {return Container(child: Text('ว่าง'),);  }),
                                    );
                                  },
                                  child: Text(
                                    "ว่าง",
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 97, 26, 1),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),

                                ),
                                SizedBox(width: 20.0),
                                Container( height: 15 ,width: 1, color: Colors.black), // This is divider
                                SizedBox(width: 20.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) { return Container(child: Text('ไม่ว่าง'),); }),
                                    );
                                  },
                                  child: Text(
                                    "ไม่ว่าง",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text('จังหวัด',
                                      style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kanit',
                                      ),
                                    ),

                                    new Container(
                                      alignment: Alignment.centerRight,
                                      height: 40.0,
                                      width: 200.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                      ),
                                      child: DropdownButton<String>(
                                        icon: const Icon(
                                          Icons.arrow_circle_down,
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                        ),
                                        //iconSize: 25,
                                        //iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                        elevation: 10,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Kanit',
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                        ),
                                        value: _ChoseValue,
                                        hint: Text(
                                          "  -- โปรดเลือก --  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(250, 120, 186, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // value: dropdownValue1,

                                        items: province_th.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.name,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(250, 120, 186, 1),
                                                    fontSize: 16)
                                            ),

                                            // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                          );
                                        })?.toList(),

                                        onChanged: (value) {
                                          setState(() {
                                          });
                                        },

                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text('อำเภอ',
                                      style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kanit',
                                      ),
                                    ),
                                    new Container(
                                      alignment: Alignment.centerRight,
                                      height: 40.0,
                                      width: 200.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                      ),

                                      child: DropdownButton<String>(
                                        icon: const Icon(
                                          Icons.arrow_circle_down,
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                        ),
                                        //iconSize: 25,
                                        //  iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                        elevation: 10,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Kanit',
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Color.fromRGBO(250, 120, 186, 1),
                                        ),
                                        value: _ChoseValueAmphureThailand,
                                        hint: Text(
                                          "  -- โปรดเลือก --  ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(250, 120, 186, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // value: dropdownValue1,

                                        items: Amphurethai.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.name,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(250, 120, 186, 1),
                                                    fontSize: 16)
                                            ),

                                            // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                          );
                                        })?.toList(),

                                        onChanged: (value) {
                                          setState(() {

                                          });
                                        },

                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: currentUserStreamCtrl.stream,
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.active) {

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
                                : Container(child: Text('ไม่พบ'),)
                          ],
                        ),
                      ),
                    );


                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return LinearProgressIndicator();
                  }
                  else return LinearProgressIndicator();
                }),
        ],)
        ],)
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
