import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/review/InsertReviewModel.dart';
import 'package:homealone/model/review/PreReviewModel.dart';
import 'package:homealone/model/review/ReviewsModel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool checkRating = false;
  PreReviewModel _reviewModel;
  int rating;
  var textFormField = TextEditingController();
  AppStyle _appStyle = new AppStyle();
  List<File> files;

  @override
  void didChangeDependencies() {
    _reviewModel = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  File image;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      // setState(() {
      this.image = imageTemporary;
      // });

      return imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
        centerTitle: true,
        title: Image.asset('img/logo.png'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(40.0),
          children: [
            Center(
                child: Text(
              'คะแนน',
              style: _appStyle.textStyleUrSize(20),
            )),
            SizedBox(height: 20),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color.fromRGBO(255, 195, 202, 1),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  setState(() {
                    this.rating = rating.toInt();
                    checkRating = true;
                  });
                },
              ),
            ),
            (checkRating)
                ? Column(
                    children: [
                      SizedBox(height: 20),
                      SizedBox(
                        child: TextFormField(
                            controller: textFormField,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'เขียนข้อความ',
                              border: OutlineInputBorder(),
                            )),
                      ),
                      //SizedBox(height: 20),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () async {
                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: true,
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'png',
                                    ],
                                  );

                                  if (result != null) {
                                    // File(result.files.first.path);
                                    files = result.paths
                                        .map((path) => File(path))
                                        .toList();
                                    setState(() {});
                                  } else {
                                    print('cancel');
                                    // User canceled the picker
                                  }
                                },
                                icon: const Icon(
                                  Icons.image,
                                ),
                                iconSize: 200,
                                color: Color.fromRGBO(247, 207, 205, 1),
                              ),
                            ]),
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new FlatButton(
                              minWidth: 120.0,
                              height: 50.0,
                              color: Color.fromRGBO(247, 207, 205, 1),
                              onPressed: () async {
                                print('ยืนยัน');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(new SnackBar(
                                  duration: new Duration(seconds: 5),
                                  content: new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("กำลังโหลด...")
                                    ],
                                  ),
                                ));
                                var model = InsertReviewsModel();
                                model.rid = _reviewModel.rentingHouse.rid;
                                model.tid = _reviewModel.rentingHouse.tid;
                                model.reviewsText = textFormField.text.isEmpty
                                    ? null
                                    : textFormField.text;
                                model.reviewsScore = this.rating;
                                model.reviewsDate = new DateTime.now();
                                var rentBody = insertreviewToJson(model);
                                print(rentBody);

                                var postUri = Uri.parse(
                                    "https://home-alone-csproject.herokuapp.com/review/save-review");

                                var request =
                                    http.MultipartRequest('POST', postUri)
                                      ..fields['reviewBody'] = rentBody;
                                if (files != null) {
                                  for (File file in files) {
                                    String fileName = file.path.split('/').last;
                                    request.files.add(
                                        await http.MultipartFile.fromBytes(
                                            'file',
                                            await File.fromUri(file.uri)
                                                .readAsBytes(),
                                            filename: fileName,
                                            contentType: MediaType(
                                                'ContentType',
                                                'application/json')));
                                  }
                                }

                                var streamedResponse = await request.send();
                                var response = await http.Response.fromStream(
                                    streamedResponse);
                                // request.send().then((response) {
                                if (response.statusCode == 200) {
                                  Navigator.of(context).pop(true);
                                } else
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(new SnackBar(
                                    duration: new Duration(seconds: 4),
                                    content: new Row(
                                      children: <Widget>[
                                        new CircularProgressIndicator(),
                                        new Text("เกิดข้อผิดพลาด:" +
                                            response.statusCode.toString())
                                      ],
                                    ),
                                  ));
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
                            padding: const EdgeInsets.all(10.0),
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
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
