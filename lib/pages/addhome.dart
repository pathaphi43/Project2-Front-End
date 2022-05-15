

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homealone/model/homeinsertmodel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
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

import 'package:map_pin_picker/map_pin_picker.dart';

class AddHome extends StatefulWidget {
  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  int index = 0;
  String dropdownValue1 = 'ประเภทบ้าน';
  String dropdownValue2 = '1';
  String dropdownValue3 = '1';
  String dropdownValue4 = '1';
  String dropdownValue5 = '1';

  var h_Manager = TextEditingController();
  var house_Name = TextEditingController();
  var house_Add = TextEditingController();
  var house_Province;
  var house_District;
  var house_Zipcode = TextEditingController();
  var house_Type = 'ประเภทบ้าน';
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
  bool selected = false;

  var textController = TextEditingController();

  var mapDetails;


  // PickResult selectedPlace;
  LatLng currentLatLng;
  Completer<GoogleMapController> _controller = Completer();
  // final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  int args;
  CameraPosition cameraPosition;
  @override
  void initState() {
    super.initState();

    // _getUserLocation();
    // _determinePosition();
     Geolocator.getCurrentPosition().then((currLocation){
      setState((){
        currentLatLng = new LatLng(currLocation.latitude, currLocation.longitude);
        // print( "Lat: "+currLocation.latitude.toString() +"Lng:"+currentLatLng.longitude.toString() );
        cameraPosition  =  CameraPosition(
          target: LatLng(currLocation.latitude, currentLatLng.longitude),
          zoom: 14.4746,
        );
        _Thailand();
        args = ModalRoute.of(context).settings.arguments;
      });
    });
  }




  var _ChoseValue;
  var _ChoseValueAmphureThailand;

  List<Thailand> province_th = [];
  List<AmphureThailand> Amphurethai = [];

