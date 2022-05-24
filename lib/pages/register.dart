import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/provider/address_provider.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:homealone/model/AmphureThailand.dart';
import 'package:homealone/model/Thailand.dart';
import 'dart:convert' show utf8;
import 'dart:async';
import 'package:homealone/model/register/provincesmodel.dart';
import 'package:homealone/model/register/regtenantmodel.dart';

import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var encoded = utf8.encode('Lorem ipsum dolor sit amet, consetetur...');
var decoded = utf8.decode(encoded);

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var tenant_Username = TextEditingController();
  var tenant_Password = TextEditingController();
  var tenant_Firstname = TextEditingController();
  var tenant_Lastname = TextEditingController();
  var tenant_Phone = TextEditingController();
  var tenant_IDcard = TextEditingController();
  var tenant_Add = TextEditingController();
  var tenant_Province;
  var tenant_District;
  var tenant_Email = TextEditingController();
  var _ChoseValue;
  var _ChoseValueAmphureThailand;
  @override
  void initState() {
    // super.initState();
    _Thailand();
  }

  List<Thailand> province_th =[];
  List<AmphureThailand> Amphurethai =[];

  _Thailand() async{
    var list = await ProvinceProvider.all();
    ProvinceDao province ;
    for(province in list){
      province_th.add(new Thailand(
        name: province.nameTh.toString(),
          id: province.id.toString(),
      ));
    }
    // var lists = await AddressProvider.all();
    setState(() {

    });
    // print(province_th);
  }
  _Amphure(value) async{
    // var Amphuree = await AmphureProvider.searchInProvince(provinceId: 1);

    // AmphureDao amphure ;
    var list = await AmphureProvider.all(provinceId: int.parse(value));

    Amphurethai.removeRange(0,Amphurethai.length);

    for(AmphureDao amphure in list){
      if(amphure.nameTh[0]!= "*") {
        Amphurethai.add(new AmphureThailand(
          name: amphure.nameTh.toString(),
          id: amphure.id.toString(),
        ));
        // print(amphure.nameTh);
      }
    }

    setState(() {

    });
    // print(Amphuree);
  }

  String dropdownValue1 = 'กรุงเทพฯ';
  var maskIDcardFormatter = new MaskTextInputFormatter(
      mask: '#############', filter: {"#": RegExp(r'[0-9]')});
  
  var maskPhoneFormatter = new MaskTextInputFormatter(
      mask: '##########', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
        //centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80.0),
              new Text(
                ' Sign up',
                style: TextStyle(
                  color: Color.fromRGBO(250, 120, 186, 1),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Righteous-Regular',
                ),
              ),
              SizedBox(height: 60.0),
////////// ชื่อผู้ใช้
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Username,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ชื่อผู้ใช้',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

/////////////รหัสผ่าน
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Password,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'รหัสผ่าน',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                        autofocus: false,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),

////////// ชื่อ-สกุล
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10.0, height: 40.0),
                        new Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          //decoration: kBoxDecorationStyle ,
                          height:60.0,
                          width: 160.0,
                          child: TextField(
                            controller: tenant_Firstname,
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'ชื่อ',
                                labelStyle: new TextStyle(
                                    color:
                                    const Color.fromRGBO(250, 120, 186, 1)),
                                // hintText: 'Enter valid mail id as abc@gmail.com'
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                        Color.fromRGBO(250, 120, 186, 1)))),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          //decoration: kBoxDecorationStyle ,
                          height: 60.0,
                          width: 150.0,
                          child: TextField(
                            controller: tenant_Lastname,
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'สกุล',
                                labelStyle: new TextStyle(
                                    color:
                                    const Color.fromRGBO(250, 120, 186, 1)),
                                // hintText: 'Enter valid mail id as abc@gmail.com'
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                        Color.fromRGBO(250, 120, 186, 1)))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

////////// เลขบัตรประชาชน
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_IDcard,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                          
                        ),
                        decoration: InputDecoration(
                          
                            border: OutlineInputBorder(),
                            labelText: 'เลขบัตรประชาชน',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskIDcardFormatter],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

////////// ที่อยู่ตามบัตรประชาชน
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Add,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ที่อยู่ตามบัตรประชาชน',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

