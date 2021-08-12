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
  var tenant_District = TextEditingController();
  var tenant_Email = TextEditingController();
  var _ChoseValue;
  var _ChoseValueAmphureThailand;
  @override
  void initState() {
    // super.initState();
    _Thailand();
  }

  var arr = new List(78);
  List<Provinces> province;
  List<String> strArr;
  Future<Provinces> getProvinces() async {
    Future<String> provincesJson =
        rootBundle.loadString('Json/thai_provinces.json');
    await provincesJson.then((value) {
      province = provincesFromJson(value);
      print(province[0].nameTh);
    });

    province.map((province) {
      // strArr.add(province.nameTh);
      return province.nameTh;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<Thailand> province_th =[];
  List<AmphureThailand> Amphurethai =[];

  _Thailand() async{
    var list = await ProvinceProvider.all();
    ProvinceDao province ;
    for(province in list){
      // province.nameTh;
      // province.nameEn;
      // province.id;
      print("111111111111111111111111111");
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
      // amphure.id;
      // amphure.provinceId;
      // amphure.nameTh;
      // amphure.nameEn;
      Amphurethai.add(new AmphureThailand(
        name: amphure.nameTh.toString(),
        id: amphure.id.toString(),
      ));
      print(amphure.nameTh);
    }

    setState(() {

    });
    // print(Amphuree);
  }

  // var province_th = [
  //   'กรุงเทพฯ',
  //   'กระบี่',
  //   'กาญจนบุรี',
  //   'กาฬสินธุ์',
  //   'กำแพงเพชร',
  //   'ขอนแก่น',
  //   'จันทบุรี',
  //   'ฉะเชิงเทรา',
  //   'ชลบุรี',
  //   'ชัยนาท',
  //   'ชัยภูมิ',
  //   'ชุมพร',
  //   'เชียnงใหม่',
  //   'เชียงราย',
  //   'ตรัง',
  //   'ตราด',
  //   'ตาก',
  //   'นครนายก',
  //   'นครปฐม',
  //   'นครพนม',
  //   'นครราชสีมา',
  //   'นครศรีธรรมราช',
  //   'นครสวรรค์',
  //   'นนทบุรี',
  //   'นราธิวาส',
  //   'น่าน',
  //   'บึงกาฬ',
  //   'บุรีรัมย์',
  //   'ปทุมธานี',
  //   'ประจวบคีรีขันธ์',
  //   'ปราจีนบุรี',
  //   'ปัตตานี',
  //   'พระนครศรีอยุธยา',
  //   'พะเยา',
  //   'พังงา',
  //   'พัทลุง',
  //   'พิจิตร',
  //   'พิษณุโลก',
  //   'เพชรบุรี',
  //   'เพชรบูรณ์',
  //   'แพร่',
  //   'ภูเก็ต',
  //   'มหาสารคาม',
  //   'มุกดาหาร',
  //   'แม่ฮ่องสอน',
  //   'ยโสธร',
  //   'ยะลา',
  //   'ร้อยเอ็ด',
  //   'ระนอง',
  //   'ระยอง',
  //   'ราชบุรี',
  //   'ลพบุรี',
  //   'ลำปาง',
  //   'ลำพูน',
  //   'เลย',
  //   'ศรีสะเกษ',
  //   'สกลนคร',
  //   'สงขลา',
  //   'สตูล',
  //   'สมุทรปราการ',
  //   'สมุทรสงคราม',
  //   'สมุทรสาคร',
  //   'สระแก้ว',
  //   'สระบุรี',
  //   'สิงห์บุรี',
  //   'สุโขทัย',
  //   'สุพรรณบุรี',
  //   'สุราษฎร์ธานี',
  //   'สุรินทร์',
  //   'หนองคาย',
  //   'หนองบัวลำภู',
  //   'อ่างทอง',
  //   'อำนาจเจริญ',
  //   'อุดรธานี',
  //   'อุตรดิตถ์',
  //   'อุทัยธานี',
  //   'อุบลราชธานี',
  // ];

  String dropdownValue1 = 'กรุงเทพฯ';

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
                  fontFamily: 'Roboto',
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
                      height: 70.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Username,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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
                      height: 70.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Password,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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
////////// ชื่อ-สกุล
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        SizedBox(width: 30.0, height: 40.0),
                        new Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          //decoration: kBoxDecorationStyle ,
                          height: 70.0,
                          width: 300.0,
                          child: TextField(
                            controller: tenant_Firstname,
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 18.0,
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
                          height: 70.0,
                          width: 300.0,
                          child: TextField(
                            controller: tenant_Lastname,
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 18.0,
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
              ),

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
                      height: 70.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_IDcard,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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
                      ),
                    ),
                  ],
                ),
              ),

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
                      height: 75.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Add,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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
/////////////////จังหวัด
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text('จังหวัด',
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                            ),

                            new Container(
                              alignment: Alignment.centerRight,
                              height: 70.0,
                              width: 220.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: DropdownButton<String>(
                                icon: const Icon(
                                  Icons.arrow_circle_down,
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                ),
                                //iconSize: 25,
                                //iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                elevation: 10,
                                style: const TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 18,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // value: dropdownValue1,

                                items: province_th.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    child: Text(item.name,
                                        style: TextStyle(
                                            color: Color.fromRGBO(250, 120, 186, 1),
                                            fontSize: 18)
                                    ),

                                    // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                  );
                                })?.toList(),

                                onChanged: (value) {
                                  setState(() {
                                    _ChoseValue = value;
                                    // print(_ChoseValue);
                                    _Amphure(_ChoseValue);
                                  });
                                },

                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text('อำเภอ',
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            new Container(
                              alignment: Alignment.centerRight,
                              height: 70.0,
                              width: 220.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                              ),

                              child: DropdownButton<String>(
                                icon: const Icon(
                                  Icons.arrow_circle_down,
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                ),
                                //iconSize: 25,
                              //  iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                                elevation: 10,
                                style: const TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 18,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // value: dropdownValue1,

                                items: Amphurethai.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    child: Text(item.name,
                                        style: TextStyle(
                                            color: Color.fromRGBO(250, 120, 186, 1),
                                            fontSize: 18)
                                    ),

                                    // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                  );
                                })?.toList(),

                                onChanged: (value) {
                                  setState(() {
                                    _ChoseValueAmphureThailand = value;
                                    // print(_ChoseValue);

                                  });
                                },

                              ),
                            ),
                          ],
                        ),


                  ],
                ),
              ),
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
                      height: 70.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Phone,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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
                      ),
                    ),
                  ],
                ),
              ),

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
                      height: 70.0,
                      width: 300.0,
                      child: TextField(
                        controller: tenant_Email,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 18.0,
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



              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.0),
                    Container(
                      height: 40.0,
                      width: 200.0,
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
                          regdata.tenantDistrict = tenant_District.text;
                          regdata.tenantIDcard = tenant_IDcard.text;
                          regdata.tenantPhone = tenant_Phone.text;
                          regdata.tenantEmail = tenant_Email.text;

                          var jsondata = regtenantToJson(regdata);
                          print(jsondata);
                          var response = await http.post(Uri.parse('http://homealone.comsciproject.com/user/regtenant'),
                              body: jsondata, headers: {
                                'Content-Type': 'application/json',
                              }
                          );
                          if(response.statusCode.toString() == "201"){
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
