import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/payment/TransactionMedel.dart';
import 'package:homealone/model/payment/TransactionShowModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/payment/rentpay.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class rentTenant extends StatefulWidget {
  rentTenant({key}) : super(key: key);

  @override
  State<rentTenant> createState() => _rentTenantState();
}


class _rentTenantState extends State<rentTenant> {
  File image;
  Payment args;

  @override
  void didChangeDependencies() async {
    args = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buttomPay(),
      appBar: NavAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "ยืนยันการชำระค่าเช่า",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(250, 120, 186, 1)),
              ),
              SizedBox(
                height: 8,
              ),
              rentInfo(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: rentTenantBody(),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 8,
              // ),
              //
              //
              // SizedBox(
              //   height: 8,
              // ),
              datepay(context),
              // SizedBox(
              //   height: 28,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rentInfo() {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mqWidth / 0.8,
      height: 100,
      child: Card(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Text("ค่าเช่าประจำเดือน ${DateFormat('MMMM-yyyy','th').format(args.installment)}"),
            SizedBox(
              height: 8,
            ),
            Text("จำนวนเงิน ${args.payHouseAmount} บาท"),
            SizedBox(
              height: 18,
            ),
            Text(
              "หมดเขตชำระ ${DateFormat('dd-MMMM-yyyy','th').format(args.payHouseEnd)}",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      )),
    );
  }

  Widget rentTenantBody() {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: mqWidth / 0.8,
      // height: 250,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "อัพโหลดหลักฐานการชำระเงิน",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            image = null;
                          });
                        },
                        child: Text("ลบรูป"))
                  ],
                )),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: image != null
                  ? SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                        child: Image.file(
                          image,
                          // width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                  : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,

                    child: (args.payHouseImg != null)? Image.network(
                      args.payHouseImg,
                      // width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ):Container(),
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.cloud_upload_rounded,
                  size: 48,
                  color: Color.fromRGBO(250, 120, 186, 1),
                ),
                onPressed: () async {
                  // ignore: deprecated_member_use
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final imageTemporaly = File(image.path);
                  setState(() => this.image = imageTemporaly);
                },
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ภาพตัวอย่างหลักฐานการชำระ",
                      style: TextStyle(fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "ภาพตัวอย่างหลักฐานการชำระ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    content: Image.asset('img/rentpay.png'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("ปิด"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          });
                        },
                        icon: Icon(
                          Icons.image,
                          size: 20,
                          color: Colors.grey,
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime datePicker = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (datePicker != null)
      setState(() {
        // _selectedDate =  new DateFormat('dd/MM/yyyy').format(d);
        _selectedDate = DateFormat('dd/MM/yyyy').format(datePicker);
      });
  }

  Widget datepay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "วันที่ชำระเงินตามหลักฐาน",
          style: TextStyle(fontSize: 16),
        ),
        InkWell(
          child: Text(_selectedDate,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF000000))),
          onTap: () {
            _selectDate(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          // tooltip: '',
          onPressed: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }

  Widget buttomPay() {
    return TextButton(
        child: FlatButton(
          onPressed: () async{
            TransactionModel model = new TransactionModel();
            model.payHouseDate = _selectedDate;
            model.id = args.id;
            print(_selectedDate);
            print(args.id);
            print(image == null ? "null" : image.path);
            var postUri = Uri.parse(
                "https://home-alone-csproject.herokuapp.com/payment/tenant-rent");

            String fileName = image.path.split('/').last;
            print(fileName);
            // print('{"rid": ${rentMode.rid},"tid": ${rentMode.tid},"hid": ${rentMode.hid},"rentingBook": ${rentMode.rentingBook},"rentingCheckIn": ${rentMode.rentingCheckIn},"rentingCheckOut": ${rentMode.rentingCheckOut}}');
            var request =
            http.MultipartRequest('POST', postUri)
              ..fields['id'] = args.id.toString()
              ..fields['date'] = datePicker.toString()
              ..files.add(await http.MultipartFile.fromBytes('file', await File.fromUri(image.uri).readAsBytes(), filename: fileName, contentType: MediaType(
            'ContentType', 'application/json')));
            print(request.fields.values);
            print(request.files.first.contentType);
            print(request.files.first.filename);
            print(request.files.first.field);
            var streamedResponse = await request.send();
            var response = await http.Response.fromStream(streamedResponse);
            if (response.statusCode == 200) {
              Navigator.of(context).pop(true);

            } else
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                duration: new Duration(seconds: 4),
                content: new Row(
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("เกิดข้อผิดพลาด:"+response.statusCode.toString())
                  ],
                ),
              ));
          },
          child: Text(
            "ยืนยันการชำระ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(1)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }
}