/////////////////จังหวัด
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                        Container(
                          width: MediaQuery.of(context).size.width ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new Text('จังหวัด',
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                              ),

                              new Container(
                                alignment: Alignment.centerRight,
                                height: 60.0,
                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.arrow_circle_down,
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    size: 20,
                                  ),
                                  //iconSize: 25,
                                  //iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                  elevation: 10,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                  ),
                                  value: _ChoseValue,
                                  hint: Text(
                                    "  -- โปรดเลือก --  ",
                                    style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // value: dropdownValue1,

                                  items: province_th.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.name,
                                          style: TextStyle(
                                              color: Color.fromRGBO(250, 120, 186, 1),
                                              fontSize: 16)
                                      ),

                                      // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                    );
                                  })?.toList(),

                                  onChanged: (value) {
                                    setState(() {
                                      _ChoseValue = value;
                                      print(_ChoseValue);

                                      _Amphure(_ChoseValue);
                                      int index = int.parse(_ChoseValue);
                                      tenant_Province = province_th[int.parse(value)-1].name;
                                      _ChoseValueAmphureThailand = null;

                                    });
                                  },

                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new Text('อำเภอ',
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                             
                              new Container(
                                alignment: Alignment.centerRight,
                                height: 60.0,
                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /1.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                ),

                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.arrow_circle_down,
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    size: 20,
                                  ),
                                  //iconSize: 25,
                                //  iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                  elevation: 10,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  underline: Container(
                                    height: 1,
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                  ),
                                  value: _ChoseValueAmphureThailand,
                                  hint: Text(
                                    "  -- โปรดเลือก --  ",
                                    style: TextStyle(
                                        color: Color.fromRGBO(250, 120, 186, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // value: dropdownValue1,

                                  items: Amphurethai.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.name,
                                          style: TextStyle(
                                              color: Color.fromRGBO(250, 120, 186, 1),
                                              fontSize: 16)
                                      ),

                                      // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                    );
                                  })?.toList(),

                                  onChanged: (value) {
                                    setState(() {
                                      _ChoseValueAmphureThailand = value;
                                      // print(_ChoseValue);
                                      for (int i = 0;
                                      i < Amphurethai.length;
                                      i++) {
                                        if (Amphurethai[i].id ==
                                            _ChoseValueAmphureThailand) {
                                          // print("Index"+Amphurethai[i].name[0]);
                                          tenant_District =
                                              Amphurethai[i].name;
                                        }
                                      }

                                    });
                                  },

                                ),
                              ),
                            ],
                          ),
                        ),


                  ],
                ),
              ),
              SizedBox(height: 20.0),

////////// เบอร์โทร
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Phone,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'เบอร์โทร',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskPhoneFormatter],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

////////// email
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 60.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Email,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color.fromRGBO(250, 120, 186, 1)))),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),


              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0),
                    Container(
                      height: 45.0,
                      width: 180.0,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(250, 120, 186, 1))),
                        onPressed: () async {
                          var regdata = Regtenant();
                          regdata.tenantUsername = tenant_Username.text;
                          regdata.tenantPassword = tenant_Password.text;
                          regdata.tenantFirstname = tenant_Firstname.text;
                          regdata.tenantLastname = tenant_Lastname.text;
                          regdata.tenantAdd = tenant_Add.text;
                          regdata.tenantProvince = tenant_Province;
                          regdata.tenantDistrict = tenant_District;
                          regdata.tenantIDcard = tenant_IDcard.text;
                          regdata.tenantPhone = tenant_Phone.text;
                          regdata.tenantEmail = tenant_Email.text;

                          var jsondata = regtenantToJson(regdata);
                          print(jsondata);
                          var response = await http.post(Uri.parse('https://home-alone-csproject.herokuapp.com/tenant/signup'),
                              body: jsondata, headers: {
                                'Content-Type': 'application/json',
                              }
                          );
                          if(response.statusCode.toString() == "200"){
                            Navigator.popUntil(context, ModalRoute.withName('/Prelogin-page'));
                          }else{
                            print("ชื่อผู้ใช้งานซ้ำกัน");
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        color: Color.fromRGBO(250, 120, 186, 1),
                        textColor: Colors.white,
                        child: Text("Confirm",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ),
                    SizedBox(height: 100.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
