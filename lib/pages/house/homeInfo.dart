import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/model/house/HouseAndImageModel.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/review/ReviewsModel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final String imgList = "http://homealone.comsciproject.com/img/home.jpg";
final List<String> imgLists = [
  "http://homealone.comsciproject.com/img/home.jpg",
  "http://homealone.comsciproject.com/img/home.jpg",
  "http://homealone.comsciproject.com/img/home.jpg"
];

List<Widget> photoList(HouseAndImageModel img) {
  List<Widget> imageSliders;
  if (img.houseImageList.isNotEmpty && img.houseImageList != null) {
    imageSliders = img.houseImageList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item.imageHousePath,
                            fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  } else {
    imageSliders = imgLists
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }
  return imageSliders;
}

final List<String> message = <String>[
  "message1",
  "message2",
  "message3",
  "message4"
];
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
HouseAndImageModel homeall;
List<House> homedata;

class InfoPage extends StatefulWidget {
  InfoPage({key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<int> args;
  AppStyle _appStyle = new AppStyle();

  @override
  void initState() {
    super.initState();
    // gethomeAll();
    // args = ModalRoute.of(context).settings.arguments;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
    args = ModalRoute.of(context).settings.arguments;
    // print(args[0]);
  }

  Future<HouseAndImageModel> gethomeAll() async {
    print('getHouse');
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com',
        '/house/HouseAndImage/' + args[0].toString()));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(houseAndImageFromJson(utf8.decode(response.bodyBytes)));
      return homeall = houseAndImageFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  List<ReviewsModel> reviews;
  double avg = 0;
  int sum = 0;
  Future<List<ReviewsModel>> getReviewsByHid() async {
    print("review"+args[0].toString());
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com',
        '/review/AndImage/' + args[0].toString()));
    int i = 0;
    avg=0;
    sum = 0;
    print("review"+response.statusCode.toString());

