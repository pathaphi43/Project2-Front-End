import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' show utf8;
import 'dart:ui';

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
  @override
  Widget build(BuildContext context) {
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
                    "ชื่อ-สกุล",
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
                    "Username",
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
                        color: Color.fromRGBO(247, 207, 205, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                    ),
                    shape: StadiumBorder(
                        side: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(247, 207, 205, 1))),
                  ),
                ),
////////////////////////////////////////////////////////////////////////////////
///////////////////////
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: new FlatButton(
                    minWidth: 400.0,
                    height: 60.0,
                    color: Color.fromRGBO(247, 207, 205, 1),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => page5()),
                      // );
                    },
                    child: Text(
                      "ลงทะเบียนเป็นเจ้าของบ้านเช่า",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                    ),
                    shape: StadiumBorder(
                        side: BorderSide(
                      width: 1.0,
                      color: Color.fromRGBO(250, 120, 186, 1),
                    )),
                  ),
                ),
////////////////////////////////////////////////////////////////////////////////

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new FlatButton(
                    minWidth: 300.0,
                    height: 120.0,
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
                  padding: const EdgeInsets.all(10.0),
                  child: new FlatButton(
                    minWidth: 300.0,
                    height: 120.0,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => page15()),
                      // );
                    },
                    child: Text(
                      "เขียนรีวิว",
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
                  padding: const EdgeInsets.all(60.0),
                  child: new FlatButton(
                    //minWidth: 200.0,
                    height: 70.0,
                    color: Colors.red,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => home()),
                      // );
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
}
