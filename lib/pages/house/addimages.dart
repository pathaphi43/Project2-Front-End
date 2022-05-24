import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homealone/AppStyle.dart';
import 'package:homealone/model/homemodel.dart';
import 'package:homealone/pages/Navbar/appBar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddImages extends StatefulWidget {
  const AddImages({Key key}) : super(key: key);

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<File> files;
  House args;
  AppStyle _appStyle = new AppStyle();

  @override
  void didChangeDependencies() {
    args = ModalRoute
        .of(context)
        .settings
        .arguments;
    super.didChangeDependencies();
  }

  bool checkFile = false;
  bool checkLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ElevatedButton(
          child: Text('ยืนยัน'),
          onPressed: checkFile
              ? () async {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              // duration: new Duration(seconds: 5),
              content: new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("กำลังโหลด...")
                ],
              ),
            ));
            var postUri = Uri.parse(
                "https://home-alone-csproject.herokuapp.com/house/save-image");
            var request = http.MultipartRequest('POST', postUri)
              ..fields['hid'] = args.hid.toString();
            // if (files != null) {
            for (File file in files) {
              print(args.hid.toString());
              String fileName = file.path
                  .split('/')
                  .last;
              print(fileName);
              request.files.add(await http.MultipartFile.fromBytes(
                  'files', await File.fromUri(file.uri).readAsBytes(),
                  filename: fileName,
                  contentType:
                  MediaType('ContentType', 'application/json')));
            }
            // }
            setState(() {
              checkLoading = true;
              checkFile = false;
            });
            var streamedResponse = await request.send();
            var response =
            await http.Response.fromStream(streamedResponse);

            // request.send().then((response) {
            if (response.statusCode == 200) {
              Navigator.of(context).pop(true);
            } else {
              checkFile = true;
              checkLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                duration: new Duration(seconds: 4),
                content: new Row(
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("เกิดข้อผิดพลาด:" +
                        response.statusCode.toString())
                  ],
                ),
              ));
              setState(() {});
            }
          }
          // );
          // }
              : null,
          style: ElevatedButton.styleFrom(
            // Foreground color
              minimumSize: Size(240, 50),
              maximumSize: Size(240, 50),
              onPrimary: Colors.black,
              // Background color
              primary: Color.fromRGBO(247, 207, 205, 1))
              .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        ),
        appBar: NavAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              (checkLoading) ? LinearProgressIndicator() : Row(),
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text('เลือกรูป'),
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
                            checkFile = true;
                            // File(result.files.first.path);
                            files =
                                result.paths.map((path) => File(path)).toList();
                            setState(() {});
                          } else {
                            print('cancel');
                            // User canceled the picker
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            minimumSize: Size(240, 50),
                            maximumSize: Size(240, 50),
                            onPrimary: Colors.black,
                            // Background color
                            primary: Color.fromRGBO(247, 207, 205, 1))
                            .copyWith(
                            elevation: ButtonStyleButton.allOrNull(0.0)),
                      ),
                    ]),
              ),
              Center(child: Text('ขนาดไฟล์ไม่เกิน 2 MB'),),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: (files != null) ? _buildGrid() : Row(),
              )
            ]),
          ),
        ));
  }

  // double width = MediaQuery.of(context).size.width;
  // double height = MediaQuery.of(context).size.height;
  Widget _buildGrid() =>
      GridView.extent(
          maxCrossAxisExtent: 200,
          padding: const EdgeInsets.all(4),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: _buildGridTileList(files.length));

  List<Container> _buildGridTileList(int count) =>
      List.generate(
          count,
              (i) =>
              Container(
                  child: Image.file(
                    files[i],
                    fit: BoxFit.cover,
                  )));
}