    if (response.statusCode == 200) {
      reviews = reviewsModelFromJson(utf8.decode(response.bodyBytes));
      for(var score in reviews){
        sum = sum+score.reviewsScore;
        i++;
        print(sum);
      }
      avg = sum.toDouble() / i.toDouble();
      print(avg);
      return reviews;
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  Future<Manager> getManager(int mid) async {
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com', '/manager/id/' + mid.toString()));


    if (response.statusCode == 200) {
      return managerFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data');
    }
    // setState(() {});
  }
Tenant tenant;
  Future<Tenant> getTenant(int id) async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/tenant/id/' + id.toString()));
    if (response.statusCode == 200) {
      return  tenantFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load data');
    }
    // setState(() {});
  }
  bool checkSend = true;
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: NavAppBar(),
        resizeToAvoidBottomInset: false,
        body:  FutureBuilder(
            future: gethomeAll(),
            builder: (BuildContext context,
                AsyncSnapshot<HouseAndImageModel> snapshot) {
              print(snapshot.connectionState);
                if(snapshot.hasData){
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            child: Column(children: [
                              SizedBox(
                                height: 14,
                              ),
                              Expanded(
                                child: CarouselSlider(
                                  items: photoList(snapshot.data),
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      // autoPlay: true,
                                      enlargeCenterPage: true,
                                      aspectRatio: 2.0,
                                      onPageChanged: (index, reason) {
                                        // setState(() {
                                          _current = index;
                                        // }
                                        // );
                                      }),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imgLists.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                              .withOpacity(
                                              _current == entry.key ? 0.9 : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            // width: 350,
                              height: 250,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(snapshot.data.houseName,
                                        style: _appStyle.textStyleUrSize(22)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    snapshot.data.houseAddress != null
                                        ? new Text(
                                      snapshot.data.houseAddress,
                                      style: _appStyle.textStyle18(),
                                      overflow: TextOverflow.fade,
                                    )
                                        : Row(),
                                    new Text(
                                        snapshot.data.houseDistrict == null
                                            ? "" + " จ." + snapshot.data.houseProvince
                                            : " ${snapshot.data.houseDistrict}" +
                                            " จ." +
                                            snapshot.data.houseProvince,
                                        style: _appStyle.textStyle18(),
                                        overflow: TextOverflow.fade),
                                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              homeall.houseType == null
                                                  ? ""
                                                  : homeall.houseType + " ",
                                              style: TextStyle(
                                                color:
                                                Color.fromRGBO(250, 120, 186, 1),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Kanit',
                                              ),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: homeall.houseBedroom == null
                                                  ? Row()
                                                  : Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.king_bed,
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                    size: 25,
                                                  ),
                                                  Text(
                                                    homeall.houseBedroom == null
                                                        ? " "
                                                        : homeall.houseBedroom
                                                        .toString() +
                                                        " ห้องนอน ",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: homeall.houseBathroom == null
                                                  ? Row()
                                                  : Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.bathtub,
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    homeall.houseBathroom ==
                                                        null
                                                        ? " "
                                                        : homeall.houseBathroom
                                                        .toString() +
                                                        " ห้องน้ำ ",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ]),
                                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: homeall.houseKitchen == null
                                                  ? Row()
                                                  : Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.kitchen,
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    homeall.houseKitchen == null
                                                        ? " "
                                                        : homeall.houseKitchen
                                                        .toString() +
                                                        " ห้องครัว ",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: homeall.houseLivingroom == null
                                                  ? Row()
                                                  : Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.bathtub,
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    homeall.houseLivingroom ==
                                                        null
                                                        ? " "
                                                        : homeall
                                                        .houseLivingroom
                                                        .toString() +
                                                        " ห้องรับแขก ",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily: 'Kanit',
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                homeall.houseArea == null
                                                    ? " "
                                                    : homeall.houseArea + " ",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      250, 120, 186, 1),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanit',
                                                ),
                                                overflow: TextOverflow.fade),
                                          ),
                                        ]),
                                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              homeall.houseElectric == null
                                                  ? ""
                                                  : " อัตราค่าไฟฟ้า " +
                                                  homeall.houseElectric +
                                                  " ",
                                              style: TextStyle(
                                                color:
                                                Color.fromRGBO(250, 120, 186, 1),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Kanit',
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              homeall.houseWater == null
                                                  ? ""
                                                  : " อัตราค่าน้ำ " +
                                                  homeall.houseWater +
                                                  " ",
                                              style: TextStyle(
                                                color:
                                                Color.fromRGBO(250, 120, 186, 1),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Kanit',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        snapshot.data.houseInsurance == null
                                            ? Row()
                                            : Text(
                                            " ค่าประกัน " +
                                                snapshot.data.houseInsurance
                                                    .toString() +
                                                " บาท",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Kanit',
                                            ),
                                            overflow: TextOverflow.fade),
                                        snapshot.data.houseInsurance == null
                                            ? Row()
                                            : Text(
                                            " ค่าประกัน " +
                                                snapshot.data.houseInsurance
                                                    .toString() +
                                                " บาท",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  250, 120, 186, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Kanit',
                                            ),
                                            overflow: TextOverflow.fade)
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            " ค่าเช่า " +
                                                snapshot.data.houseRent.toString() +
                                                " บาท/เดือน",
                                            style: TextStyle(
                                              color: Color.fromRGBO(250, 120, 186, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Kanit',
                                            ),
                                            overflow: TextOverflow.fade),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              width: mqWidth / 0.2,
                              height: 50,
                              child: Center(
                                  child: Text(
                                    "ผู้จัดการ",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ))),
                          SizedBox(
                            height: 4,
                          ),
                          showManager(context, snapshot.data.mid),
                          Container(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              width: mqWidth / 0.2,
                              height: 50,
                              child:  Center(
                                  child:Text(
                                    "รีวิว",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ))
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          showReview(context),
                          (snapshot.data.houseStatus == 0)
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: status == 1
                                    ? new FlatButton(
                                  minWidth: 100.0,
                                  height: 40.0,
                                  onPressed: () => showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('ยืนยัน'),
                                          content: Text('ยืนยันการจองบ้าน ' +
                                              snapshot.data.houseName),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('ยกเลิก'),
                                            ),
                                             TextButton(
                                                 onPressed: () async {
                                            if(checkSend){
                                                checkSend = false;
                                                // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                Map<String, String> data = {
                                                  'hid': snapshot.data.hid
                                                      .toString(),
                                                  'tid': id.toString()
                                                };
                                                var body = json.encode(data);

                                                var response = await http.post(
                                                    Uri.parse(
                                                        'https://home-alone-csproject.herokuapp.com/house/rent'),
                                                    body: body,
                                                    headers: {
                                                      'Content-Type':
                                                      'application/json'
                                                    });
                                                if (response.statusCode ==
                                                    200) {
                                                  setState(() {gethomeAll().whenComplete(() {
                                                        checkSend = true;
                                                        Navigator.pop(context, 'ยืนยัน');
                                                    });
                                                  });
                                                  // Navigator.pushNamed(context, '/main-page');
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                      new SnackBar(
                                                        duration: new Duration(
                                                            seconds: 4),
                                                        content: new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("เกิดข้อผิดพลาด")
                                                          ],
                                                        ),
                                                      ));
                                                  checkSend = true;
                                                }
                                            }else print('กำลังโหลด');
                                              },
                                              child: const Text('ยืนยัน') ,
                                            )
                                          ],
                                        ),
                                  ),
                                  child: Text(
                                    "จองเลย",
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                          250, 120, 186, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      color: Color.fromRGBO(
                                          250, 120, 186, 1),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ),
                            ],
                          )
                              : Container()
                        ],
                      ));
              }else return LinearProgressIndicator();

            })  );

    // InfoBody(context));
  }

  Widget showManager(BuildContext context, int mid) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getManager(mid),
        builder: (BuildContext  context, AsyncSnapshot<Manager> snapshot) {
          if (snapshot.hasData) {
            return Container(
                width: mqWidth / 0.2,
                height: mqHeight / 3.5,
                child: Card(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        snapshot.data.managerFirstname +
                            " " +
                            snapshot.data.managerLastname,
                        style: _appStyle.textStyleUrSize(22)),
                    snapshot.data.managerLineid == null
                        ? Row()
                        : Text("Line ID:" + snapshot.data.managerLineid,
                            style: _appStyle.textStyleUrSize(16)),
                    snapshot.data.managerFacebook == null
                        ? Row()
                        : Text("Facebook:" + snapshot.data.managerFacebook,
                            style: _appStyle.textStyleUrSize(16)),
                    snapshot.data.managerPhone == null
                        ? Row()
                        : Text("เบอร์โทร:" + snapshot.data.managerPhone,
                            style: _appStyle.textStyleUrSize(16)),
                    SizedBox(
                      height: 5,
                    ),
                    snapshot.data.managerOffice == null
                        ? Row()
                        : Text("ที่อยู่สำนักงาน ",
                            style: _appStyle.textStyleUrSize(18)),
                    snapshot.data.managerOffice == null
                        ? Row()
                        : Text(snapshot.data.managerOffice,
                            style: _appStyle.textStyleUrSize(16))
                  ],
                )));
          } else
            return LinearProgressIndicator();
        });
  }
  Widget showReview(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getReviewsByHid(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ReviewsModel>> snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Column(
                          children: [
                            (avg.isNaN)?Row(): Text(avg.toString()+" คะแนน จาก "+snapshot.data.length.toString()+" รีวิว",style: _appStyle.textStyle18(),),
                            Container(
                              width: mqWidth / 0.2,
                              height: mqHeight / 3.5,
                              child:ListView.builder(
                                primary: false,
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(247, 207, 205, 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            new FutureBuilder(future:getTenant(snapshot.data[index].tid),
                                                builder: (BuildContext context, AsyncSnapshot<Tenant> item){
                                              if(item.hasData){
                                                return Row(children: [ CircleAvatar(
                                                backgroundImage:NetworkImage(item.data.tenantImage),
                                                  radius: 15.0,
                                                  backgroundColor: Color.fromRGBO(247, 207, 205, 1),

                                                  ),SizedBox(width: 5),Text(item.data.tenantUsername,style: _appStyle.textStyleUrSize(15),)],);
                                              }else return Text('กำลังโหลด...');
                                                })
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              RatingBar.builder(
                                                itemSize: 25,
                                                initialRating: snapshot
                                                    .data[index].reviewsScore
                                                    .toDouble(),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                // allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Color.fromRGBO(
                                                      250, 120, 186, 1),
                                                ),
                                                // onRatingUpdate: (rating) {
                                                //   print(rating);
                                                // },
                                              ),
                                              SizedBox(width: 50),
                                            ],
                                          ),
                                        ),
                                        (snapshot.data[index].reviewsText)==null? Row():Text(snapshot.data[index].reviewsText),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
            );
          } else
            return Container();
        });
  }
}
