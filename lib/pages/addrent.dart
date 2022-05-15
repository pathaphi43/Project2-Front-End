import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:homealone/model/Rent/RentModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:http/http.dart' as http;

class AddRent extends StatefulWidget {
  @override
  _AddRentState createState() => _AddRentState();
}



class _AddRentState extends State<AddRent> {
  DateTime dateTimeIn = DateTime.now();
  DateTime dateTimeOut = DateTime.now();
  String filepath = '';
  PlatformFile file;
  List<int> args;
  RentModel _rentModel;

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
    model.rentingStatus = 0;
    var jsonModel = rentModelToJson(model);

    var response = await http.post(
        Uri.parse('https://home-alone-csproject.herokuapp.com/rent/houseAt'),
        body: jsonModel,
        headers: {
          'Content-Type': 'application/json'
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body);
      // var data = utf8.decode(response.bodyBytes);
      // print(data);
      // print(rentModelFromJson(utf8.decode(response.bodyBytes)));
      return _rentModel = rentModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(args);
    return FutureBuilder( future: gethomeAll(args),
      builder: (BuildContext context,AsyncSnapshot<RentModel> snapshot) {
      if(snapshot.hasData){
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
                                    borderRadius: BorderRadius.circular(100.0)),
                                labelText: snapshot.data.tenantFirstname +"\t"+ snapshot.data.tenantLastname,
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
                                    borderRadius: BorderRadius.circular(100.0)),
                                labelText: snapshot.data.houseName,
                                prefixIcon: Icon(Icons.map_outlined)),
                            controller: null, //ส่งข้อมูลTextField
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
                                labelText: snapshot.data.houseDeposit.isNaN? 'ค่ามัดจำ':'ค่ามัดจำ '+snapshot.data.houseDeposit.toString(),
                                prefixIcon: Icon(Icons.money_rounded)),
                            controller: null, //ส่งข้อมูลTextField
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
                                labelText: snapshot.data.houseInsurance.isNaN? 'ค่าประกัน':'ค่าประกัน '+snapshot.data.houseInsurance.toString(),
                                prefixIcon: Icon(Icons.money_off_csred_outlined)),
                            controller: null, //ส่งข้อมูลTextField
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
                                labelText:snapshot.data.houseRent.isNaN? 'ค่าเช่า':'ค่าเช่า '+snapshot.data.houseRent.toString() ,
                                prefixIcon: Icon(Icons.confirmation_num_outlined)),
                            controller: null, //ส่งข้อมูลTextField
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                            child: FlatButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      // minTime: DateTime(2018, 3, 5),
                                      // maxTime: DateTime(2019, 6, 7),
                                      onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        dateTimeIn = date;

                                        print('confirm $date');
                                        setState(() {});
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.th);
                                },
                                child: ListTile(
                                  leading: Icon(Icons.date_range_outlined),
                                  title: Text(
                                      'วันที่เข้าอยู่ ${dateTimeIn.day} - ${dateTimeIn.month} - ${dateTimeIn.year}'),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                ))),
                        ////วันที่ออก
                        Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
                            child: FlatButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        dateTimeOut = date;
                                        print('confirm $date');
                                        setState(() {});
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.th);
                                },
                                child: ListTile(
                                  leading: Icon(Icons.date_range_outlined),
                                  title: Text(
                                      'วันที่ออก ${dateTimeOut.day} - ${dateTimeOut.month} - ${dateTimeOut.year}'),
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
                                  file = result.files.first;
                                  print(file.name);
                                  filepath = file.name;

                                  setState(() {});
                                } else {
                                  print('cancel');
                                  // User canceled the picker
                                }
                              },
                              child: ListTile(
                                leading: Icon(Icons.upload_file),
                                title: Text(
                                  'สัญญาเช่า - $filepath',
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.cancel_outlined),
                                  onPressed: () {
                                    print('IconButton');

                                    // setState(() {});
                                  },
                                ),
                              ),
                            )),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                              onPressed: () => null,
                              child: Text('เพิ่มการเช่าบ้าน'.toUpperCase(),
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
      }else return Scaffold(appBar: NavAppBar(),body: Center(child:CircularProgressIndicator(),),) ;

    },) ;
  }
}
