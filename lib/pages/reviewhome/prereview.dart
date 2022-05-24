import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/review/PreReviewModel.dart';
import 'package:homealone/model/review/ReviewsModel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PreReview extends StatefulWidget {
  const PreReview({Key key}) : super(key: key);

  @override
  State<PreReview> createState() => _PreReviewState();
}

class _PreReviewState extends State<PreReview>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'ยังไม่ได้รีวิว'),
    Tab(text: 'ที่รีวิวไปแล้ว'),
  ];
  AppStyle _appStyle = new AppStyle();
  TabController _tabController;
  List<PreReviewModel> _reviewModel;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments;
    getReviewInfo();
  }


  Future<List<PreReviewModel>> getReviewInfo() async {
    var postUri = Uri.parse(
        "https://home-alone-csproject.herokuapp.com/review/pre-review-info");
    var request = http.MultipartRequest('POST', postUri)
      ..fields['tid'] = args.toString()
      ..fields['status'] = '1';

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    // request.send().then((response) {
    print(response.statusCode);
    if (response.statusCode == 200) {
      return _reviewModel =
          preReviewModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 4),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("เกิดข้อผิดพลาด:" + response.statusCode.toString())
          ],
        ),
      ));
      throw Exception('Failed to load');
    }
  }

  Future<List<ReviewsModel>> getReviewByTid() async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/review/review-tid/'+args.toString()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print("Body"+utf8.decode(response.bodyBytes));

      return reviewsModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load');
    }
  }
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

  Future<void> onRefresh () {
    setState(() {
      getReviewByTid();
      getReviewInfo();
    });
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
          centerTitle: true,
          title: Image.asset('img/logo.png'),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child:  FutureBuilder(
            future: getReviewInfo(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PreReviewModel>> snapshot) {
              if (snapshot.hasData) {
                return TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    SingleChildScrollView(
                        child: Container(
                          color: Color.fromRGBO(247, 207, 205, 1),
                          margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                          padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                          child: Column(
                              children: snapshot.data.map((e) {
                                return _getSlidableWithLists(e);
                              }).toList()),
                        )),

                    FutureBuilder(future: getReviewByTid(),builder: (BuildContext context,
                        AsyncSnapshot<List<ReviewsModel>> snapshot){
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                // width: mqWidth / 0.2,
                                // height: mqHeight / 3.5,
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
                                          Text(snapshot.data[index].reviewsText),
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
                        return Container();;
                    }),

                  ],
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }),)
       );
  }

  Widget _getSlidableWithLists(PreReviewModel e) => Builder(
        builder: (context) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/Homeinfo-page',
                      arguments: [ e.house.hid ]);
                },
                leading: Image.network(e.house.houseImage),
                title: Text(
                  e.house.houseName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.house.houseProvince == null
                                  ? ""
                                  : "จ." + e.house.houseProvince,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.house.houseDistrict == null
                                  ? ""
                                  : " อ." + e.house.houseDistrict,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kanit',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.house.houseType == null
                                ? ""
                                : e.house.houseType + " ",
                            style: TextStyle(
                              color: Color.fromRGBO(250, 120, 186, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Row(
                        //       children: <Widget>[
                        //         Icon(
                        //           Icons.king_bed,
                        //           color: Color.fromRGBO(250, 120, 186, 1),
                        //           size: 25,
                        //         ),
                        //         Text(
                        //           e.house.houseBedroom == null
                        //               ? " "
                        //               : e.house.houseBedroom.toString() + " ",
                        //           style: TextStyle(
                        //             color: Color.fromRGBO(250, 120, 186, 1),
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.bold,
                        //             fontFamily: 'Kanit',
                        //           ),
                        //         )
                        //       ],
                        //     )),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Row(
                        //       children: <Widget>[
                        //         Icon(
                        //           Icons.bathtub,
                        //           color: Color.fromRGBO(250, 120, 186, 1),
                        //           size: 20,
                        //         ),
                        //         Text(
                        //           e.house.houseBathroom == null
                        //               ? " "
                        //               : e.house.houseBathroom.toString() + " ",
                        //           style: TextStyle(
                        //             color: Color.fromRGBO(250, 120, 186, 1),
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.bold,
                        //             fontFamily: 'Kanit',
                        //           ),
                        //         )
                        //       ],
                        //     )),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     e.house.houseArea == null
                        //         ? ""
                        //         : e.house.houseArea + " ",
                        //     style: TextStyle(
                        //       color: Color.fromRGBO(250, 120, 186, 1),
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.bold,
                        //       fontFamily: 'Kanit',
                        //     ),
                        //   ),
                        // ),
                      ])
                    ],
                  )),
                ]),
                trailing: Text(
                  (e.house.houseStatus == 0)
                      ? 'ว่าง'
                      : (e.house.houseStatus == 1)
                          ? 'กำลังเช่า'
                          : (e.house.houseStatus == 2)
                              ? 'ติดจอง'
                              : 'ยกเลิก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (e.house.houseStatus == 0)
                        ? Colors.green
                        : (e.house.houseStatus == 1)
                            ? Colors.yellow[600]
                            : (e.house.houseStatus == 2)
                                ? Colors.orange
                                : Colors.red,
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('วันที่เข้าอยู่ dd MMMM yyyy','th').format(e.rentingHouse.rentingCheckIn)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Review-page',arguments: e);
                    },
                    child: const Text('เขียนรีวิว'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
