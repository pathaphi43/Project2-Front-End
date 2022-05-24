import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/model/house/HouseAndImageModel.dart';
import 'package:homealone/pages/Navbar/mainpages.dart';
import 'package:http/http.dart' as http;

class EditImageHouse extends StatefulWidget {
  const EditImageHouse({Key key}) : super(key: key);

  @override
  State<EditImageHouse> createState() => _EditImageHouseState();
}

class _EditImageHouseState extends State<EditImageHouse> {
  House args;
  AppStyle _appStyle = new AppStyle();

  @override
  void didChangeDependencies() async {
    args = ModalRoute.of(context).settings.arguments;
    await gethomeAll();
    super.didChangeDependencies();
  }

  Stream<HouseAndImageModel> onCurrentUserChanged;
  StreamController<HouseAndImageModel> currentUserStreamCtrl =
      new StreamController<HouseAndImageModel>.broadcast();

  Future<void> onRefresh() {
    setState(() {
      gethomeAll();
    });
    return Future.delayed(Duration(seconds: 1));
  }

  HouseAndImageModel homeall;

  Future<HouseAndImageModel> gethomeAll() async {
    print(args.hid.toString());
    final response = await http.get(Uri.http(
        'home-alone-csproject.herokuapp.com',
        '/house/house-image/' + args.hid.toString()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print("Body"+utf8.decode(response.bodyBytes));
      currentUserStreamCtrl.sink
          .add(houseAndImageFromJson(utf8.decode(response.bodyBytes)));
      return homeall = houseAndImageFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load homedata');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/AddImages-page',
                    arguments: args);
              },
              child: Text(
                'เพิ่มรูป',
                style: _appStyle.textStyleUrSizeAndColor(16, Colors.white),
              ),
            ),
          ],
          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
          centerTitle: true,
          title: Image.asset('img/logo.png'),
        ),
        body: RefreshIndicator(
            onRefresh: onRefresh,
            child: StreamBuilder(
                stream: currentUserStreamCtrl.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<HouseAndImageModel> snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LinearProgressIndicator();
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.hasData) {
                      return _buildGrid(snapshot.data.houseImageList.length,
                          snapshot.data.houseImageList);
                    } else
                      return Text('ไม่มีรูป');
                  } else
                    return LinearProgressIndicator();
                })));
  }

  Widget _buildGrid(int count, List<HouseImageList> image) => GridView.extent(
        maxCrossAxisExtent: 200,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(count, image),
      );

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count, List<HouseImageList> image) =>
      List.generate(
          count,
          (i) => Container(
                  child: InkWell(
                child: Image.network(
                  image[i].imageHousePath,
                  fit: BoxFit.cover,
                ),
                onTap: () => showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('ยืนยันลบ '),
                    // content: Text('ยืนยันลบ'+),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () async {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            duration: new Duration(seconds: 4),
                            content: new Row(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                                new Text("กำลังโหลด...")
                              ],
                            ),
                          ));
                          var response = await http.delete(
                            Uri.parse(
                                'https://home-alone-csproject.herokuapp.com/house/delete-image/${image[i].pid}'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          if (response.statusCode == 200){
                            onRefresh().whenComplete(() => Navigator.pop(context, 'ยืนยัน'));
                          }else  ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            duration: new Duration(seconds: 4),
                            content: new Row(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                                new Text("เกิดข้อผิดพลาด:${response.statusCode} ")
                              ],
                            ),
                          ));
                        },
                        child: const Text('ยืนยัน'),
                      ),
                    ],
                  ),
                ),
              )));
}
