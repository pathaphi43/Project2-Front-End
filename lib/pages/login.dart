
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homealone/model/loginmodel.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String message = ' ';
  String id = '';
  String status = '';
  var _username = TextEditingController();
  var _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
      ),
      body: Container(
        // color: Colors.amber[50],
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromRGBO(250, 120, 186, 1),
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              // Container(),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: new TextStyle(
                        color: const Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromRGBO(250, 120, 186, 1)))),
                  // prefixIcon: Icon(Icons.account_circle)),
                  controller: _username,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  obscureText: true,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                      labelStyle: new TextStyle(
                        color: const Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromRGBO(250, 120, 186, 1)))),
                  // prefixIcon: Icon(Icons.lock_outline_sharp)),
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
                          var message2 = "\tกำลังเข้าสู่ระบบ...";
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: Container(
                                        // color: Colors.black,
                                        height: 200,
                                        width: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SpinKitRing(color: Colors.amber),
                                            Text(message2)
                                          ],
                                        )),
                                  ));

                          var reqlogin = Login();
                          reqlogin.isUsers = "manager";
                          reqlogin.username = _username.text;
                          reqlogin.password = _password.text;
                          var Jsonreq = loginToJson(reqlogin);

                          if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
                            print('JsonNotnull');

                            var response = await http.post(
                                Uri.parse(
                                    'http://homealone.comsciproject.com/user/login'),
                                body: Jsonreq,
                                headers: {
                                  'Content-Type': 'application/json',
                                  // 'Accept': 'application/json',
                                  // 'Authorization': 'Bearer'+token,
                                });

                            if (response.statusCode.toString() == '200') {
                              Map<String, dynamic> decodedToken =
                                  JwtDecoder.decode(response.body.toString());
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/main-page', (Route<dynamic> route) => false,
                                  arguments: [
                                    decodedToken['id'].toString(),
                                    decodedToken['status'].toString()
                                  ]);
                              print("Login Ok");

                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // await prefs.setInt('id', decodedToken['id']);
                              // await prefs.setInt(
                              //     'status', decodedToken['status']);

                              // prefs.clear();
                              // prefs.commit();
                            } else {
                              message2 = null;
                              setState(() {
                                message2 = "\tชื่อผู้ใช้หรือรหัสผ่านผิด!!!";
                              });

                              // await showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         AlertDialog(
                              //           content: Container(
                              //               height: 200,
                              //               width: 50,
                              //               child: Text(
                              //                   'ชื่อผู้ใช้หรือรหัสผ่านผิด')),
                              //         ));
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   content: const Text(''),
                              //   duration: const Duration(seconds: 1),
                              //   action: SnackBarAction(
                              //     label: 'ชื่อผู้ใช้หรือรหัสผ่านผิด',
                              //     onPressed: () {
                              //       print('Ok');
                              //     },
                              //   ),
                              // ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(''),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'ชื่อผู้ใช้หรือรหัสผ่านผิด',
                                onPressed: () {
                                  print('Ok');
                                },
                              ),
                            ));
                          }
                        },
                        child: Text('Sing in'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                color: Colors.amber)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(250, 120, 186, 1)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(250, 120, 186, 1)),
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


 //                         Future<bool> setToken(String value) async {
                          //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                          //   return prefs.setString('token', value);
                          // }

                          // Future<String> getToken() async {
                          //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                          //   return prefs.getString('token');
                          // }
