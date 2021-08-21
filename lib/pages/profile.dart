import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' show utf8;
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
SharedPreferences prefs;
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> showWidgets = [
    HomePage(),
    SearchPage(),
    MapPage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;
  List<Manager> managerdata;
  List<Tenant> tenantdata;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   asyncFunc();
  }

  int id;

  asyncFunc()async {
    print('asyncFunc()');
     prefs = await SharedPreferences.getInstance();
     id = prefs.getInt('id');
     if(id != null){
       if(id == 0){
         getManager(id);
       }else if(id == 1){
         getTenant(id);
       }

     }
     print('asyncFunc()'+id.toString());
  }

  Future<Manager> getManager(int id) async {
    final response = await http.get(
        Uri.http('homealone.comsciproject.com', '/manager/manager/' + id.toString()));
    setState(() {
      // print(response.statusCode);
      if (response.statusCode == 200) {
        managerdata = managerFromJson(response.body);

      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  Future<Tenant> getTenant(int id) async {
    final response = await http.get(
        Uri.http('homealone.comsciproject.com', '/tenant/tenant/' + id.toString()));
    setState(() {
      print(response.statusCode);
      if (response.statusCode == 200) {
        tenantdata = tenantFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      print("build"+id.toString());
      print(managerdata != null);
      if(managerdata != null){
       return managerWidget(context);
      }else return Container();


  }
}

Widget managerWidget(BuildContext context){
  return Scaffold(
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 80.0,
                        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
                        //backgroundImage: ,
                        child: IconButton(
                          padding: EdgeInsets.all(110),
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.white,
                          onPressed: () => print('Open file OK'),
                          //async {
                          //   var image = await ImagePicker()
                          //       .pickImage(source: ImageSource.gallery);
                          // },
                        ),
                      ),
                      // (image != null) ? Image.file(image) : Container()
                    ],
                  ),
                ),
              ),
////////////////////////////////////////////////////////////////////////////////
//////////////////////////ชื่อ-สกุล , Username/////////////////////////////////////
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      managerdata[0].managerFirstname+" "+managerdata[0].managerLastname,
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      managerdata[0].managerUsername,
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  )
                ],
              ),
////////////////////////////////////////////////////////////////////////////////
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      minWidth: 100.0,
                      height: 40.0,
                      onPressed: () {},
                      child: Text(
                        "แก้ไขข้อมูลส่วนตัว",
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(250, 120, 186, 1),
                        ),
                      ),
                    ),
                  ),
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new FlatButton(
                          color: Color.fromRGBO(247, 207, 205, 1),
                          minWidth: 30.0,
                          height: 90.0,
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => page8()),
                            // );
                          },
                          child: Text(
                            "ข้อมูลบ้านเช่า",
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                                  width: 2.0,
                                  color: Color.fromRGBO(250, 120, 186, 1))),
                        ),
                      ),

                      ////////////////////////////////////////////////////////////////////////////////

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: new FlatButton(
                          color: Color.fromRGBO(247, 207, 205, 1),
                          minWidth: 60.0,
                          height: 90.0,
                          onPressed: () {
                            Navigator.pushNamed(context, '/Review-page',arguments: null);

                          },
                          child: Text(
                            "    เขียนรีวิว    ",
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                                  width: 2.0,
                                  color: Color.fromRGBO(250, 120, 186, 1))),
                        ),
                      ),
                    ],
                  ),

////////////////////////////////////////////////////////////////////////////////

                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: new FlatButton(
                      //minWidth: 200.0,
                      height: 70.0,
                      color: Colors.red,
                      onPressed: () {
                        prefs.clear();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/main-page',
                              (Route<dynamic> route) => false,
                        );
                        managerdata = null;
                        tenantdata = null;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ออกจากระบบ  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                      shape: StadiumBorder(
                          side: BorderSide(width: 1.0, color: Colors.red)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}