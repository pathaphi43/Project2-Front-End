import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerEditProfile extends StatefulWidget {
  const ManagerEditProfile({Key key}) : super(key: key);

  @override
  State<ManagerEditProfile> createState() => _ManagerEditProfileState();
}

class _ManagerEditProfileState extends State<ManagerEditProfile> {
  SharedPreferences  prefs;
  File args;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    args =  ModalRoute.of(context).settings.arguments;
    prefs = await SharedPreferences.getInstance();
    print("Editprofile:" + args.toString());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: NavAppBar(),
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
                          backgroundImage:FileImage(args),
                          // backgroundImage: AssetImage("img/logo.png"),
                          radius: 250.0,
                          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
                          //backgroundImage: ,

                        ),
                        // (image != null) ? Image.file(image) : Container()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    minWidth: 100.0,
                    height: 40.0,
                    onPressed: () async{
                      String fileName = args.path.split('/').last;
                      print(fileName);
                      var postUri = Uri.parse("https://home-alone-csproject.herokuapp.com/user/upload/profile");
                      var request = http.MultipartRequest('POST', postUri)
                        ..fields['username'] = prefs.getString('username')
                        ..files.add( await http.MultipartFile.fromBytes('file', await File.fromUri(args.uri).readAsBytes(),filename: fileName,
                            contentType: MediaType('ContentType','application/json')));
                      var streamedResponse = await request.send();
                      var response = await http.Response.fromStream(streamedResponse);
                      // request.send().then((response) {
                        if (response.statusCode == 200){
                          print(response.body);
                          imageProfile = response.body;
                          MainPages home = new MainPages();
                         home.createState().asyncFunc();
                        ProfilePage().createState().asyncFunc();
                          print ("Uploaded!");
                          Navigator.pop(context, ModalRoute.withName('/Profile-page'));
                        }else print("Upload fail"+ response.statusCode.toString());

                    },
                    child: Text(
                      "ยืนยัน",
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

                  ],
                )
            ),
          ),
        );
  }
}

