import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homealone/model/payment/TransactionMedel.dart';
import 'package:homealone/model/payment/TransactionShowModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/payment/rentpay.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class elecTenant extends StatefulWidget {
  elecTenant({key}) : super(key: key);

  @override
  State<elecTenant> createState() => _elecTenantState();
}

class _elecTenantState extends State<elecTenant> {
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
                "ยืนยันการชำระค่าไฟ",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(250, 120, 186, 1)),
              ),
              SizedBox(
                height: 8,
              ),
              elecInfo(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: elecTenantBody(),
                  ),
                ],
              ),
              datepay(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget elecInfo() {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mqWidth / 0.8,
      height: 100,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Text("ค่าไฟประจำเดือน ${DateFormat('MMMM-yyyy','th').format(args.payElecInmonth)}"),
            SizedBox(
              height: 8,
            ),
            // Text("อัตราค่าไฟฟ้าหน่วยละ ${args.t} บาท"),
            // SizedBox(
            //   height: 18,
            // ),
            Text("จำนวนเงิน ${args.payElecAmount} บาท"),
            SizedBox(
              height: 18,
            ),
            Text(
              "หมดเขตชำระ ${DateFormat('dd-MMMM-yyyy','th').format(args.payElecEnd)}",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget elecTenantBody() {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: mqWidth / 0.8,
      // height: 180,
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
                )
            ),
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
                    child: (args.payElecImg != null)? Image.network(
                      args.payElecImg,
                      // width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ):Container(),
                  ),
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
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
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
                                    content: Image.asset('img/PEApay.jpg'),
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
      datePicker= await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (datePicker != null)
      setState(() {
        _selectedDate = new DateFormat('dd/MM/yyyy').format(datePicker);
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
            print(datePicker);
            print(args.id);
            print(image == null ? "null" : image.path);
            var postUri = Uri.parse(
                "https://home-alone-csproject.herokuapp.com/payment/tenant-electric");

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
