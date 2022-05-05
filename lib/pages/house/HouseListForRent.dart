import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args  =  ModalRoute.of(context).settings.arguments;

  }



  Future<List<HouseAndImageModel>> getHome() async {
    var model = HouseAndImageModel();
    model.mid = args;
    model.houseStatus = 2;
     var jsonModel = houseAndImageToJson(model);
    final response = await http.post(Uri.parse
      ('https://home-alone-csproject.herokuapp.com/house/prerent'),
        body: jsonModel,
        headers: {
          'Content-Type': 'application/json',
          // 'Content-Type':  'application/x-www-form-urlencoded'
        });


    if (response.statusCode == 200) {
      return homes =
          houseAndImageModelFromJson(utf8.decode(response.bodyBytes));
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
          future: getHome(),
          builder: (BuildContext context,
              AsyncSnapshot<List<HouseAndImageModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("Has data");
              return SingleChildScrollView( child: Container(
                color: Color.fromRGBO(247, 207, 205, 1),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                // height: MediaQuery.of(context).size.height * 0.25,
                child: Column(children: <Widget>[
                  (snapshot.hasData)
                      ? Column(
                      children: snapshot.data.map((e)  {
                        return Card(

                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            child:
                            ListTile(
                              // onTap: () {
                              //   Navigator.pushNamed(context, '/Edithouse-page',arguments: homeall.hid.toString());
                              // },
                              leading:FittedBox(
                                fit: BoxFit.contain,child: Image.network(e.houseImage),alignment: Alignment.center, ) ,
                              title: Text(e.houseName,style: TextStyle(fontWeight: FontWeight.bold),),
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
                                                Text(e.houseProvince == null ?"" :"จ."+e.houseProvince,style: TextStyle(
                                                  color: Color.fromRGBO(250, 120, 186, 1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanit',
                                                ),),
                                              ),Align(alignment: Alignment.centerLeft,
                                                child:
                                                Text(e.houseDistrict == null ?"" :" อ."+e.houseDistrict,style: TextStyle(
                                                  color: Color.fromRGBO(250, 120, 186, 1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanit',
                                                ),),
                                              ),
                                            ],),
                                            Row(children: <Widget>[
                                              Align(alignment: Alignment.centerLeft,
                                                child: Text(e.houseType == null ? "":e.houseType+" ",style: TextStyle(
                                                  color: Color.fromRGBO(250, 120, 186, 1),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanit',
                                                ),),
                                              ),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Row(children: <Widget>[
                                                    Icon(Icons.king_bed,color: Color.fromRGBO(250, 120, 186, 1),size: 25,),Text(e.houseBedroom == null ? " ":e.houseBedroom.toString()+" ",style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),) ],)  ),

                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Row(children: <Widget>[
                                                    Icon(Icons.bathtub,color: Color.fromRGBO(250, 120, 186, 1),size: 20,),Text(e.houseBathroom == null ? " " :e.houseBathroom.toString()+" ",style: TextStyle(
                                                      color: Color.fromRGBO(250, 120, 186, 1),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),) ],)  ),

                                              Align(alignment: Alignment.centerLeft,
                                                child: Text(e.houseArea == null ? "":e.houseArea+" ",style: TextStyle(
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
                            )
                        );
                      }).toList())
                      : Container()],),),

              );
            } return LinearProgressIndicator();
          }),
    );
  }
}
