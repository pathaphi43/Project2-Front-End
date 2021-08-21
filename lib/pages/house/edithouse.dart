import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/Edit/edithouse.dart';
import 'package:homealone/model/homeinsertmodel.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/provider/address_provider.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'package:homealone/model/AmphureThailand.dart';
import 'package:homealone/model/Thailand.dart';
import 'dart:convert' show utf8;
import 'dart:async';

String args;


class EditHouse extends StatefulWidget {
  const EditHouse({Key key}) : super(key: key);

  @override
  _EditHouseState createState() => _EditHouseState();
}

class _EditHouseState extends State<EditHouse> {

  @override
  void initState() {
    // TODO: implement initState
    _Thailand();
    super.initState();

  }
  String dropdownValue1 = 'ประเภทบ้าน';
  String dropdownValue2 = '1';
  String dropdownValue3 = '1';
  String dropdownValue4 = '1';
  String dropdownValue5 = '1';

  List<Thailand> province_th =[];
  List<AmphureThailand> Amphurethai =[];

  _Thailand() async{
    var list = await ProvinceProvider.all();
    ProvinceDao province ;
    for(province in list){
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

  @override
  void didChangeDependencies()async {
    super.didChangeDependencies();
    print("didChangeDependencies");
   args =  ModalRoute.of(context).settings.arguments;
   await gethomeAll(args);
  }
  List<House> homeall;
  Future<House> gethomeAll(String id) async {
    final response = await http
        .get(Uri.http('homealone.comsciproject.com', '/searchhouse/'+id));
    setState(() {
      if (response.statusCode == 200) {
        print("homeall ready");
        homeall = houseFromJson(response.body);
      } else {
        throw Exception('Failed to load homedata');
      }
    });
  }

  var _ChoseValue;
  var _ChoseValueAmphureThailand;

  var h_Manager = TextEditingController();
  var house_Name = TextEditingController();
  var house_Add = TextEditingController();
  var house_Province;
  var house_District;
  var house_Zipcode = TextEditingController();
  var house_Type;
  var house_Floors;
  var house_Bedroom = '1';
  var house_Bathroom = '1';
  var house_Livingroom = '1';
  var house_Kitchen = '1';
  var house_Area = TextEditingController();
  var house_Latitude = TextEditingController();
  var house_Longitude = TextEditingController();
  var house_Electric = TextEditingController();
  var house_Water = TextEditingController();
  var house_Rent = TextEditingController();
  var house_Deposit = TextEditingController();
  var house_Insurance = TextEditingController();
  var house_Status = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget> [
                  SizedBox(height: 60),
/////////////////////////////////// ข้อมูลบ้านเช่า //////////////////////////////////
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ข้อมูลบ้านเช่า",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 97, 26, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),

                        ),

                        ////////// ชื่อบ้าน
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Name,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: homeall[0].houseName,
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  // keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// ที่อยู่บ้านเช่า
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Add,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: homeall[0].houseAdd,
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  // keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /////////////จังหวัด
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
                                        // print("Test:"+value);
                                        setState(() {
                                          _ChoseValue = value;
                                          int index = int.parse(_ChoseValue);
                                          house_Province = province_th[index-1].name;
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
                                          // house_District = value;

                                          for(int i = 0;i < Amphurethai.length;i++){
                                            if(Amphurethai[i].id == _ChoseValueAmphureThailand){
                                              print("Index"+Amphurethai[i].name);
                                              house_District = Amphurethai[i].name;
                                            }
                                          }



                                        });
                                      },

                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),
                        ),
                        //////// พื้นที่บ้านเช่า
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Area,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ขนาดพื้นที่ '+homeall[0].houseArea+' (ตร.ม)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// ตำแหน่งที่ตั้ง
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Container(
                                child :
                                new FlatButton (
                                  minWidth: 200.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(247, 207, 205, 1),
                                  onPressed: () {},
                                  child: Text(" ตำแหน่งที่ตั้ง ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(250, 120, 186, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit',
                                    ),),
                                  shape: StadiumBorder(
                                      side: BorderSide(width: 3.0,color: Color.fromRGBO(247, 207, 205, 1))
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


                  SizedBox(height: 60),

////////////////////////////////// ลักษณะบ้านเช่า //////////////////////////////////
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ลักษณะบ้าน",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 97, 26, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),

                        DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(Icons.arrow_circle_down,
                            color: Color.fromRGBO(250, 120, 186, 1),
                          ),
                          iconSize: 24,
                          iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                          elevation: 16,
                          style: const TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',

                          ),
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(250, 120, 186, 1),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue1 = newValue;
                              house_Type = newValue;
                            });
                          },
                          items: <String>['ประเภทบ้าน', 'บ้านเดี่ยว', 'บ้านแฝด']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ห้องนอน",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: dropdownValue2,
                              icon: const Icon(Icons.arrow_circle_down,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              iconSize: 24,

                              elevation: 16,
                              style: const TextStyle(
                                color:Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              underline: Container(
                                height: 2,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue2 = newValue;
                                  house_Bedroom = newValue;
                                });
                              },
                              items: <String>[ '1', '2', '3','4','5','6']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            SizedBox(width: 40,),
                            Text("ห้องน้ำ",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: dropdownValue3,
                              icon: const Icon(Icons.arrow_circle_down,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              underline: Container(
                                height: 2,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue3 = newValue;
                                  house_Bathroom = newValue;
                                });
                              },
                              items: <String>[ '1', '2', '3','4','5','6']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),


                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ห้องรับแขก",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: dropdownValue4,

                              icon: const Icon(Icons.arrow_circle_down,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                color:Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              underline: Container(
                                height: 2,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue4 = newValue;
                                  house_Livingroom = newValue;
                                });
                              },
                              items: <String>['1', '2', '3','4','5','6']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),

                            SizedBox(width: 40,),
                            Text("ห้องครัว",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: dropdownValue5,
                              icon: const Icon(Icons.arrow_circle_down,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                              underline: Container(
                                height: 2,
                                color: Color.fromRGBO(250, 120, 186, 1),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue5 = newValue;
                                  house_Kitchen = newValue;
                                });
                              },
                              items: <String>['1', '2', '3','4','5','6']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),


                          ],
                        ),

                      ],
                    ),
                  ),


                  SizedBox(height: 60),
