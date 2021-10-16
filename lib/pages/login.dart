
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homealone/model/loginmodel.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;

  }

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
                      fontFamily: 'Righteous-Regular',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Container(),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: const Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),
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
                              color: Color.fromRGBO(250, 120, 186, 1)
                          )
                      )
                  ),
                  // prefixIcon: Icon(Icons.account_circle)),

                  controller: _username,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  obscureText: true,
                  style: TextStyle(
                    color: const Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),
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
                  onSubmitted: (value) async {

                    var reqlogin = Login();
                    // reqlogin.isUsers = "manager";
                    reqlogin.username = _username.text;
                    reqlogin.password = _password.text;
                    var Jsonreq = loginToJson(reqlogin);

                    if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
                      print('JsonNotnull');
                      // https://homealone-springcloud.azuremicroservices.io/user/signin
                      // http://homealone.comsciproject.com/user/login
                      var response = await http.post(Uri.parse
                        ('https://homealone-springcloud.azuremicroservices.io/user/signin'),
                          body: Jsonreq,
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                            // 'Accept': 'application/json',
                            // 'Authorization': 'Bearer'+token,
                          });
                      print("Response");
                      print(response.statusCode);
                      if (response.statusCode.toString() == '200') {

                        Map<String, dynamic> decodedToken =
                        JwtDecoder.decode(response.body.toString());

                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        await prefs.setInt('id', decodedToken['id']);
                        await prefs.setInt(
                            'status', decodedToken['status']);
                        print(prefs.getInt('id'));

                        Navigator.pushNamedAndRemoveUntil(context,
                            '/main-page', (Route<dynamic> route) => false,
                            arguments: [
                              decodedToken['id'].toString(),
                              decodedToken['status'].toString()
                            ]);

                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
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
                          reqlogin.isUsers = "manager";
                          reqlogin.username = _username.text;
                          reqlogin.password = _password.text;
                          var Jsonreq = loginToJson(reqlogin);

                          if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
                            print('JsonNotnull');

                            var response = await http.post(
                                    'http://homealone.comsciproject.com/user/login',
                                body: Jsonreq,
                                headers: {
                                  'Content-Type': 'application/json',
                                  // 'Accept': 'application/json',
                                  // 'Authorization': 'Bearer'+token,
                                });
                              print("Response");
                              print(response.statusCode);
                            if (response.statusCode.toString() == '200') {

                              Map<String, dynamic> decodedToken =
                                  JwtDecoder.decode(response.body.toString());

                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setInt('id', decodedToken['id']);
                              await prefs.setInt(
                                  'status', decodedToken['status']);
                              print(prefs.getInt('id'));

                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/main-page', (Route<dynamic> route) => false,
                                  arguments: [
                                    decodedToken['id'].toString(),
                                    decodedToken['status'].toString()
                                  ]);

                            }  else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: const Text(''),
                                duration: const Duration(seconds: 1),
                                action: SnackBarAction(
                                  label: 'ชื่อผู้ใช้หรือรหัสผ่านผิด',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    print('Ok');
                                  },
                                ),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: const Text(''),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'ชื่อผู้ใช้หรือรหัสผ่านผิด',
                                textColor: Colors.white,
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
                                color: Colors.white)),
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
                              ),
                            )
                        )
                    ),
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
