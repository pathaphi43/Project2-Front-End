import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homealone/model/house/HouseAndImageModel.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

List<HouseAndImageModel> homeall;
List<House> homedata;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  TextStyle _textStyle() {
    TextStyle(
      color: Color.fromRGBO(250, 120, 186, 1),
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kanit',
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  @override
  void didChangeDependencies() async{
    await gethomeAll();
    super.didChangeDependencies();

  }

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _blueFont = const TextStyle(color: Colors.blueAccent);


   Stream<List<HouseAndImageModel>> bids = (() {
     StreamController<List<HouseAndImageModel>> controller = new StreamController<List<HouseAndImageModel>>.broadcast();
    controller = StreamController<List<HouseAndImageModel>>(
      onListen: () async {
        final response = await http.get(
            Uri.http('home-alone-csproject.herokuapp.com', '/house/AllAndImageAndStatus'));
        if (response.statusCode == 200) {
          homeall = houseAndImageModelFromJson(utf8.decode(response.bodyBytes));
          controller.sink.add(homeall);
          // await controller.close();
        } else {
          throw Exception('Failed to load homedata');
        }
      },
    );
    return controller.stream;
  })();



  Stream<List<HouseAndImageModel>> onCurrentUserChanged;
  final StreamController<List<HouseAndImageModel>> currentUserStreamCtrl = StreamController<List<HouseAndImageModel>>();


  Future<void> onRefresh () {
    setState(() {
       gethomeAll();
    });
  return Future.delayed(Duration(seconds: 1));
  }

  Future<List<HouseAndImageModel>> gethomeAll() async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/house/AllAndImageAndStatus'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      currentUserStreamCtrl.sink.add(houseAndImageModelFromJson(utf8.decode(response.bodyBytes)));
      return homeall =
          houseAndImageModelFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: onRefresh,
        child:  StreamBuilder(
          stream: currentUserStreamCtrl.stream,
          // initialData: homeall,
          builder: (BuildContext context,
              AsyncSnapshot<List<HouseAndImageModel>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return SingleChildScrollView(
                    child: Container(
                      color: Color.fromRGBO(247, 207, 205, 1),
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
                      child: Column(
                        children: <Widget>[
                          (snapshot.connectionState == ConnectionState.active)
                              ? Column(
                                  children: snapshot.data.map((e) {
                                    return InkWell(onTap: () {
                                      Navigator.pushNamed(context, '/Homeinfo-page',
                                          arguments: [ e.hid ]);
                                    }, child: new Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        elevation: 5,
                                        semanticContainer: true,
                                        clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                        margin: const EdgeInsets.all(5.0),
                                        // การเยื้องขอบ
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Container(
                                                  child: (e.houseImageList
                                                      .isNotEmpty &&
                                                      e.houseImageList !=
                                                          null)
                                                      ? CarouselSlider(
                                                      options:
                                                      CarouselOptions(
                                                        height: 250,
                                                        aspectRatio: 16 / 9,
                                                        viewportFraction:
                                                        0.8,
                                                        initialPage: 0,
                                                        enableInfiniteScroll:
                                                        true,
                                                        reverse: false,
                                                        // autoPlay: true,
                                                        // autoPlayInterval: Duration(seconds: 3),
                                                        // autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                        // autoPlayCurve: Curves.fastOutSlowIn,
                                                        enlargeCenterPage:
                                                        true,
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                      ),
                                                      items:
                                                      e.houseImageList
                                                          .map((img) =>
                                                          Container(
                                                            // width: 400,
                                                            margin: EdgeInsets.symmetric(
                                                                horizontal:
                                                                0.0,
                                                                vertical:
                                                                0.1),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                5.0,
                                                                vertical:
                                                                0.15),
                                                            decoration: BoxDecoration(
                                                                image:
                                                                DecorationImage(image: NetworkImage(img.imageHousePath), fit: BoxFit.cover),
                                                                borderRadius: BorderRadius.circular(5)),
                                                            // Center(
                                                            //     child: Image.network(img.imageHousePath, fit: BoxFit.fill,width: 400,)
                                                            //     ),
                                                          ))
                                                          .toList())
                                                      : Container(
                                                    width: 400,
                                                    height: 250,
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        0.0,
                                                        vertical:
                                                        0.1),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        5.0,
                                                        vertical:
                                                        0.15),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(e
                                                                .houseImage),
                                                            fit: BoxFit
                                                                .fill),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    // Center(
                                                    //     child: Image.network(img.imageHousePath, fit: BoxFit.fill,width: 400,)
                                                    //     ),
                                                  )),
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(e.houseName,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              250, 120, 186, 1),
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: Color.fromRGBO(
                                                              250, 120, 186, 1),
                                                          size: 12.0,
                                                        ),
                                                        Text(
                                                            " " +
                                                                e.houseDistrict +
                                                                " จ." +
                                                                e.houseProvince,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  250,
                                                                  120,
                                                                  186,
                                                                  1),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontFamily:
                                                              'Kanit',
                                                            )),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            e.houseType == null
                                                                ? ""
                                                                : e.houseType,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  250,
                                                                  120,
                                                                  186,
                                                                  1),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontFamily:
                                                              'Kanit',
                                                            )),
                                                        Icon(
                                                          Icons
                                                              .king_bed_outlined,
                                                          color: Color.fromRGBO(
                                                              250, 120, 186, 1),
                                                          size: 12.0,
                                                        ),
                                                        Text(
                                                            e.houseBedroom ==
                                                                null
                                                                ? " "
                                                                : e.houseBedroom
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  250,
                                                                  120,
                                                                  186,
                                                                  1),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontFamily:
                                                              'Kanit',
                                                            )),
                                                        Icon(
                                                          Icons
                                                              .bathtub_outlined,
                                                          color: Color.fromRGBO(
                                                              250, 120, 186, 1),
                                                          size: 12.0,
                                                        ),
                                                        Text(
                                                            e.houseBathroom ==
                                                                null
                                                                ? " "
                                                                : e.houseBathroom
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  250,
                                                                  120,
                                                                  186,
                                                                  1),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontFamily:
                                                              'Kanit',
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            (e.houseStatus == 0) ? 'ว่าง'
                                                                : (e.houseStatus == 1) ? 'กำลังเช่า'
                                                                : (e.houseStatus == 2) ? 'ติดจอง'
                                                                : 'ยกเลิก',
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 16,
                                                              color: (e.houseStatus == 0)
                                                                  ? Colors.green
                                                                  : (e.houseStatus == 1)
                                                                  ? Colors.yellow[600]
                                                                  : (e.houseStatus == 2)
                                                                  ? Colors.orange
                                                                  : Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Row(children: [
                                                    Text(
                                                        e.houseRent == null
                                                            ? " "
                                                            : e.houseRent
                                                            .toString() +
                                                            "/เดือน",
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              250, 120, 186, 1),
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Kanit',
                                                        )),
                                                  ]),
                                                )
                                              ],
                                            )
                                          ],
                                        )),);
                                  }).toList(),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  );

            } else
              return Center(child:CircularProgressIndicator(),);

            // else if (snapshot.hasError) {
            //   children = <Widget>[
            //     const Icon(
            //       Icons.error_outline,
            //       color: Colors.red,
            //       size: 60,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 16),
            //       child: Text('Error: ${snapshot.error}'),
            //     )
            //   ];
            // }
            // else {
            //   children = const <Widget>[LinearProgressIndicator()];
            // }

            // return Scaffold(
            //   // resizeToAvoidBottomInset: false,
            //   body: SingleChildScrollView(
            //     child: Container(
            //       color: Color.fromRGBO(247, 207, 205, 1),
            //       margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: children,
            //       ),
            //     ),
            //   ),
            // );
          }),
    ));
  }
}

