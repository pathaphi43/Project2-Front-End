import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'package:anim_search_bar/anim_search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  Future<House> gethomeAll(String search) async {
    // http://homealone.comsciproject.com/searchhouse/name/ส
    // print('homealone.comsciproject.com/searchhouse/name/'+search);
    final response = await http
        .get(Uri.http('homealone.comsciproject.com','/searchhouse/name/'+search));
    print(response.statusCode);

    if (response.statusCode == 200) {
      homedata = houseFromJson(response.body);
      print(homedata[0].houseName);
    } else {
      throw Exception('Failed to load homedata');
    }
    return homeall.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView(children: <Widget>[Column(children: <Widget>[

          Container(
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  //decoration: kBoxDecorationStyle ,
                  height: 80.0,
                  width: 300.0,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Color.fromRGBO(250, 120, 186, 1),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่อบ้านเช่า',
                        labelStyle: new TextStyle(
                            color: const Color.fromRGBO(250, 120, 186, 1)
                        ),
                        // hintText: 'Enter valid mail id as abc@gmail.com'
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                        )
                    ),onSubmitted: (value) {
                      setState(() {


                      _searchText = value;
                      gethomeAll(value);
                      });
                    },
                    // keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: gethomeAll(_searchText),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("snapshot OK");
                  return SingleChildScrollView( child: Container(
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
                      );
                } return LinearProgressIndicator();
              }),
        ],)
        ],)
    );

  }
}
