import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' show utf8;
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'dart:async';
SharedPreferences prefs;
// int id,status;
int index = 0;
Manager managerdata;
Tenant tenantdata;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  void initState() {
    super.initState();
        // asyncFunc();
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    asyncFunc();
  }

  asyncFunc()async {
     prefs = await SharedPreferences.getInstance();

     MainPages().createState().asyncFunc();

  }

  Future<Manager> getManager(int id) async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/manager/id/' + id.toString()));

      // print(response.statusCode);
      if (response.statusCode == 200) {
        managerdata = managerFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    // setState(() {});
  }

  Future<Tenant> getTenant(int id) async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/tenant/id/' + id.toString()));

      print(response.statusCode);
      if (response.statusCode == 200) {
        tenantdata = tenantFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    // setState(() {});
  }


  File image;
  Future pickImage(BuildContext context) async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return null;
      final imageTemporary = File(image.path);
      // setState(() {
        this.image = imageTemporary;
      // });
      return Navigator.pushNamed(context, '/ManagerEditProfile-page',
          arguments: imageTemporary);
    }on PlatformException catch (e){
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
// print("profile Status"+status.toString());
      if(status == 0){
        return managerWidget(context);
      }else if(status == 1){
        return tenantWidget(context);
  }else return notloginWidget(context);
  }
}

Widget managerWidget(BuildContext context){
  File image;
  return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:NetworkImage(imageProfile == null?"http://homealone.comsciproject.com/img/local_avatar.png" :imageProfile),
                        radius: 80.0,
                        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
                        //backgroundImage: ,
                        child: IconButton(
                          padding: EdgeInsets.all(110),
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.blueGrey[200],
                          onPressed: () {
                            if(_ProfilePageState().pickImage(context) != null){
                              _ProfilePageState().pickImage(context);
                            }

                               // image = _ProfilePageState().image;
                          },

                        ),
                      ),
                      // (image != null) ? Image.file(image) : Container()
                    ],
                  ),
                ),
              ),
////////////////////////////////////////////////////////////////////////////////
//////////////////////////ชื่อ-สกุล , Username/////////////////////////////////////
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(firstName +" "+lastName,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                             IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.blueGrey[200],
                              onPressed: () {
                                Navigator.pushNamed(context, '/Editmanager-page',
                                arguments: [
                                  id.toString(),
                                  status.toString()
                                ]);
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        userName,
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
              ),
////////////////////////////////////////////////////////////////////////////////
              
              Container(
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blueGrey[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                            color: Color.fromRGBO(247, 207, 205, 1),
                            minWidth: MediaQuery.of(context).size.width/2.3,
                            height: 100.0,
                            onPressed: () {
                              Navigator.pushNamed(context, '/Myhouse-page',arguments: id.toString());
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(250, 120, 186, 1))),
                          ),
                          FlatButton(
                            color: Color.fromRGBO(247, 207, 205, 1),
                            minWidth: MediaQuery.of(context).size.width/2.3,
                            height: 100.0,
                            onPressed: () {
                             Navigator.pushNamed(context, '/Income-page',arguments: id.toString());
                            },
                            child: Text(
                              "ข้อมูลรายได้",
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(250, 120, 186, 1))),
                          ),
                      ],
                    ),
                    
                  FlatButton(
                        minWidth: MediaQuery.of(context).size.height/5.5,
                        height: 55.0,
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
                          ProfilePage().createState().didChangeDependencies();
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
                  ],
                ),
              )
            ],
          ),

        ),
      ));
}


Widget tenantWidget(BuildContext context){
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
                        backgroundImage: NetworkImage((imageProfile == null?"http://homealone.comsciproject.com/img/local_avatar.png" :imageProfile)),
                        radius: 80.0,
                        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
                        //backgroundImage: ,
                        child: IconButton(
                          padding: EdgeInsets.all(110),
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {
                            if(_ProfilePageState().pickImage(context) != null){
                              _ProfilePageState().pickImage(context);
                            }
                          },
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
                      firstName +" "+lastName,
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
                      userName,
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
                      onPressed: () {
                       print("Edit ok"+id.toString());
                      },
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

Widget notloginWidget(BuildContext context){
   return Scaffold(
    body: Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('img/biglogo.png'),
              new Padding(
                child: new FlatButton(
                  minWidth: 300.0,
                  height: 60.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login-page');
                  },
                  child: Text(
                    "ลงชื่อเข้าใช้",
                    style: TextStyle(
                      color: Color.fromRGBO(2, 97, 26, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(
                          width: 3.0,
                          color: Color.fromRGBO(247, 207, 205, 1))),
                ),
                padding: const EdgeInsets.all(20.0),
              ),
              new Padding(
                child: new FlatButton(
                  minWidth: 300.0,
                  height: 60.0,
                  onPressed: () => showDialog(context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:  Text("สมัครสมาชิก"),
                        content:Container(
                          height: MediaQuery.of(context).size.height *0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(onPressed: () {
                                Navigator.pushNamed(context, '/Regmanager-page',arguments: null);
                              }, child: Text(
                                "ผู้จัดการ",
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 97, 26, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          width: 3.0,
                                          color: Color.fromRGBO(247, 207, 205, 1)))),
                              FlatButton(onPressed: () {
                                Navigator.pushNamed(context, '/Register-page',arguments: null);
                              }, child: Text(
                                "ผู้เช่า",
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 97, 26, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          width: 3.0,
                                          color: Color.fromRGBO(247, 207, 205, 1))))
                            ],),),
                        actions: [
                          TextButton(onPressed:  () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel', style: TextStyle(
                                color: Color.fromRGBO(2, 97, 26, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),))
                        ],
                      ))


                  ,
                  child: Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                      color: Color.fromRGBO(2, 97, 26, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  shape: StadiumBorder(
                      side: BorderSide(
                          width: 3.0,
                          color: Color.fromRGBO(247, 207, 205, 1))),
                ),
                padding: const EdgeInsets.all(5.0),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}

