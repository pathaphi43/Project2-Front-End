import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<List<House>> gethomeAll(String search) async {
    // http://homealone.comsciproject.com/searchhouse/name/ส
    // print('homealone.comsciproject.com/searchhouse/name/'+search);
    final response = await http
        .get(Uri.http('home-alone-csproject.herokuapp.com','/house/search/'+search));
    print(response.statusCode);

    if (response.statusCode == 200) {
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
                length: 4,
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
                        Tab(icon: Icon(Icons.pending),
                          text: "ประเภท",),
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
                                          hintText: 'search',
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
                                      MaterialPageRoute(builder: (BuildContext context) {  }),
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
                                      MaterialPageRoute(builder: (BuildContext context) {  }),
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
                          child: Text("ประเภท") ,
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

            FutureBuilder(
              future: gethomeAll(_searchText),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("snapshot OK");
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        color: Color.fromRGBO(247, 207, 205, 1),
                        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                        // height: MediaQuery.of(context).size.height * 0.25,

                        child: Column(children: <Widget>[
                          (homedata != null)
                              ? Column(
                              children: homedata.map((homeall) {
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
                                                    // Align(
                                                    //   alignment: Alignment.centerLeft,
                                                    //   child:Text(homeall.houseAddress == null ?"" :homeall.houseAddress,style: TextStyle(
                                                    //     color: Color.fromRGBO(250, 120, 186, 1),
                                                    //     fontSize: 16,
                                                    //     fontWeight: FontWeight.bold,
                                                    //     fontFamily: 'Kanit',
                                                    //   ),),),
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
                              : Container()
                        ],
                        ),
                       ),
                      );
                } return LinearProgressIndicator();
              }),
        ],)
        ],)
    );

  }
}