// Old Code
// Container(
// color: Color.fromRGBO(247, 207, 205, 1),
// margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
// padding:
// EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
// // height: MediaQuery.of(context).size.height * 0.25,
// child: Column(
// children: <Widget>[
// (homeall != null)
// ? Column(
// children: homeall.map((homeall) {
// return Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0)),
// elevation: 5,
// margin: EdgeInsets.all(10),
// semanticContainer: true,
// clipBehavior: Clip.antiAliasWithSaveLayer,
// child: Column(children: <Widget>[
// Row(
// children: <Widget>[
// CarouselSlider(
// options: CarouselOptions(),
// items: homeall.houseImageList
//     .map((item) => Container(
// child: Center(
// child: Image.network(
// item.imageHousePath,
// fit: BoxFit.cover,
// width: 1000)),
// ))
//     .toList(),
// )
// ],
// )
// ]),
// );

//     child:
//     ListTile(
//       leading:FittedBox(
//         fit: BoxFit.fill,child: Image.network(homeall.houseImage),alignment: Alignment.center, ) ,
//       title: Text(homeall.houseName,style: TextStyle(fontWeight: FontWeight.bold),),
//       subtitle: Row(
//         children: <Widget>[
//           Expanded(
//               child: Column(
//                 children: <Widget>[
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child:Text(homeall.houseAddress== null ?"" :homeall.houseAddress,style: TextStyle(
//                         color: Color.fromRGBO(250, 120, 186, 1),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Kanit',
//                       ),),),
//                           Row(children: <Widget>[
//                             Align(alignment: Alignment.centerLeft,
//                               child:
//                                 Text(homeall.houseProvince == null ?"" :"จ."+homeall.houseProvince,style: TextStyle(
//                                   color: Color.fromRGBO(250, 120, 186, 1),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Kanit',
//                                 ),),
//                           ),Align(alignment: Alignment.centerLeft,
//                               child:
//                               Text(homeall.houseDistrict == null ?"" :" อ."+homeall.houseDistrict,style: TextStyle(
//                                 color: Color.fromRGBO(250, 120, 186, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Kanit',
//                               ),),
//                             ),
//                           ],),
//                   Row(children: <Widget>[
//                     Align(alignment: Alignment.centerLeft,
//                     child: Text(homeall.houseType == null ? "":homeall.houseType+" ",style: TextStyle(
//                       color: Color.fromRGBO(250, 120, 186, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Kanit',
//                     ),),
//                   ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child:Row(children: <Widget>[
//                         Icon(Icons.king_bed,color: Color.fromRGBO(250, 120, 186, 1),size: 15,),Text(homeall.houseBedroom == null ? " ":homeall.houseBedroom.toString()+" ",style: TextStyle(
//                           color: Color.fromRGBO(250, 120, 186, 1),
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Kanit',
//                         ),) ],)  ),
//
//                     Align(
//                         alignment: Alignment.centerLeft,
//                         child:Row(children: <Widget>[
//                           Icon(Icons.bathtub,color: Color.fromRGBO(250, 120, 186, 1),size: 15,),Text(homeall.houseBathroom == null ? " " :homeall.houseBathroom.toString()+" ",style: TextStyle(
//                             color: Color.fromRGBO(250, 120, 186, 1),
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Kanit',
//                           ),) ],)  ),
//
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(homeall.houseArea == null ? "":homeall.houseArea+" ",style: TextStyle(
//                         color: Color.fromRGBO(250, 120, 186, 1),
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Kanit',
//                       ),),
//                     ),
//
//                   ])
//
//                 ],
//
//               )) ,
//       ]),
//       trailing: Text(
//         (homeall.houseStatus == 0)
//             ? 'ว่าง'
//             : (homeall.houseStatus == 1)
//             ? 'กำลังเช่า'
//             : (homeall.houseStatus == 2)
//             ? 'ติดจอง'
//             : 'ยกเลิก',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: (homeall.houseStatus == 0)
//               ? Colors.green
//               : (homeall.houseStatus == 1)
//               ? Colors.yellow[600]
//               : (homeall.houseStatus == 2)
//               ? Colors.orange
//               : Colors.red,
//
//         ),
//       ),
//     )
// );
// }).toList())
// : Container()
// ],
// ),
// ),

// return  Container(margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
// padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
// height: MediaQuery.of(context).size.height * 0.25,
// child: Card(
// color:Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0),
// ),
// child: Row(children: <Widget>[Expanded(child: FittedBox(fit: BoxFit.contain,child: ,))],),
//
// ),);
//

// }
// return LinearProgressIndicator();
// Row(children: <Widget>[
// Expanded(
//     child: FittedBox(
//       // alignment: Alignment.centerLeft,
//       fit: BoxFit.contain,
//       child: Image.network(homeall.houseImage,
//       width: 100,height: 100,
//       )
//
//     )
// ),
//   Expanded(
//       child: Column(children: <Widget>[
//     Expanded(
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Text(homeall.houseName,style: _biggerFont,),
//         )
//     ),
//     Expanded(
//         child:Align(
//           alignment: Alignment.centerLeft,
//           child: Text("see more detail and click to detail about",style: _blueFont,),
//         ))
//       ],))
// ],)

// homeall.map((homeall){
// print("Homeall Ok");
// return   Container(
// margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.1),
// padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.15),
// height: MediaQuery.of(context).size.height * 0.25,

// child:Card(color: Colors.white,shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0)),child:
// Row(children: <Widget>[
// Expanded(child: FittedBox(fit: BoxFit.contain,child: Image.network(homeall.houseImage)),),
// Expanded(child: Column(children: <Widget>[
// Expanded(child: Align(
// alignment: Alignment.centerLeft,
// child: Text(homeall.houseName,style: _biggerFont),
// )),
// Expanded(child: Align(
// alignment: Alignment.centerLeft,
// child: Text(homeall.houseAdd,style: _blueFont,),
// ))
// ]))
// ],
// ))
// );

// }).toList();
