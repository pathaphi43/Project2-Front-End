import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:homealone/model/Edit/editmanagermodel.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/register/regmanagermodel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/home.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:homealone/model/register/provincesmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

var encoded = utf8.encode('Lorem ipsum dolor sit amet, consetetur...');
var decoded = utf8.decode(encoded);

class EditManager extends StatefulWidget {
  const EditManager({Key key}) : super(key: key);

  @override
  _EditManagerState createState() => _EditManagerState();
}

Manager managerdata;
List<Tenant> tenantdata;
List<int> args;
SharedPreferences prefs;
int id, status;

class _EditManagerState extends State<EditManager> {
  var manager_Username = TextEditingController();
  var manager_Password = TextEditingController();
  var manager_Firstname = TextEditingController();
  var manager_Lastname = TextEditingController();
  var manager_Phone = TextEditingController();
  var manager_Office = TextEditingController();
  var manager_LineID = TextEditingController();
  var manager_Facebook = TextEditingController();

  // @override
  // void didChangeDependencies() async{
  //   super.didChangeDependencies();
  //   print("didChangeDependencies");
  //   args = ModalRoute.of(context).settings.arguments;
  //   print(args == null);
  //   prefs.
  //   if (args != null) {
  //     if (args[1] == 0 && args[1] != null) {
  //      await getManager(args);
  //     } else if (args[1] == 1 && args[1] != null) {
  //       print("Tennant");
  //     await  getTenant(args);
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    managerdata = null;
    asyncFunc();
    print("initState");
    // EasyLoading.removeCallbacks();
  }

  asyncFunc() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('id') != null && prefs.getInt('status') != null) {
      id = prefs.getInt('id');
      status = prefs.getInt('status');
      if (status == 0) {
        await getManager(id);
      } else if (status == 1) {
        await getTenant(id);
      }
    } else {
      setState(() {
        managerdata = null;
        tenantdata = null;
        id = null;
        status = null;
      });
    }
  }

  Future<Tenant> getTenant(int id) async {
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com', '/tenant/id/' + id.toString()));
    setState(() {
      print(response.statusCode);
      if (response.statusCode == 200) {
        tenantdata = tenantFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  Future<Manager> getManager(int id) async {
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com', '/manager/id/' + id.toString()));
    setState(() {
      // print(response.statusCode);
      if (response.statusCode == 200) {
        managerdata = managerFromJson(response.body);
        // managerdata = null;
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (managerdata != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
          //centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80.0),
                new Text(
                  'Manager',
                  style: TextStyle(
                    color: Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 80.0),
////////// ชื่อ-สกุล
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 30.0, height: 40.0),
                          new Container(
                            alignment: Alignment.center,
                            //decoration: kBoxDecorationStyle ,
                            height: 70.0,
                            width: 160.0,
                            child: TextField(
                              controller: manager_Firstname,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              decoration: InputDecoration(
                                  hintText: managerdata.managerFirstname,
                                  border: OutlineInputBorder(),
                                  hintStyle: new TextStyle(
                                      color: const Color.fromRGBO(
                                          250, 120, 186, 1)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromRGBO(
                                              250, 120, 186, 1)))),
                            ),
                          ),
                          new Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            //decoration: kBoxDecorationStyle ,
                            height: 70.0,
                            width: 160.0,
                            child: TextField(
                              //controller: manager_Lastname,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              decoration: InputDecoration(
                                  hintText: managerdata.managerLastname,
                                  border: OutlineInputBorder(),
                                  hintStyle: new TextStyle(
                                      color: const Color.fromRGBO(
                                          250, 120, 186, 1)),
                                  // hintText: 'Enter valid mail id as abc@gmail.com'
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromRGBO(
                                              250, 120, 186, 1)))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

////////// ที่อยู่สำนักงาน
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        //decoration: kBoxDecorationStyle ,
                        height: 70.0,
                        width: 300.0,
                        child: TextField(
                          controller: manager_Office,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                          decoration: InputDecoration(
                              hintText: managerdata.managerOffice,
                              border: OutlineInputBorder(),
                              hintStyle: new TextStyle(
                                  color:
                                      const Color.fromRGBO(250, 120, 186, 1)),
                              // hintText: 'Enter valid mail id as abc@gmail.com'
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromRGBO(250, 120, 186, 1)))),
                        ),
                      ),
                    ],
                  ),
                ),

////////// เบอร์โทร
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        //decoration: kBoxDecorationStyle ,
                        height: 70.0,
                        width: 300.0,
                        child: TextField(
                          controller: manager_Phone,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                          decoration: InputDecoration(
                              hintText: managerdata.managerPhone,
                              border: OutlineInputBorder(),
                              hintStyle: new TextStyle(
                                  color:
                                      const Color.fromRGBO(250, 120, 186, 1)),
                              // hintText: 'Enter valid mail id as abc@gmail.com'
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromRGBO(250, 120, 186, 1)))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),

