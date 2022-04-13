
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
  SharedPreferences prefs;
 Future<ScaffoldState> _signin(String Jsonreq)async {
     if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
       print(Jsonreq[0]);
       // https://homealone-springcloud.azuremicroservices.io/user/signin
       // http://homealone.comsciproject.com/user/login
       var response = await http.post(Uri.parse
         ('https://home-alone-csproject.herokuapp.com/user/signin'),
           body: Jsonreq,
           headers: {
             'Content-Type': 'application/json'
             // 'Accept': 'application/json',
             // 'Authorization': 'Bearer'+token,
           });
       print("Response");
       print(response.statusCode);
       if (response.statusCode.toString() == '200') {

         Map<String, dynamic> decodedToken = JwtDecoder.decode(response.body.toString());

          prefs =
             await SharedPreferences.getInstance();
         await prefs.setInt('id', decodedToken['id']);
         await prefs.setInt(
             'status', decodedToken['status']);
         print(prefs.getInt('id'));


         // Navigator.pushNamedAndRemoveUntil(context,
         //     '/main-page', (Route<dynamic> route) => false,
         //     arguments: [
         //       decodedToken['id'].toString(),
         //       decodedToken['status'].toString()
         //     ]);

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
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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

                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(duration: new Duration(seconds: 4), content:
                        new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            new Text("  Signing-In...")
                          ],
                        ),
                        ));

                    _signin(Jsonreq).whenComplete(() =>
                        Navigator.pushNamedAndRemoveUntil(context,
                            '/main-page', (Route<dynamic> route) => false,
                            arguments: [
                              prefs.getInt('id'),
                              prefs.getInt('status')]));

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

                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(duration: new Duration(seconds: 4), content:
                              new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Signing-In...")
                                ],
                              ),
                              ));

                          _signin(Jsonreq).whenComplete(() =>
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/main-page', (Route<dynamic> route) => false,
                                  arguments: [
                                    prefs.getInt('id'),
                                    prefs.getInt('status')]));

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