  _Thailand() async {
    province_th.clear();
    var list = await ProvinceProvider.all();
    ProvinceDao province;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      cameraPosition.target.latitude,
      cameraPosition.target.longitude,
    );
    String nemeTh = placemarks.first.administrativeArea.trim();
    for (province in list) {
      if(province.nameTh == nemeTh){
        _ChoseValue = province.id.toString();
        house_Province = province.nameTh;
        _Amphure(_ChoseValue);
        _ChoseValueAmphureThailand = null;
      }
      province_th.add(new Thailand(
        name: province.nameTh.toString(),
        id: province.id.toString(),
      ));
    }
    setState(() {});
  }

  _Amphure(value) async {
    // AmphureDao amphure ;
    var list = await AmphureProvider.all(provinceId: int.parse(value));
    Amphurethai.clear();
    for (AmphureDao amphure in list) {
      if (amphure.nameTh[0] != "*" && amphure.nameTh[amphure.nameTh.length-1] != "*") {
        Amphurethai.add(new AmphureThailand(
          name: amphure.nameTh.toString(),
          id: amphure.id.toString(),
        ));
      }
      // print(amphure.nameTh);
    }

    setState(() {});
    // print(Amphuree);
  }



  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: NavAppBar(),
        body: _mapOpen(context, 300, true),

      ),
    ));
  }
  bool _validateHouseName = false;
  bool _validateHouseRent = false;
  Widget _mapOpen(BuildContext context,double height,bool buttonBool){
  return Scaffold(
    // height: buttonBool ? MediaQuery.of(context).size.height*0.85 :height,
    body:  cameraPosition == null ? Center(child:CircularProgressIndicator()) : Stack(
      alignment: Alignment.topCenter,
      children: [
        MapPicker(
          // pass icon widget
          iconWidget: Icon(Icons.location_on_outlined,size: 20) ,
          //add map picker controller
          mapPickerController: mapPickerController,
          child: GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            // hide location button
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            //  camera position
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // onCameraMoveStarted: () {
            //   // notify map is moving
            //   mapPickerController.mapMoving();
            //   textController.text = "checking ...";
            // },
            onCameraMove: (cameraPosition) {
              this.cameraPosition = cameraPosition;
            },
            onCameraIdle: () async {
              // notify map stopped moving
              mapPickerController.mapFinishedMoving();
              //get address name from camera position
              List<Placemark> placemarks = await placemarkFromCoordinates(
                cameraPosition.target.latitude,
                cameraPosition.target.longitude,
              );
              // update the ui with the address
             textController.text =
              '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).viewPadding.top,
          width: MediaQuery.of(context).size.width - 50,
          height: 50,
          child: TextFormField(
            maxLines: 3,
            textAlign: TextAlign.center,
            readOnly: true,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero, border: InputBorder.none),
            controller: textController,
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: SizedBox(
            height: 50,
            child: TextButton(
              child: const Text(
                "ยืนยัน",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFFFFFFF),
                  fontSize: 19,
                  // height: 19/19,
                ),
              ),
              onPressed: ()  {
                // print(
                //     "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                // print("Address: ${textController.text}");
                //  mapDetails = textController.text.split(",");
                // print(mapDetails[1].toString().trim());
                _Thailand();
              // await  province_th.map((e) {
              //     print(e.name.isEmpty);
              //     if(e.name == mapDetails[1].toString().trim()){
              //       setState(() {
              //         _ChoseValue = e.id.toString();
              //         _Amphure(_ChoseValue);
              //         _ChoseValueAmphureThailand = null;
              //       });
              //
              //     }
              //   });
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFA3080C)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),) ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget>[
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
                        InkWell( onTap:() {
                          print("Ontap Map");
                          _gotoDetailsPage(context);
                        },
                          child: Center(
                            child: Hero(tag: 'hero-rectangle', child:
                                Container(
                                  height: 100,
                                  child:  cameraPosition == null ? Center(child:CircularProgressIndicator()) : Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    MapPicker(
                                      // pass icon widget
                                      iconWidget: Icon(Icons.location_on_outlined,size: 20) ,
                                      //add map picker controller
                                      mapPickerController: mapPickerController,
                                      child: GoogleMap(
                                        buildingsEnabled: false,
                                        myLocationEnabled: false,
                                        zoomControlsEnabled: false,
                                        // hide location button
                                        myLocationButtonEnabled: false,
                                        mapType: MapType.normal,
                                        initialCameraPosition: cameraPosition,
                                        // onMapCreated: (GoogleMapController controller) {
                                        //   _controller.complete(controller);
                                        // },
                                      ),
                                    ),
                                     Positioned(
                                      // top: MediaQuery.of(context).viewPadding.top + 20,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: TextFormField(
                                        onTap: () {
                                          print("On tap map");
                                        } ,
                                        readOnly: true,enabled: false,
                                      ),
                                    )

                                  ],
                                ), )

                            )
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
                                      labelText: 'ชื่อบ้านเช่า',
                                    errorText: _validateHouseName ? 'กรุณากรอกชื่อบ้าน' : null,
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                      labelText: 'ที่อยู่บ้านเช่า',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                  new Text(
                                    'จังหวัด',
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
                                            color: Color.fromRGBO(
                                                250, 120, 186, 1),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // value: dropdownValue1,
                                      items: province_th.map((item) {
                                        return DropdownMenuItem<String>(
                                          value:  item.id,
                                          child: Text(item.name,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      250, 120, 186, 1),
                                                  fontSize: 18)),

                                          // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                        );
                                      })?.toList(),
                                      onChanged: (value) {
                                        // print("Test:"+value);
                                        setState(() {
                                          _ChoseValue = value;
                                          int index = int.parse(_ChoseValue);
                                          house_Province = province_th[index - 1].name;
                                          _Amphure(_ChoseValue);
                                          _ChoseValueAmphureThailand = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    'อำเภอ',
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
                                            color: Color.fromRGBO(
                                                250, 120, 186, 1),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // value: dropdownValue1,

                                      items: Amphurethai.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item.id,
                                          child: Text(item.name,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      250, 120, 186, 1),
                                                  fontSize: 18)),

                                          // ,style:TextStyle(color:Colors.black,fontSize: 20),),
                                        );
                                      })?.toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _ChoseValueAmphureThailand = value;
                                          // house_District = value;
                                          for (int i = 0;
                                              i < Amphurethai.length;
                                              i++) {
                                            if (Amphurethai[i].id ==
                                                _ChoseValueAmphureThailand) {
                                              // print("Index"+Amphurethai[i].name[0]);
                                              house_District =
                                                  Amphurethai[i].name;
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
                                      labelText: 'ขนาดพื้นที่  (ตร.ม)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///////// ตำแหน่งที่ตั้ง
                        // Center(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       new Container(
                        //         child :
                        //         new FlatButton (
                        //           minWidth: 200.0,
                        //           height: 50.0,
                        //           color: Color.fromRGBO(247, 207, 205, 1),
                        //           onPressed: () {},
                        //           child: Text(" ตำแหน่งที่ตั้ง ",
                        //             style: TextStyle(
                        //               color: Color.fromRGBO(250, 120, 186, 1),
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.bold,
                        //               fontFamily: 'Kanit',
                        //             ),),
                        //           shape: StadiumBorder(
                        //               side: BorderSide(width: 3.0,color: Color.fromRGBO(247, 207, 205, 1))
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           RaisedButton(
//                             onPressed: () async {
//                               LocationResult result = await showLocationPicker(
//                                 context,
//                                 apiKey,
//                                 initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                                 myLocationButtonEnabled: true,
//                                 // requiredGPS: true,
//                                 layersButtonEnabled: true,
//                                 // countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                                 desiredAccuracy: LocationAccuracy.best,
//                               );
//                               print("result = $result");
//                               setState(() => _pickedLocation = result);
//                             },
//                             child: Text('Pick location'),
//                           ),
//                           Text(_pickedLocation.toString()),
//                         ],
//                       ),
//                     ),
                      ],
                    ),
                  ),

                  SizedBox(height: 60),

////////////////////////////////// ลักษณะบ้านเช่า //////////////////////////////////
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ลักษณะบ้าน",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 97, 26, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(
                            Icons.arrow_circle_down,
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
                            Text(
                              "ห้องนอน",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue2,
                              icon: const Icon(
                                Icons.arrow_circle_down,
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
                                  dropdownValue2 = newValue;
                                  house_Bedroom = newValue;
                                });
                              },
                              items: <String>[
                                '0',
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "ห้องน้ำ",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue3,
                              icon: const Icon(
                                Icons.arrow_circle_down,
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
                              items: <String>[
                                '0',
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                            Text(
                              "ห้องรับแขก",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue4,
                              icon: const Icon(
                                Icons.arrow_circle_down,
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
                                  dropdownValue4 = newValue;
                                  house_Livingroom = newValue;
                                });
                              },
                              items: <String>[
                                '0',
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "ห้องครัว",
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue5,
                              icon: const Icon(
                                Icons.arrow_circle_down,
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
                              items: <String>[
                                '0',
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                      labelText: 'ค่าเช่าบ้าน    (บาท / เดือน)',
                                      errorText: _validateHouseRent ? 'กรุณากรอกค่าเช่าบ้าน' : null,
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                      labelText: 'ค่ามัดจำบ้าน   (บาท)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                      labelText: 'ค่าประกันบ้าน     (บาท)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                      labelText: 'อัตราค่าน้ำ    (บาท / หน่วย)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
                                      labelText: 'อัตราค่าไฟ  (บาท / หน่วย)',
                                      labelStyle: new TextStyle(
                                          color: const Color.fromRGBO(
                                              250, 120, 186, 1)),
                                      // hintText: 'Enter valid mail id as abc@gmail.com'
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1)))),
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
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "รูปภาพบ้านเช่า",
//                           style: TextStyle(
//                             color: Color.fromRGBO(2, 97, 26, 1),
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Kanit',
//                           ),
//                         ),
//                         Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.add_photo_alternate,
//                                 size: 200,
//                                 // Color.fromRGBO(247, 207, 205, 1),
//                                 color: Color.fromRGBO(250, 200, 210, 1),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: new FlatButton(
                          minWidth: 120.0,
                          height: 50.0,
                          color: Color.fromRGBO(247, 207, 205, 1),
                          onPressed: () async {
                            setState(() {
                              house_Name.text.isEmpty ? _validateHouseName = true : _validateHouseName = false;
                              house_Rent.text.isEmpty ? _validateHouseRent = true : _validateHouseRent = false;
                            });
                            var housedata = Inserthouse();

                            housedata.hManager = args;
                            housedata.houseName = house_Name.text;
                            housedata.houseAdd = house_Add.text;
                            housedata.houseProvince = house_Province;
                            housedata.houseDistrict = house_District;
                            // housedata.houseZipcode = house_Zipcode.text;
                            housedata.houseType = house_Type;
                            // housedata.houseFloors = int.parse(house_Floors);
                            housedata.houseBedroom = house_Bedroom == null ? 1 : int.parse(house_Bedroom);
                            housedata.houseBathroom = house_Bathroom == null ? 1 : int.parse(house_Bathroom);
                            housedata.houseLivingroom = house_Livingroom == null ? 1 : int.parse(house_Livingroom);
                            housedata.houseKitchen = house_Kitchen == null ? 1 : int.parse(house_Kitchen);
                            housedata.houseArea = house_Area.text.isEmpty ?  null: house_Area.text + " ตร.ม";
                            housedata.houseLatitude = cameraPosition.target.latitude.toString();
                            housedata.houseLongitude = cameraPosition.target.longitude.toString();
                            housedata.houseElectric = house_Electric.text.isEmpty ? null : house_Electric.text;
                            housedata.houseWater = house_Water.text.isEmpty ? null : house_Water.text;
                            housedata.houseRent = house_Rent.text.isEmpty ? null : int.parse(house_Rent.text);
                            print(house_Deposit.text.isEmpty);
                            housedata.houseDeposit = house_Deposit.text.isEmpty ? null : int.parse(house_Deposit.text);
                            housedata.houseInsurance = house_Insurance.text.isEmpty ? null : int.parse(house_Insurance.text);
                            // housedata.houseStatus = int.parse(args[1]);

                            print('ADDHOMEReq=' + housedata.toString());
                            var Jsonhousedata = await inserthouseToJson(housedata);
                            print(Jsonhousedata.toString());
                            if(house_Name.text.isNotEmpty && house_Rent.text.isNotEmpty ){
                              var response = await http.post(
                                  Uri.parse(
                                      'https://home-alone-csproject.herokuapp.com/house/insert'),
                                  body: Jsonhousedata,
                                  headers: {
                                    'Content-Type': 'application/json',
                                  });
                              print(response.body);
                              //
                              if (response.statusCode.toString() == '200') {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เพิ่มบ้านเช่าสำเร็จ')));
                                setState(() {});
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('เพิ่มบ้านเช่าไม่สำเร็จ')));
                              }
                            }



                          },
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ยืนยัน",
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(250, 120, 186, 1),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: new FlatButton(
                          minWidth: 120.0,
                          height: 50.0,
                          // color: Color.fromRGBO(247, 207, 205, 1),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ยกเลิก",
                                style: TextStyle(
                                  color: Color.fromRGBO(250, 120, 186, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(250, 120, 186, 1),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
