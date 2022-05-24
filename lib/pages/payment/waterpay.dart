import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:homealone/model/payment/TransactionShowModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:homealone/pages/payment/paymentWidgetShow.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class WaterpayPage extends StatefulWidget {
  @override
  _WaterpayPageState createState() => _WaterpayPageState();
}
String dropdownValue1 = 'สถานะ';

class Exercise {
  String name;
  Exercise({this.name});
}
class _WaterpayPageState extends State<WaterpayPage> {

  static const int numItems = 15;
  int selectedCard = -1;
  // ignore: unused_field
  int _counter = 0;

  DateTime _selectedDate;

  List<Exercise> statusexercises = [
    Exercise(name: 'ชำระแล้ว'),
    Exercise(name: 'ค้างชำระ'),
  ];
  // ignore: unused_field
  int _selected;
  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  int args;

  @override
  void didChangeDependencies() async {
    args = ModalRoute
        .of(context)
        .settings
        .arguments;
    gethomeAll(args);
    super.didChangeDependencies();
  }

  DateTime dateTimeEnd = DateTime.now();
  DateTime dateTimeStart = DateTime.now().subtract(Duration(days: 30));
  List<TransactionShowModel> transactions;
  Stream<List<TransactionShowModel>> onCurrentUserChanged;
  StreamController<List<TransactionShowModel>> currentUserStreamCtrl =
  new StreamController<List<TransactionShowModel>>.broadcast();

  Future<void> onRefresh() {
    setState(() {
      gethomeAll(args);
    });
    return Future.delayed(Duration(seconds: 1));
  }


  Future<List<TransactionShowModel>> gethomeAll(int args) async {
    String uri;
    if(status == 0){
      uri = '/payment/house-rent/';
    }else if(status == 1){
      uri = 'payment/house-rent-tenant/';
    }else{
      uri = '/payment/house-rent/';
    }
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com','${uri}' + args.toString()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print("Body" + utf8.decode(response.bodyBytes));
      currentUserStreamCtrl.sink
          .add(transactionShowModelFromJson(utf8.decode(response.bodyBytes)));
      transactions =
          transactionShowModelFromJson(utf8.decode(response.bodyBytes));

      return transactions;
    } else {
      throw Exception('Failed to load homedata');
    }
  }
  PaymentWidgetShow _paymentWidgetShow = new PaymentWidgetShow();
  List<DataRow> dataRowList(List<TransactionShowModel> model) {
    List<DataRow> dataRows = [];
    model.forEach((element) {
      print(element.house.houseName);
      element.payments.forEach((pay) {
        dataRows.add(
            DataRow(
                cells: [
                  DataCell(
                      Center(child: Text(element.tenant.tenantFirstname),)
                  ),
                  DataCell(
                      Center(child: Text(element.house.houseName),)
                  ),
                  DataCell(
                      Center(child: Text('${DateFormat("MMMM","th").format(pay.payWaterInmonth)}'),)
                  ),
                  DataCell(
                      Center(child: Text(pay.payWaterAmount.toString()),)
                  ),
                  DataCell(
                      Center(
                          child:(status == 1)? (pay.payWaterStatus == 0)?TextButton(onPressed: () =>  Navigator.pushNamed(context, '/WaterPayTenant-page', arguments: pay), child: Text("ชำระเงิน",style: TextStyle(color: Colors.red),)):(pay.payWaterStatus  == 1)?TextButton(onPressed: () =>  Navigator.pushNamed(context, '/WaterPayTenant-page', arguments: pay), child: Text("รอยืนยัน",style: TextStyle(color: Colors.orange),)):Text("ชำระแล้ว",style: TextStyle(color: Colors.green),) : (pay.payWaterStatus == 0)
                              ? TextButton(
                              onPressed: () => print("ไปหน้าแก้ไข"),
                              child: Text(
                                "ค้างชำระ",
                                style: TextStyle(color: Colors.red),
                              ))
                              : (pay.payWaterStatus == 1)
                              ? TextButton(
                              onPressed: () => showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('ยืนยันการชำระเงิน'),
                                      content: Center(
                                        child: _paymentWidgetShow.columnShowWater(pay)
                                      ),
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
                                              duration:
                                              new Duration(seconds: 4),
                                              content: new Row(
                                                children: <Widget>[
                                                  new CircularProgressIndicator(),
                                                  new Text("กำลังโหลด...")
                                                ],
                                              ),
                                            ));
                                            print(pay.id);
                                            var response = await http.get(
                                                Uri.parse('https://home-alone-csproject.herokuapp.com/payment/tenant-water/'+pay.id.toString()),
                                                headers: {
                                                  'Content-Type': 'application/json'
                                                });
                                            if (response.statusCode == 200){
                                              setState(() {
                                                Navigator.pop(context, 'ยืนยัน');
                                              });
                                            }else ScaffoldMessenger.of(context)
                                                .showSnackBar(new SnackBar(
                                              duration:
                                              new Duration(seconds: 4),
                                              content: new Row(
                                                children: <Widget>[
                                                  new CircularProgressIndicator(),
                                                  new Text("เกิดข้อผิดพลาด")
                                                ],
                                              ),
                                            ));
                                            },
                                          child: const Text('ยืนยัน'),
                                        ),
                                      ],
                                    ),
                              ),
                              child: Text(
                                "รอยืนยัน",
                                style: TextStyle(color: Colors.orange),
                              ))
                              : TextButton(
                              onPressed: () => showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('การชำระเงิน'),
                                      content: Center(child: _paymentWidgetShow.columnShowWater(pay)),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, 'Cancel'),
                                          child: const Text('ปิด'),
                                        ),
                                      ],
                                    ),
                              ),
                              child: Text(
                                "ชำระแล้ว",
                                style: TextStyle(color: Colors.lightGreen),
                              )))
                  ),
                ]
            )
        );
      });
    });


    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: waterBody(context)
    );
  }

 Widget waterBody(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
           appBar: NavAppBar(), body: rentBody(context)
    );
  }

    Widget rentBody(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: RefreshIndicator( onRefresh: onRefresh,
          child: StreamBuilder(
              stream: currentUserStreamCtrl.stream,
              builder: (BuildContext context,
              AsyncSnapshot<List<TransactionShowModel>> snapshot) {
                print(snapshot.connectionState);
            if(snapshot.hasData){
              return  SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("ค่าน้ำประปา",
                          style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 20)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      child: rentsearch(context),
                    ),

                    Container(
                      width: mqWidth,
                      height: mqHeight,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(
                              width: mqWidth,
                              child: DataTable(
                                  columnSpacing: 0,
                                  horizontalMargin: 0,
                                  columns: const <DataColumn>[
                                    DataColumn(
                                        label: Expanded(
                                          child: Text('ผู้เช่า',
                                              style: TextStyle(fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center),
                                        )),
                                    DataColumn(
                                        label: Expanded(
                                          child: Text('บ้าน',
                                              style: TextStyle(fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center),
                                        )),
                                    DataColumn(
                                        label: Expanded(
                                          child: Text('เดือน',
                                              style: TextStyle(fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center),
                                        )),
                                    DataColumn(
                                        label: Expanded(
                                          child: Text('จำนวน',
                                              style: TextStyle(fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center),
                                        )),
                                    DataColumn(
                                        label: Expanded(
                                          child: Text('สถานะ',
                                              style: TextStyle(fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center),
                                        )),
                                  ],
                                  rows: dataRowList(snapshot.data)))
                        ],
                      ),
                    )

                  ],
                ),
              );
            }else return Center(
              child: CircularProgressIndicator(),
            );
          }),)
       );
  }

   Widget rentsearch(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 40, width: 300),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Color.fromRGBO(247, 207, 205, 1)),
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white70),
          ),
        ),
        Menusearch(context)
      ],
    ));
  }

