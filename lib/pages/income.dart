// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class IncomePage extends StatefulWidget {
  IncomePage({key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}
 

var formatter = new DateFormat('MM-yyyy');

 DateTime showeDateNow =
      DateTime(DateTime.now().year, DateTime.now().month,1);

Future   selectDate(BuildContext context, DateTime _selectedDate) async {
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
              if (datePicked != null) {
                _selectedDate = datePicked;
              }
              return _selectedDate;
       
              final snackBar =
              SnackBar(content: Text("$datePicked",style: TextStyle(fontSize: 18,fontFamily: 'Kanit',),));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

 }

class _IncomePageState extends State<IncomePage> {

  static const int numItems = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(),
      body: bodyIncome(context),
    );
  }

  Widget bodyIncome(BuildContext context){
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    
   body: Container(
      child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("รายได้",style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 20),),
              SizedBox(width: 20,),
              IconButton(icon: Icon(Icons.sim_card_download_rounded,size: 30,color: Color.fromRGBO(247, 207, 205, 1)),onPressed: (){
                print("Can't downlode PDF");
              },)
            ],
          ),
          SizedBox(height: 10,),
          InputDate(context),
          SizedBox(height: 10,),
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
                         
                        ],
                        rows: List<DataRow>.generate(
                          numItems,
                          (int index) => DataRow(cells: <DataCell>[
                            
                            DataCell(Center(child: Text('บ้านลักษณาวดี'))),
                            DataCell(Center(child: Text('มกราคม'))),
                            DataCell(Center(child: Text('5,500'))),
                           
                          ]),
                        )))
              ],
            ),
          )
        ],
      ),
          
        ]),
      ),
    ),);
  }

  // ignore: dead_code


  // ignore: non_constant_identifier_names
  Widget InputDate(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 10,),
              Text("เริ่มต้น",style: TextStyle(color:Color.fromRGBO(250, 120, 186, 1))),
              TextButton.icon(
                icon: Icon(Icons.date_range_rounded),
                 onPressed: () async {
                        showeDateNow = await selectDate(context, showeDateNow);
                        setState(() {});
                      },label: Text("${formatter.format(showeDateNow)}"),
                         style: TextButton.styleFrom(
                         primary: Color.fromRGBO(247, 207, 205, 1)),
              ),
              SizedBox(width: 20,),
              Text("สิ้นสุด",style: TextStyle(color:Color.fromRGBO(250, 120, 186, 1))),
              TextButton.icon(
                icon: Icon(Icons.date_range_rounded),
                 onPressed: () async {
                        showeDateNow = await selectDate(context, showeDateNow);
                        setState(() {});
                      },label: Text("${formatter.format(showeDateNow)}"),
                      style: TextButton.styleFrom(
                         primary: Color.fromRGBO(247, 207, 205, 1)),
              )
            ],
          ),),
          Container(
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
                      onTap: () {},
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
            )
        ],
      )
      
    );
  }


}