////////// Line ID
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        //decoration: kBoxDecorationStyle ,
                        height: 70.0,
                        width: 300.0,
                        child: TextField(
                          controller: manager_LineID,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                          decoration: InputDecoration(
                              hintText: managerdata.managerLineid,
                              border: OutlineInputBorder(),
                              hintStyle: new TextStyle(
                                  color:
                                      const Color.fromRGBO(250, 120, 186, 1)),
                              // hintText: 'Enter valid mail id as abc@gmail.com'
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromRGBO(250, 120, 186, 1)))),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                ),
////////// Facebook
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        //decoration: kBoxDecorationStyle ,
                        height: 70.0,
                        width: 300.0,
                        child: TextField(
                          controller: manager_Facebook,
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                          decoration: InputDecoration(
                              hintText: managerdata.managerFacebook,
                              border: OutlineInputBorder(),
                              hintStyle: new TextStyle(
                                  color:
                                      const Color.fromRGBO(250, 120, 186, 1)),
                              // hintText: 'Enter valid mail id as abc@gmail.com'
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromRGBO(250, 120, 186, 1)))),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60.0),
                      Container(
                        height: 40.0,
                        width: 200.0,
                        child: new RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(250, 120, 186, 1))),
                          onPressed: () async {
                            print(manager_Firstname.text.isEmpty);

                            var regdata = Editmanager();
                            regdata.managerFirstname =
                                manager_Firstname.text.isEmpty
                                    ? managerdata.managerFirstname
                                    : manager_Firstname.text;
                            regdata.managerLastname =
                                manager_Lastname.text.isEmpty
                                    ? managerdata.managerLastname
                                    : manager_Lastname.text;
                            // regdata.managerUsername = manager_Username.text;
                            // regdata.managerPassword = manager_Password.text;
                            regdata.managerOffice = manager_Office.text.isEmpty
                                ? managerdata.managerOffice
                                : manager_Office.text;
                            regdata.managerPhone = manager_Phone.text.isEmpty
                                ? managerdata.managerPhone
                                : manager_Phone.text;
                            regdata.managerLineid = manager_LineID.text.isEmpty
                                ? managerdata.managerLineid
                                : manager_LineID.text;
                            regdata.managerFacebook =
                                manager_Facebook.text.isEmpty
                                    ? managerdata.managerFacebook
                                    : manager_Facebook;
                            regdata.managerImage = managerdata.managerImage;
                            regdata.managerStatus = args[1];
                            regdata.mid = args[0];
                            var jsonregdata = editmanagerToJson(regdata);
                            print(jsonregdata);
                            var response = await http.post(
                                Uri.parse(
                                    'http://homealone.comsciproject.com/manager/editmanager'),
                                body: jsonregdata,
                                headers: {
                                  'Content-Type': 'application/json',
                                });
                            print(response.statusCode.toString());
                            if (response.statusCode.toString() == "200") {
                              Navigator.pop(context);
                            } else {
                              print("Edit Error");
                            }
                          },
                          padding: EdgeInsets.all(10.0),
                          color: Color.fromRGBO(250, 120, 186, 1),
                          textColor: Colors.white,
                          child: Text("Confirm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              )),
                        ),
                      ),
                      SizedBox(height: 100.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else
      return  new Container(
          decoration: new BoxDecoration(
              color: Colors.blue[200]
          ),
          child:  bodyProgress
      );
  }
  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
         new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "กำลังโหลด....",
                      style: new TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}
