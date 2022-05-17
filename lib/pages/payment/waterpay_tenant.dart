import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class waterTenant extends StatefulWidget {
  waterTenant({key}) : super(key: key);

  @override
  State<waterTenant> createState() => _waterTenantState();
}

var formatter = new DateFormat('MM-yyyy');
class _waterTenantState extends State<waterTenant> {
  var image;

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
                "ยืนยันการชำระค่าน้ำ",
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(250, 120, 186, 1)),
              ),
              SizedBox(
                height: 8,
              ),
              waterInfo(),
              SizedBox(
                height: 8,
              ),
              waterTenantBody(),
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

   Widget waterInfo() {
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
            Text("ค่าน้ำประจำเดือน......."),
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

  Widget waterTenantBody() {
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
                                    content: Image.asset('img/PWApay.jpg'),
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

  DateTime showeDateNow =
      DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day);

// ignore: dead_code
Future   selectDate(BuildContext context, DateTime _selectedDate) async {
  // ignore: unnecessary_statements, unused_label
  context: context;
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: _selectedDate!= null ? _selectedDate:DateTime.now(),
                firstDate: DateTime(2000),
                dateFormat: "dd-MMMM-yyyy",
                locale: DateTimePickerLocale.th,
                textColor: Color.fromRGBO(250, 120, 186, 1),
                looping: true,
              );
              if (datePicked != null) {
                _selectedDate = datePicked;
              }
              return _selectedDate;
       
              // ignore: dead_code
              final snackBar =
              SnackBar(content: Text("$datePicked",style: TextStyle(fontSize: 18,fontFamily: 'Kanit',),));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

 }

  Widget datepay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "วันที่ชำระเงินตามหลักฐาน",
          style: TextStyle(fontSize: 16),
        ),
        TextButton.icon(
                icon: Icon(Icons.date_range_rounded,size: 24,),
                 onPressed: () async {
                        showeDateNow = await selectDate(context, showeDateNow);
                        setState(() {});
                      },label: Text("${formatter.format(showeDateNow)}" ,style: TextStyle(fontSize: 18),),
                         style: TextButton.styleFrom(
                         primary: Color.fromRGBO(247, 207, 205, 1),),
                         
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