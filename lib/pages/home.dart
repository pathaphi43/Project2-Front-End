import 'dart:convert';
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

  TextStyle _textStyle(){
    TextStyle(color: Color.fromRGBO(250, 120, 186, 1),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kanit',
        );
  }

  @override
  void initState() {
    super.initState();
    gethomeAll();
  }
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _blueFont = const TextStyle(color: Colors.blueAccent);

  Future<List<House>> gethomeAll() async {
    final response = await http
        .get(Uri.http('homealone-springcloud.azuremicroservices.io', '/house/all'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return homeall = houseFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }

    print(homeall[0].houseName);

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
                                                  child:Text(homeall.houseAddress== null ?"" :homeall.houseAddress,style: TextStyle(
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
                                                    Icon(Icons.king_bed,color: Color.fromRGBO(250, 120, 186, 1),size: 15,),Text(homeall.houseBedroom == null ? " ":homeall.houseBedroom.toString()+" ",style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),) ],)  ),

                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child:Row(children: <Widget>[
                                                      Icon(Icons.bathtub,color: Color.fromRGBO(250, 120, 186, 1),size: 15,),Text(homeall.houseBathroom == null ? " " :homeall.houseBathroom.toString()+" ",style: TextStyle(
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
// return  Container(margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
// padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
// height: MediaQuery.of(context).size.height * 0.25,
// child: Card(
// color:Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0),
// ),
// child: Row(children: <Widget>[Expanded(child: FittedBox(fit: BoxFit.contain,child: ,))],),
//
// ),);
//

// }
// return LinearProgressIndicator();
// Row(children: <Widget>[
// Expanded(
//     child: FittedBox(
//       // alignment: Alignment.centerLeft,
//       fit: BoxFit.contain,
//       child: Image.network(homeall.houseImage,
//       width: 100,height: 100,
//       )
//
//     )
// ),
//   Expanded(
//       child: Column(children: <Widget>[
//     Expanded(
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Text(homeall.houseName,style: _biggerFont,),
//         )
//     ),
//     Expanded(
//         child:Align(
//           alignment: Alignment.centerLeft,
//           child: Text("see more detail and click to detail about",style: _blueFont,),
//         ))
//       ],))
// ],)

// homeall.map((homeall){
// print("Homeall Ok");
// return   Container(
// margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
// padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
// height: MediaQuery.of(context).size.height * 0.25,

// child:Card(color: Colors.white,shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0)),child:
// Row(children: <Widget>[
// Expanded(child: FittedBox(fit: BoxFit.contain,child: Image.network(homeall.houseImage)),),
// Expanded(child: Column(children: <Widget>[
// Expanded(child: Align(
// alignment: Alignment.centerLeft,
// child: Text(homeall.houseName,style: _biggerFont),
// )),
// Expanded(child: Align(
// alignment: Alignment.centerLeft,
// child: Text(homeall.houseAdd,style: _blueFont,),
// ))
// ]))
// ],
// ))
// );

// }).toList();