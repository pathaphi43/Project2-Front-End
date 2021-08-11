import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class PreLogin extends StatefulWidget {
  // const PreLogin({ Key? key }) : super(key: key);

  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
      ),
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
}
