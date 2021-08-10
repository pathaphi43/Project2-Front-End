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
                                Row(children: <Widget>[
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
                                  Expanded(
                                      child: Column(children: <Widget>[
                                    Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(homeall.houseName,style: _biggerFont,),
                                        )
                                    ),
                                    Expanded(
                                        child:Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("see more detail and click to detail about",style: _blueFont,),
                                        ))
                                      ],))
                                ],)
                                // ListTile(
                                //   leading: Image.network(homeall.houseImage),
                                //   title: Text(homeall.houseName),
                                //   subtitle: Row(
                                //     children: <Widget>[Text(homeall.houseAdd)],
                                //   ),
                                //   trailing: Text(
                                //     (homeall.houseStatus == 0)
                                //         ? 'ว่าง'
                                //         : (homeall.houseStatus == 1)
                                //         ? 'กำลังเช่า'
                                //         : (homeall.houseStatus == 2)
                                //         ? 'ติดจอง'
                                //         : 'ยกเลิก',
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       color: (homeall.houseStatus == 0)
                                //           ? Colors.green
                                //           : (homeall.houseStatus == 1)
                                //           ? Colors.yellow[600]
                                //           : (homeall.houseStatus == 2)
                                //           ? Colors.orange
                                //           : Colors.red,
                                //     ),
                                //   ),
                                // )
                            );
                          }).toList())
                          : Container()],),),

                      ),
                      onRefresh: gethomeAll,
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