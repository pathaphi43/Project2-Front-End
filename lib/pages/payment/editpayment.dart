import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/Rent/RentModel.dart';
import 'package:homealone/model/payment/TransactionMedel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';


class EditPayment extends StatefulWidget {
  const EditPayment({Key key}) : super(key: key);

  @override
  State<EditPayment> createState() => _EditPaymentState();
}

class _EditPaymentState extends State<EditPayment> {
  AppStyle _appStyle = new AppStyle();
  DateTime dateTimeIn = DateTime.now();
  DateTime dateTimeOut = DateTime.now().add(Duration(days: 5));

  String filepath = '';
  File file;
  List<int> args;
  RentModel _rentModel;
  var rid = TextEditingController();
  var installment = TextEditingController();
  var payHouseAmount = TextEditingController();
  var payHouseDate = TextEditingController();
  var payHouseEnd = TextEditingController();
  var payHouseImg = TextEditingController();
  var payHouseStatus = TextEditingController();
  var payElecInmonth = TextEditingController();
  var payElecAmount = TextEditingController();
  var payElecDate = TextEditingController();
  var payElecEnd = TextEditingController();
  var payElecImg = TextEditingController();
  var payElecStatus = TextEditingController();
  var payWaterInmonth = TextEditingController();
  var payWaterAmount = TextEditingController();
  var payWaterDate = TextEditingController();
  var payWaterEnd = TextEditingController();
  var payWaterImg = TextEditingController();
  var payWaterStatus = TextEditingController();

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
  bool checkUtilities = false;
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
                            padding: _appStyle.edgeInsets1(),
                            child: TextField(
                              readOnly: true,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0, style: BorderStyle.solid)
                                  ),
                                  labelText: snapshot.data.tenantFirstname +
                                      "\t" +
                                      snapshot.data.tenantLastname,
                                  labelStyle: _appStyle.textStyleUrSize(16),
                                  prefixIcon: Icon(Icons.account_circle)),
                              controller: null, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                            padding: _appStyle.edgeInsets1(),
                            child: TextField(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              textAlign: TextAlign.start,
                              // enabled: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(5.0)),
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
                                    Checkbox(
                                      value: checkAmounts,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          checkAmounts = newValue;
                                          print(checkAmounts);
                                        });
                                      },
                                    ),
                                    Text(
                                        'ต้องการเพิ่มค่าเช่าเองหรือไม่ ?'),

                                  ],
                                ),
                              )),
                          Padding(
                            padding: _appStyle.edgeInsets1(),
                            child: TextField(
                              enabled: checkAmounts,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                labelText: snapshot.data.houseRent.isNaN
                                    ? 'ค่าเช่า'
                                    : 'ค่าเช่า ' +
                                    snapshot.data.houseRent.toString(),
                                // prefixIcon: Icon(Icons.confirmation_num_outlined)
                              ),
                              controller: payHouseAmount, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: checkUtilities,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          checkUtilities = newValue;
                                          print(checkUtilities);
                                        });
                                      },
                                    ),
                                    Text(
                                        'ต้องการเพิ่มค่าไฟและค่าน้ำเองหรือไม่ ?'),

                                  ],
                                ),
                              )),
                          Padding(
                            padding: _appStyle.edgeInsets1(),
                            child: TextField(
                              enabled: checkUtilities,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                labelText: snapshot.data.houseDeposit.isNaN
                                    ? 'ค่าไฟฟ้า'
                                    : 'ค่าไฟฟ้า ' +
                                    snapshot.data.houseElectric.toString(),
                                // prefixIcon: Icon(Icons.money_rounded)
                              ),
                              controller: payElecAmount, //ส่งข้อมูลTextField
                            ),
                          ),
                          Padding(
                            padding: _appStyle.edgeInsets1(),
                            child: TextField(
                              enabled: checkUtilities,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                labelText: snapshot.data.houseInsurance.isNaN
                                    ? 'ค่าน้ำ'
                                    : 'ค่าน้ำ ' +
                                    snapshot.data.houseWater.toString(),
                                // prefixIcon:
                                // Icon(Icons.money_off_csred_outlined)
                              ),
                              controller: payWaterAmount, //ส่งข้อมูลTextField
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
                                      'วันที่เรียกเก็บ \n ${dateTimeIn
                                          .day} - ${dateTimeIn
                                          .month} - ${dateTimeIn.year}',
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
                                      'วันที่เริ่มปรับ \n ${dateTimeOut
                                          .day} - ${dateTimeOut
                                          .month} - ${dateTimeOut.year}',
                                      textAlign: TextAlign.center,
                                      style: _appStyle.textStyleUrSize(18),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_down),
                                  ))),
                          // Padding(
                          //     padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                          //     child: FlatButton(
                          //       onPressed: () async {
                          //         FilePickerResult result =
                          //             await FilePicker.platform.pickFiles(
                          //           type: FileType.custom,
                          //           allowedExtensions: [
                          //             'jpg',
                          //             'pdf',
                          //           ],
                          //         );
                          //
                          //         if (result != null) {
                          //           // file = result.files.p;
                          //           // print(file.name);
                          //           file = File(result.files.first.path);
                          //           filepath = file.path.split("/").last;
                          //           setState(() {});
                          //         } else {
                          //           print('cancel');
                          //           // User canceled the picker
                          //         }
                          //       },
                          //       child: ListTile(
                          //         leading: Icon(Icons.upload_file),
                          //         title: Text(
                          //           'ใบเสร็จ - $filepath',
                          //           textAlign: TextAlign.center,
                          //         ),
                          //         trailing: IconButton(
                          //           icon: Icon(Icons.cancel_outlined),
                          //           onPressed: () {
                          //             setState(() {
                          //               file = null;
                          //               filepath = '';
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     )),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                                onPressed: () async {
                                  print("ยืนยันการเช่า");
                                  TransactionModel model = new TransactionModel();
                                  model.rid = _rentModel.rid;

                                  model.installment = dateTimeIn;
                                  model.payHouseEnd = dateTimeOut;
                                  if (checkAmounts)
                                    model.payHouseAmount =
                                    payHouseAmount.text.isEmpty ? _rentModel
                                        .houseRent : int.parse(
                                        payHouseAmount.text);
                                  else
                                    model.payHouseAmount = _rentModel.houseRent;

                                  if (checkUtilities) {
                                    model.payWaterAmount =
                                    payWaterAmount.text.isEmpty
                                        ? 'ตามหน่วยบ้าน'
                                        : payWaterAmount.text;
                                    model.payElecAmount =
                                    payElecAmount.text.isEmpty
                                        ? 'ตามหน่วยบ้าน'
                                        : payElecAmount.text;
                                  } else {
                                    model.payWaterAmount = 'ตามหน่วยบ้าน';
                                    model.payElecAmount = 'ตามหน่วยบ้าน';
                                  }
                                  model.payElecInmonth = dateTimeIn;
                                  model.payElecEnd = dateTimeOut;
                                  model.payWaterInmonth = dateTimeIn;
                                  model.payWaterEnd = dateTimeOut;
                                  var jsonBody = transactionImageToJson(model);
                                  print(jsonBody);
                                  showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'ยืนยันการเพิ่มรายการชำระค่าใช้จ่าย'),
                                          titleTextStyle: _appStyle
                                              .textStyleUrSize(20),
                                          content: Column(children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 0),
                                                child: Text(
                                                  "ค่าเช่าบ้าน:${model
                                                      .payHouseAmount}",
                                                  style: _appStyle
                                                      .textStyle18(),
                                                  overflow: TextOverflow
                                                      .visible,
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 0),
                                                child: Text(
                                                  "ค่าน้ำ:${model
                                                      .payWaterAmount}",
                                                  style: _appStyle
                                                      .textStyle18(),
                                                  overflow: TextOverflow
                                                      .visible,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                )),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 0),
                                                child: Text(
                                                  "ค่าไฟฟ้า:${model
                                                      .payElecAmount}",
                                                  style: _appStyle
                                                      .textStyle18(),
                                                  overflow: TextOverflow
                                                      .visible,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                )),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 0),
                                                child: Text(
                                                  "วันที่เรียกเก็บ:${model
                                                      .installment.day}/${model
                                                      .installment
                                                      .month}/${model
                                                      .installment.year}",
                                                  style: _appStyle
                                                      .textStyle18(),
                                                  overflow: TextOverflow
                                                      .visible,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                )),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 20, 20, 0),
                                                child: Text(
                                                  "วันที่เริ่มปรับ:${model
                                                      .payHouseEnd.day}/${model
                                                      .payHouseEnd
                                                      .month}/${model
                                                      .payHouseEnd.year}",
                                                  style: _appStyle
                                                      .textStyle18(),
                                                  overflow: TextOverflow
                                                      .visible,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                )),

                                          ]),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('ยกเลิก'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(new SnackBar(
                                                  duration: new Duration(
                                                      seconds: 4),
                                                  content: new Row(
                                                    children: <Widget>[
                                                      new CircularProgressIndicator(),
                                                      new Text("กำลังโหลด...")
                                                    ],
                                                  ),
                                                ));

                                                var response = await http.post(
                                                    Uri.parse(
                                                        'https://home-alone-csproject.herokuapp.com/payment/save-payment'),
                                                    body: jsonBody,
                                                    headers: {
                                                      'Content-Type': 'application/json'
                                                    });
                                                if (response.statusCode ==
                                                    200) {
                                                  Navigator.popUntil(context,
                                                      ModalRoute.withName(
                                                          '/PreTransaction-page'));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                      new SnackBar(
                                                        duration: new Duration(
                                                            seconds: 4),
                                                        content: new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text(
                                                                "เกิดข้อผิดพลาด")
                                                          ],
                                                        ),
                                                      ));
                                                  print("Upload fail" +
                                                      response.statusCode
                                                          .toString());
                                                }
                                              },
                                              child: const Text('ยืนยัน'),
                                            ),
                                          ],
                                        ),
                                  );

                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(new SnackBar(
                                  //   duration: new Duration(seconds: 5),
                                  //   content: new Row(
                                  //     children: <Widget>[
                                  //       new CircularProgressIndicator(),
                                  //       new Text("กำลังโหลด...")
                                  //     ],
                                  //   ),
                                  // ));


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