///////////////////////////////// ข้อมูลค่าใช้จ่าย ///////////////////////////////////
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ข้อมูลค่าใช้จ่าย",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 97, 26, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),

                        ////////// ค่าเช่าบ้าน
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Rent,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ค่าเช่าบ้าน '+homeall[0].houseRent.toString()+'   (บาท / เดือน)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// ค่ามัดจำบ้าน
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Deposit,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ค่ามัดจำบ้าน '+homeall[0].houseDeposit.toString()+'  (บาท)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //////// ค่าประกันบ้าน
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Insurance,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ค่าประกันบ้าน  '+homeall[0].houseInsurance.toString()+'   (บาท)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// อัตราค่าน้ำ
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Water,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'อัตราค่าน้ำ  '+homeall[0].houseWater+'  (บาท / หน่วย)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //////// อัตราค่าไฟ
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
                                height: 80.0,
                                width: 300.0,
                                child: TextField(
                                  controller: house_Electric,
                                  style: TextStyle(
                                    color: Color.fromRGBO(250, 120, 186, 1),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kanit',
                                  ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'อัตราค่าไฟ '+homeall[0].houseElectric+' (บาท / หน่วย)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(250, 120, 186, 1)
                                      ),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                                      )
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),

                  SizedBox(height: 60),
///////////////////////////// รูปภาพบ้านเช่า /////////////////////////////////////////
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รูปภาพบ้านเช่า",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 97, 26, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(homeall[0].houseImage,width: 200,height: 200,),
                              // Icon(
                              //   Image.network(homeall[0].houseImage),
                              //   size: 200,
                              //   // Color.fromRGBO(247, 207, 205, 1),
                              //   color: Color.fromRGBO(250, 200, 210, 1),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),




                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child :
                        new FlatButton (
                          minWidth: 120.0,
                          height: 50.0,
                          color: Color.fromRGBO(247, 207, 205, 1),
                          onPressed: () async {
                            print("onPressed 1");
                          },
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ยืนยัน",
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 16  ,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(width: 1.0,color: Color.fromRGBO(250, 120, 186, 1),)
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child :
                        new FlatButton (
                          minWidth: 120.0,
                          height: 50.0,
                          // color: Color.fromRGBO(247, 207, 205, 1),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ยกเลิก",
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 16  ,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(width: 1.0,color: Color.fromRGBO(250, 120, 186, 1),)
                          ),
                        ),
                      ),
                    ],
                  ) ,


                ],

              ),
            ),
          ],
        ),


      ),
    );
  }
}
