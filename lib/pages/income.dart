// ignore_for_file: dead_code

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:homealone/model/payment/IncomeModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IncomePage extends StatefulWidget {
  IncomePage({key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}


class _IncomePageState extends State<IncomePage> {
  int args;
  var formatter = new DateFormat('MM-yyyy');
  DateTime _dateFrom = new DateTime.now().subtract(Duration(days: 30));
  DateTime _dateTo = new DateTime.now();
  DateTime showeDateFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);

  DateTime showeDateTo = DateTime(DateTime.now().year, DateTime.now().add(Duration(days: 30)).month, 1);

  Future selectDate(BuildContext context, DateTime _selectedDate) async {
    // ignore: unnecessary_statements, unused_label
    context:context;
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(2000),
      dateFormat: "MMMM-yyyy",
      locale: DateTimePickerLocale.th,
      textColor: Color.fromRGBO(250, 120, 186, 1),
      looping: true,
    );
    if (datePicked != null) {
      _selectedDate = datePicked;
    }
    return _selectedDate;

    final snackBar = SnackBar(
        content: Text(
          "$datePicked",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Kanit',
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments;
  }



  List<IncomeModel> income;
  Future<List<IncomeModel>> getIncome(String mid,String dateFrom,String dateTo) async {
    print(dateFrom);
    print(dateTo);
    print(mid);

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://home-alone-csproject.herokuapp.com/payment/payment-summary'))
      ..fields['mid'] = mid
      ..fields['dateFrom'] = dateFrom
      ..fields['dateTo'] = dateTo;
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("income"+response.statusCode.toString());

    if (response.statusCode == 200) {
      return income = incomeModelFromJson(utf8.decode(response.bodyBytes));
    } else
      throw Exception('Failed to load homedata');
  }

  static const int numItems = 15;
  List<DataRow> dataRowList(List<IncomeModel> model) {
    List<DataRow> dataRows = [];
    model.forEach((element) {
      element.payments.forEach((pay) {
        dataRows.add(DataRow(cells: [
          DataCell(Center(
            child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/Homeinfo-page',
                    arguments: [element.house.hid]),
                child: Text(element.house.houseName)),
          )),
          DataCell(Center(
            child: Text('${DateFormat("MMMM", "th").format(pay.installment)}'),
          )),
          DataCell(Center(
            child: Text(pay.payHouseAmount.toString()),
          )),
        ]));
      });
    });
    return dataRows;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(),
      body: bodyIncome(context),
    );
  }

  Widget bodyIncome(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(future: getIncome(id.toString(),showeDateFrom.toString(),showeDateTo.toString()),
          builder: (BuildContext context,AsyncSnapshot<List<IncomeModel>> snapshot){
            print("Snap"+snapshot.connectionState.toString());
        if(snapshot.hasData){
          return SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "รายได้",
                    style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1), fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.sim_card_download_rounded,
                        size: 30, color: Color.fromRGBO(247, 207, 205, 1)),
                    onPressed: () {
                      print("Can't downlode PDF");
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InputDate(context),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                                        child: Text('บ้าน',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.center),
                                      )),
                                  DataColumn(
                                      label: Expanded(
                                        child: Text('เดือน',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.center),
                                      )),
                                  DataColumn(
                                      label: Expanded(
                                        child: Text('จำนวน',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.center),
                                      )),
                                ],
                                rows: dataRowList(snapshot.data)
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ]),
          );
        }else return Center(
              child: CircularProgressIndicator(),
            );


    })

    );



  }

  // ignore: dead_code

  // ignore: non_constant_identifier_names
  Widget InputDate(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 10,
              ),
              Text("เริ่มต้น",
                  style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1))),
              TextButton.icon(
                icon: Icon(Icons.date_range_rounded),
                onPressed: () async {
                  showeDateFrom = await selectDate(context, showeDateFrom);
                  setState(() {});
                },
                label: Text("${formatter.format(showeDateFrom)}"),
                style: TextButton.styleFrom(
                    primary: Color.fromRGBO(247, 207, 205, 1)),
              ),
              SizedBox(
                width: 20,
              ),
              Text("สิ้นสุด",
                  style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1))),
              TextButton.icon(
                icon: Icon(Icons.date_range_rounded),
                onPressed: () async {
                  showeDateTo = await selectDate(context, showeDateTo);
                  setState(() {});
                },
                label: Text("${formatter.format(showeDateTo)}"),
                style: TextButton.styleFrom(
                    primary: Color.fromRGBO(247, 207, 205, 1)),
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.all(10),
          height: 45.0,
          child: SizedBox.fromSize(
            size: Size(45, 45), // button width and height
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(250, 120, 186, 1), // button color
                child: InkWell(
                  splashColor: Color.fromRGBO(247, 207, 205, 1),
                  // splash color
                  onTap: () {
                    // income.clear();
                    setState(() {

                    });
                  },
                  // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ), // icon
                      Text(
                        "ค้นหา",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ), // text
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    ));
  }
}
