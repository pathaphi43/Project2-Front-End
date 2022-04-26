import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class rentTenant extends StatefulWidget {
  rentTenant({key}) : super(key: key);

  @override
  State<rentTenant> createState() => _rentTenantState();
}

class _rentTenantState extends State<rentTenant> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(
                height: 8,
              ),
              rentTenantBody(),
              SizedBox(
                height: 8,
              ),
              datepay(context),
              SizedBox(
                height: 28,
              ),
              buttomPay()
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
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Text("ค่าเช่าประจำเดือน......."),
            SizedBox(
              height: 8,
            ),
            Text("จำนวนเงิน......บาท"),
            SizedBox(
              height: 18,
            ),
            Text(
              "หมดเขตชำระ........",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget rentTenantBody() {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mqWidth / 0.8,
      height: 180,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "อัพโหลดหลักฐานการชำระเงิน",
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(
              height: 8,
            ),
            //   Padding(
            //   padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
            //   child: image != null? ClipRRect(
            //     borderRadius: BorderRadius.circular(50),
            //     child: Image.file(
            //       image,
            //       width: 150,
            //       height: 200,
            //       fit: BoxFit.fitHeight,
            //     ),
            //   ) : Container(
            //     child: Icon(
            //       Icons.account_box_sharp,
            //       color: Colors.grey[800],size: 150,
            //     ),
            //   ),
            // ),
            //  SizedBox(
            //   height: 8,
            // ),
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

  String _selectedDate = '01/01/2015';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat('dd/MM/yyyy').format(d);
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
          onPressed: () {},
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