//// หน้า pro file
///////////////////////// Image profile ////////////////////////////////////////
// Center(
// child: Container(
// child: ListView(
// children: <Widget>[
// SizedBox(
// height: 70.0,
// ),
// Padding(
// padding: const EdgeInsets.all(5.0),
// child: Center(
// child: Column(
// children: <Widget>[
//
// CircleAvatar(
// radius: 80.0,
// backgroundColor: Color.fromRGBO(247, 207, 205, 1),
// //backgroundImage: ,
// // backgroundImage: image,
// child:IconButton(
// padding: EdgeInsets.all(110),
// icon: const Icon(Icons.camera_alt),
// color: Colors.white,
// onPressed: () async {
//
// image = await ImagePicker().pickImage(
// source: ImageSource.gallery);
// // setState(() {
// // });
// },
// ),
// ),
// // (image != null) ? Image.file(image) : Container(
// //   child: Image.asset("img/logo.png",
// //     fit: BoxFit.fill),
// //
// // )
// ],
// ),
// ),
// ),
// ////////////////////////////////////////////////////////////////////////////////
// //////////////////////////ชื่อ-สกุล , Username/////////////////////////////////////
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(3.0),
// child: Text(
// "ชื่อ-สกุล",
// style: TextStyle(
// color: Color.fromRGBO(250, 120, 186, 1),
// fontSize: 20,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(3.0),
// child: Text(
// "Username",
// style: TextStyle(
// color: Color.fromRGBO(250, 120, 186, 1),
// fontSize: 20,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
// )
// ],
// ),
// ////////////////////////////////////////////////////////////////////////////////
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child :
// new FlatButton (
// minWidth: 100.0,
// height: 40.0,
//
// onPressed: () {
//
// },
// child: Text("แก้ไขข้อมูลส่วนตัว",
// style: TextStyle(
// color: Color.fromRGBO(247, 207, 205, 1),
// fontSize: 14  ,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),),
// shape: StadiumBorder(
// side: BorderSide(width: 1.0,color: Color.fromRGBO(247, 207, 205, 1))
// ),
// ),
// ),
// ////////////////////////////////////////////////////////////////////////////////
//
// SizedBox(
// height: 40.0,
// ),
// Padding(
//
// padding: const EdgeInsets.all(10.0),
// child :
// new FlatButton (
// minWidth: 300.0,
// height: 120.0,
//
// onPressed: () {
// },
// child:
// Text("ข้อมูลการเช่าบ้าน",
// style: TextStyle(
// color: Color.fromRGBO(250, 120, 186, 1),
// fontSize: 20  ,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
//
//
// shape: StadiumBorder(
// side: BorderSide(width: 2.0,color: Color.fromRGBO(250, 120, 186, 1))
// ),
// ),
// ) ,
// ////////////////////////////////////////////////////////////////////////////////
//
// Padding(
// padding: const EdgeInsets.all(10.0),
// child :
// new FlatButton (
// minWidth: 300.0,
// height: 120.0,
//
// onPressed: () {
//
// },
// child:
// Text("ข้อมูลผู้เช่า",
// style: TextStyle(
// color: Color.fromRGBO(250, 120, 186, 1),
// fontSize: 20  ,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
//
//
// shape: StadiumBorder(
// side: BorderSide(width: 2.0,color: Color.fromRGBO(250, 120, 186, 1))
// ),
// ),
// ),
// ////////////////////////////////////////////////////////////////////////////////
//
// Padding(
// padding: const EdgeInsets.all(10.0),
// child :
// new FlatButton (
// minWidth: 300.0,
// height: 120.0,
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => page22()),
// );
// },
// child:
// Text("ข้อมูลรายได้",
// style: TextStyle(
// color: Color.fromRGBO(250, 120, 186, 1),
// fontSize: 20  ,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
//
//
// shape: StadiumBorder(
// side: BorderSide(width: 2.0,color: Color.fromRGBO(250, 120, 186, 1))
// ),
// ),
// ),
// ////////////////////////////////////////////////////////////////////////////////
//
// Padding(
// padding: const EdgeInsets.all(60.0),
// child :
// new FlatButton (
// //minWidth: 200.0,
// height: 70.0,
// color: Colors.red,
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => home()),
// );
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text("ออกจากระบบ  ",
// style: TextStyle(
// color: Colors.white,
// fontSize: 16  ,
// fontWeight: FontWeight.bold,
// fontFamily: 'Kanit',
// ),
// ),
// Icon(
// Icons.exit_to_app,
// color: Colors.white,
// size: 22,
// ),
// ],
// ),
// shape: StadiumBorder(
// side: BorderSide(width: 1.0,color: Colors.red)
// ),
// ),
// ) ,]);