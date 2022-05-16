import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

import '../Navbar/appBar.dart';

class addWaterPage extends StatefulWidget {
  addWaterPage({key}) : super(key: key);

  @override
  State<addWaterPage> createState() => _addWaterPageState();
}
var formatter = new DateFormat('dd-MM-yyyy');
class _addWaterPageState extends State<addWaterPage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NavAppBar(),
      body: addwaterBody(),
    );
  }


DateTime showDateNow =
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

  Widget addwaterBody(){
    return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       child: Column(
         children: [
           Container(
             child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Text("งวดค่าน้ำ",style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 20)),
                        TextButton.icon(
                      icon: Icon(Icons.date_range_rounded,size: 28,),
                       onPressed: () async {
                              showDateNow = await selectDate(context, showDateNow);
                              setState(() {});
                            },label: Text("${formatter.format(showDateNow)}" ,style: TextStyle(fontSize: 20),),
                               style: TextButton.styleFrom(
                               primary: Color.fromRGBO(247, 207, 205, 1),),
                               
                    ),
                SizedBox(
                  height: 18,
                ),
             ]),
           ),
           Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text("จำนวนเงิน",style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 18)),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  // height: MediaQuery.of(context).size.height/15,
                  child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
              ),
             enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(247, 207, 205, 1),
                          )
                      )
            ),
            keyboardType: TextInputType.number,),
                )
               ],
             ),
           ),
           SizedBox(
                  height: 18,
                ),
          Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text("วันที่หมดเขต",style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 18)),
                        TextButton.icon(
                icon: Icon(Icons.date_range_rounded,size: 24,),
                 onPressed: () async {
                        showDateNow = await selectDate(context, showDateNow);
                        setState(() {});
                      },label: Text("${formatter.format(showDateNow)}" ,style: TextStyle(fontSize: 18),),
                         style: TextButton.styleFrom(
                         primary: Color.fromRGBO(247, 207, 205, 1),),
                         
              ),
               ],
             ),
           ),
            SizedBox(
                  height: 28,
                ),
           Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 FlatButton(
                
                                minWidth: 100.0,
                                height: 44.0,
                                color: Color.fromRGBO(247, 207, 205, 1),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: 
                                    Text(
                                      "บันทึก",
                                      style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kanit',
                                      ),
                                    ),
                                 
                                shape: StadiumBorder(
                                    side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                )),
                              ),
                              SizedBox(width: 4,),
                   FlatButton(
                                minWidth: 100.0,
                                height: 45.0,
                                // color: Color.fromRGBO(247, 207, 205, 1),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: 
                                    Text(
                                      "ยกเลิก",
                                      style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kanit',
                                      ),
                                  
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                )),
                              ),
                                SizedBox(width: 8,),
               ],
             ),
           ),

         ],
       ),
    );
  }
}