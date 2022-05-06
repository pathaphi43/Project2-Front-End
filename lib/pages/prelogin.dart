import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class PreLogin extends StatefulWidget {
  // const PreLogin({ Key? key }) : super(key: key);

  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(247, 207, 205, 1.0),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                height: mqHeight * 0.8,
                child: Card(
                  elevation: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/biglogo.png',
                        width: 300,
                        height: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            FlatButton(
                              minWidth: 300.0,
                              height: 60.0,
                              onPressed: () {
                                Navigator.pushNamed(context, '/login-page');
                              },
                              child: Text(
                                "ลงชื่อเข้าใช้",
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 97, 26, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      width: 3.0,
                                      color: Color.fromRGBO(247, 207, 205, 1))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton(
                              minWidth: 300.0,
                              height: 60.0,
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor:
                                            Color.fromRGBO(247, 207, 205, 1.0),
                                        title: Center(
                                          child: Text(
                                            "สมัครสมาชิก",
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(2, 97, 26, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Kanit',
                                            ),
                                          ),
                                        ),
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          child: GridView.count(
                                              primary: false,
                                              padding: const EdgeInsets.all(8),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 2,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => {
                                                    Navigator.pushNamed(context,
                                                        '/Regmanager-page',
                                                        arguments: null)
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.home,
                                                            color:
                                                                Color.fromRGBO(
                                                                    247,
                                                                    207,
                                                                    205,
                                                                    1.0),
                                                            size: 40,
                                                          ),
                                                          Text("ผู้จัดการ",
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        247,
                                                                        207,
                                                                        205,
                                                                        1.0),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Kanit',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => {
                                                    Navigator.pushNamed(context,
                                                        '/Register-page',
                                                        arguments: null)
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.account_box,
                                                            color:
                                                                Color.fromRGBO(
                                                                    247,
                                                                    207,
                                                                    205,
                                                                    1.0),
                                                            size: 40,
                                                          ),
                                                          Text("ผู้เช่า",
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        247,
                                                                        207,
                                                                        205,
                                                                        1.0),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Kanit',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    color: Color.fromRGBO(
                                                        250, 120, 186, 1),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Kanit',
                                                ),
                                              ))
                                        ],
                                      )),
                              child: Text(
                                "สมัครสมาชิก",
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 97, 26, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      width: 3.0,
                                      color: Color.fromRGBO(247, 207, 205, 1))),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
