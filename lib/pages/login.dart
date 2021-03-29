import 'dart:io';
import 'dart:convert' as convert;
import 'package:homealone/model/loginmodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class _LoginPageState extends State<LoginPage> {
  String message = ' ';

  var _username = TextEditingController();
  var _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber[50],
      //   //   title: Text('Home Alone'),
      // ),
      body: Container(
        color: Colors.amber[50],
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/main-page',
                        );
                      },
                      child: Text('Skip'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Image.asset(
                  'images/homelogo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle)),
                  controller: _username,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline_sharp)),
                  controller: _password,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //------------------------ปุ่มLogin----------------------//
                    TextButton(
                        onPressed: () async {
                          var reqlogin = Login();
                          reqlogin.username = _username.text;
                          reqlogin.password = _password.text;
                          var Jsonreq = await loginToJson(reqlogin);
                          print(Jsonreq);
                          Navigator.pushNamed(context, '/main-page',
                              arguments: [1]);
                          // Navigator.pushNamed(context, '/home-page',
                          //     arguments: [id, name]);

                          //                         Future<bool> setToken(String value) async {
                          //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                          //   return prefs.setString('token', value);
                          // }

                          // Future<String> getToken() async {
                          //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                          //   return prefs.getString('token');
                          // }

                          // print(decodeToken);
                          // print('JsonUser ' + Jsonreq[1]);
                          // print('JsonPass ' + Jsonreq[2]);

                          // if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
                          //   print('JsonNotnull');
                          //   var response = await http.post(
                          //       'http://homealone.comsciproject.com/user/login',
                          //       body: Jsonreq,
                          //       headers: {
                          //         'Content-Type': 'application/json',
                          //         'Accept': 'application/json',
                          //         'Authorization': 'Bearer'+token,
                          //       });
                          //   print(response.body);

                          //   print(response.statusCode);
                          //   if (response.statusCode.toString() == '200') {
                          //     Map<String, dynamic> decodedToken =
                          //         JwtDecoder.decode(response.body.toString());
                          //     print(decodedToken['id']);
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //             content: Text('Login สำเร็จ')));
                          //     setState(() {});
                          //     Navigator.pushNamed(context, '/main-page',
                          //         arguments: [decodedToken['id'].toString()]);
                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //             content: Text(
                          //                 'Username หรือ Password ไม่ถูกต้อง')));
                          //     // setState(() {});
                          //   }
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //           content: Text(
                          //               'กรุณากรอก Username หรือ Password')));
                          // }
                        },
                        child: Text('Login'.toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black45),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amber[100]),
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(200, 45)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(color: Colors.red)),
                            ))),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: null,
                    child: Text('Forgot Password?'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (message != null) ? Text(message) : Container()
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
