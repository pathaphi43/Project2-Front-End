import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/Rent/RentModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  AppStyle _appStyle = new AppStyle();
  DateTime dateTimeIn = DateTime.now();
  DateTime dateTimeOut = DateTime.now().add(Duration(days: 5));

  String filepath = '';
  File file;
  List<int> args;
  RentModel _rentModel;
  var rid = TextEditingController();
  var hid = TextEditingController();
  var tid = TextEditingController();
  var rentingBook = TextEditingController();
  var rentingCheckIn = TextEditingController();
  var rentingCheckOut = TextEditingController();
  var rentingImage = TextEditingController();
  var rentingStatus = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments;
    // gethomeAll(args);
    // print(args[0]);
  }

  Future<RentModel> gethomeAll(List<int> args) async {
    print(args[0]);
    var model = RentModel();
    model.hid = args[0];
    model.rentingStatus = 1;
    var jsonModel = rentModelToJson(model);

    var response = await http.post(
        Uri.parse('https://home-alone-csproject.herokuapp.com/rent/houseAt'),
        body: jsonModel,
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return _rentModel = rentModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  bool checkAmounts = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gethomeAll(args),
      builder: (BuildContext context, AsyncSnapshot<RentModel> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: NavAppBar(),
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
                              readOnly: true,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  labelText: snapshot.data.tenantFirstname +
                                      "\t" +
                                      snapshot.data.tenantLastname,
                                  prefixIcon: Icon(Icons.account_circle)),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextField(
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                              // enabled: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  labelText: snapshot.data.houseName,
                                  prefixIcon: Icon(Icons.house)),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                        'ต้องการเพิ่มรายการชำระเงินเองหรือไม่ ?'),
                                    Checkbox(
                                      value: checkAmounts,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          checkAmounts = newValue;
                                          print(checkAmounts);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextField(
                              enabled: checkAmounts,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                labelText: snapshot.data.houseRent.isNaN
                                    ? 'ค่าเช่า'
                                    : 'ค่าเช่า ' +
                                        snapshot.data.houseRent.toString(),
                                // prefixIcon: Icon(Icons.confirmation_num_outlined)
                              ),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextField(
                              enabled: checkAmounts,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                labelText: snapshot.data.houseDeposit.isNaN
                                    ? 'ค่าไฟฟ้า'
                                    : 'ค่าไฟฟ้า ' +
                                        snapshot.data.houseElectric.toString(),
                                // prefixIcon: Icon(Icons.money_rounded)
                              ),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextField(
                              enabled: checkAmounts,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                labelText: snapshot.data.houseInsurance.isNaN
                                    ? 'ค่าน้ำ'
                                    : 'ค่าน้ำ ' +
                                        snapshot.data.houseWater.toString(),
                                // prefixIcon:
                                // Icon(Icons.money_off_csred_outlined)
                              ),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                              child: FlatButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                      setState(() {
                                        dateTimeIn = date;
                                        print('ยืนยัน $date');
                                      });
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.th);
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.date_range_outlined),
                                    title: Text(
                                      'วันที่เรียกเก็บ \n ${dateTimeIn.day} - ${dateTimeIn.month} - ${dateTimeIn.year}',
                                      textAlign: TextAlign.center,
                                      style: _appStyle.textStyleUrSize(18),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_down),
                                  ))),
                          ////วันที่ออก
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                              child: FlatButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        // onChanged: (date) {
                                        //   print('change $date');
                                        // }
                                        onConfirm: (date) {
                                      dateTimeOut = date;
                                      print('ยืนยัน $dateTimeOut');

                                      setState(() {});
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.th);
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.date_range_outlined),
                                    title: Text(
                                      'วันที่เริ่มปรับ \n ${dateTimeOut.day} - ${dateTimeOut.month} - ${dateTimeOut.year}',
                                      textAlign: TextAlign.center,
                                      style: _appStyle.textStyleUrSize(18),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_down),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                              child: FlatButton(
                                onPressed: () async {
                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'pdf',
                                    ],
                                  );

                                  if (result != null) {
                                    // file = result.files.p;
                                    // print(file.name);
                                    file = File(result.files.first.path);
                                    filepath = file.path.split("/").last;
                                    setState(() {});
                                  } else {
                                    print('cancel');
                                    // User canceled the picker
                                  }
                                },
                                child: ListTile(
                                  leading: Icon(Icons.upload_file),
                                  title: Text(
                                    'ใบเสร็จ - $filepath',
                                    textAlign: TextAlign.center,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: () {
                                      setState(() {
                                        file = null;
                                        filepath = '';
                                      });
                                    },
                                  ),
                                ),
                              )),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                                onPressed: () async {
                                  print("ยืนยันการเช่า");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(new SnackBar(
                                    duration: new Duration(seconds: 5),
                                    content: new Row(
                                      children: <Widget>[
                                        new CircularProgressIndicator(),
                                        new Text("กำลังโหลด...")
                                      ],
                                    ),
                                  ));
                                },
                                child: Text(
                                    'เพิ่มการชำระค่าใช้จ่าย'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(15)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black45),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size(200, 45)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
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
        } else
          return Scaffold(
            appBar: NavAppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
