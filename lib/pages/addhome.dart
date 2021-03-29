import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:http/http.dart' as http;

class AddHome extends StatefulWidget {
  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  var _name = TextEditingController();
  var _add = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> args = ModalRoute.of(context).settings.arguments;
    print('AddHomeContext' + args.toString());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('เพิ่มข้อมูลผู้เช่า')),
      ),
      body: Center(
        child: Container(
          child: Card(
            color: Colors.grey[200],
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 55, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'ชื่อบ้านเช่า',
                            prefixIcon: Icon(Icons.home_outlined)),
                        controller: _name, //ส่งข้อมูลTextField
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
                            labelText: 'ที่อยู่บ้านเช่า',
                            prefixIcon: Icon(Icons.map_outlined)),
                        controller: _add, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                          onPressed: () async {
                            var reqlogin = House();
                            reqlogin.h_Manager = int.parse(args[0]);
                            reqlogin.houseName = _name.text;
                            reqlogin.houseAdd = _add.text;
                            reqlogin.houseStatus = int.parse(args[1]);
                            var Jsonreq = await houseToJson(reqlogin);
                            print(Jsonreq);
                            // if (Jsonreq[1].isNotEmpty && Jsonreq[2].isNotEmpty) {
                            //   print('JsonNotnull');
                            var response = await http.post(
                                'http://homealone.comsciproject.com/home/api/inserthome',
                                body: Jsonreq,
                                headers: {
                                  'Content-Type': 'application/json',
                                  // 'Accept': 'application/json',
                                  // 'Authorization': 'Bearer'+token,
                                });
                            print(response.body);

                            //   print(response.statusCode);
                            if (response.statusCode.toString() == '200') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('เพิ่มบ้านเช่าสำเร็จ')));
                              setState(() {});
                              Navigator.pushNamed(context, '/manu-page',
                                  arguments: null);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('เพิ่มบ้านเช่าไม่สำเร็จ')));
                              // setState(() {});
                            }
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text(
                            //               'กรุณากรอก Username หรือ Password')));
                            // }
                          },
                          child: Text('เพิ่มบ้านเช่า'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black45),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(200, 45)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.blue)),
                              ))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
