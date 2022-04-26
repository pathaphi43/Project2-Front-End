import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/model/house/HouseAndImageModel.dart';
import 'package:homealone/model/house/ReviewsModel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

final String imgList = "http://homealone.comsciproject.com/img/home.jpg";
final List<String> imgLists = ["http://homealone.comsciproject.com/img/home.jpg","http://homealone.comsciproject.com/img/home.jpg","http://homealone.comsciproject.com/img/home.jpg"];

List<Widget> photoList(HouseAndImageModel img){
  List<Widget> imageSliders;
  if(img.houseImageList.isNotEmpty && img.houseImageList != null) {
      imageSliders = img.houseImageList
      .map((item) =>  Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item.imageHousePath, fit: BoxFit.cover, width: 1000.0),
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
                    'No. ${item.hid} image',
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
  )).toList();

  }else {
    imageSliders = imgLists
        .map((item) =>  Container(
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
                      'No.  image',
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
    )).toList();

  }
  return   imageSliders;

}



final List<String> message = <String>[
  "message1",
  "message2",
  "message3",
  "message4"
];

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
    print(args[0]);
  }

  Future<HouseAndImageModel> gethomeAll() async {
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com',
        '/house/HouseAndImage/' + args[0].toString()));
    if (response.statusCode == 200) {
      print(houseAndImageFromJson(utf8.decode(response.bodyBytes)));
      return homeall =  houseAndImageFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }
  List<ReviewsModel> reviews;
  Future<List<ReviewsModel>> getReviewsByHid() async {
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com',
        '/review/AndImage/' + args[0].toString()));
    if (response.statusCode == 200) {
      return reviews =  reviewsModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: NavAppBar(),
        body: FutureBuilder(
            future: gethomeAll(),
            builder: (BuildContext context,
                AsyncSnapshot<HouseAndImageModel> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                return SingleChildScrollView(
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
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
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
                        width: 350,
                        height: 150,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Text(snapshot.data.houseName),
                              new Text(snapshot.data.houseType),
                              new Text("อ." +
                                  snapshot.data.houseDistrict +
                                  " จ." +
                                  snapshot.data.houseProvince),
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
                          "Review",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))),
                    SizedBox(
                      height: 4,
                    ),
                    showReview(context)
                  ],
                ));
              } else
                return LinearProgressIndicator();
            }));

    // InfoBody(context));
  }

  // Widget InfoBody(BuildContext context) {
  //
  //
  //   return
  // }

  Widget showReview(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getReviewsByHid(),
    builder: (BuildContext context,
    AsyncSnapshot<List<ReviewsModel>> snapshot) {
          if(snapshot.hasData){
            return Container(
                width: mqWidth / 0.2,
                height: mqHeight / 3.5,
                child: Card(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              margin: EdgeInsets.symmetric(vertical: 1),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(247, 207, 205, 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, color: Colors.grey),
                                      Text(snapshot.data[index].tid.toString())
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          itemSize: 25,
                                          initialRating: snapshot.data[index].reviewsScore,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          // allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Color.fromRGBO(250, 120, 186, 1),
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
                ));
          }else return LinearProgressIndicator();
    });
  }
}