selectDate(BuildContext context) async {
  // ignore: unnecessary_statements, unused_label
  context: context;
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: _selectedDate!= null ? _selectedDate:DateTime.now(),
                firstDate: DateTime(2000),
                dateFormat: "MMMM-yyyy",
                locale: DateTimePickerLocale.th,
                textColor: Color.fromRGBO(250, 120, 186, 1),
                looping: true,
              );
       
              final snackBar =
              SnackBar(content: Text("$datePicked",style: TextStyle(fontSize: 18,fontFamily: 'Kanit',),));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

 }
 

   Widget Menusearch(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PopupMenuButton(
          icon: Icon(Icons.list_alt),
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ชำระประจำเดือน"),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                  onTap: () {
                    Future<void>.delayed(
                      const Duration(), // OR const Duration(milliseconds: 500),
                      () {selectDate(context);}
                    );
                  },
                  value: 1,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("สถานะการชำระ"),
                      Icon(Icons.announcement_rounded)
                    ],
                  ),
                  onTap: () {
                    Future<void>.delayed(
                      const Duration(), // OR const Duration(milliseconds: 500),
                      () => showDialog(
                        context: context,
                        barrierColor: Colors.black26,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "สถานะการชำระ",
                            style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontWeight: FontWeight.bold,),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 2,),
                            FlatButton(
                              child: const Text('Cancel',
                                  style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontWeight: FontWeight.bold,)),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            
                          ],
                          content: Container(
                            height: 150,
                            width: double.maxFinite,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Divider(),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                      ),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(20.0),
                                          itemCount: statusexercises.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Container(
                                                  width: 300,
                                                  height: 50,
                                                  color: selectedCard == index
                                                      ? Color.fromRGBO(
                                                          247, 207, 205, 1)
                                                      : Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                  child: Center(
                                                    child: Text(
                                                      statusexercises[index]
                                                          .name,
                                                      style: TextStyle(),
                                                    ),
                                                  )),
                                              onTap: () {
                                                setState(() {
                                                  // ontap of each card, set the defined int to the grid view index
                                                  selectedCard = index;
                                                });
                                              },
                                            );
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  value: 2,
                ),
              ]),
    );
  }
}
