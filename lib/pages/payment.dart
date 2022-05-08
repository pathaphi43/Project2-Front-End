import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/Icon_img/imgIcon.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<Widget> showWidgets = [HomePage(), PaymentPage(), ProfilePage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text("ชำระค่าใช้จ่าย",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                        color: Color.fromRGBO(250, 120, 186, 1),
                      ))),
                      SizedBox(height: 30,),
                      body()
      //         Padding(
      //           padding: const EdgeInsets.all(20.0),
      //           child: new FlatButton(
      //             minWidth: 300.0,
      //             height: 100.0,
      //             color: Color.fromRGBO(247, 207, 205, 1),
      //             onPressed: () {

      //               Navigator.pushNamed(context, '/Rentpay-page', arguments: null);
      //             },
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Icon(
      //                   Icons.home_rounded,
      //                   color: Color.fromRGBO(250, 120, 186, 1),
      //                   size: 50,
      //                 ),
      //                 Text(
      //                   "ค่าเช่าบ้าน",
      //                   style: TextStyle(
      //                     height: 2,
      //                     color: Color.fromRGBO(2, 97, 26, 1),
      //                     fontSize: 25,
      //                     fontWeight: FontWeight.bold,
      //                     fontFamily: 'Kanit',
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             shape: StadiumBorder(
      //                 side: BorderSide(
      //               width: 1.0,
      //               color: Color.fromRGBO(250, 120, 186, 1),
      //             )),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(20.0),
      //           child: new FlatButton(
      //             minWidth: 300.0,
      //             height: 100.0,
      //             color: Color.fromRGBO(247, 207, 205, 1),
      //             onPressed: () {
      //               Navigator.pushNamed(context, '/Waterpay-page',arguments: null);
      //             },
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Icon(
      //                   imgIcon.water,
      //                   color: Colors.lightBlueAccent,
      //                   size: 30,
      //                 ),
      //                 Text(
      //                   "ค่าน้ำประปา",
      //                   style: TextStyle(
      //                     height: 2,
      //                     color: Color.fromRGBO(2, 97, 26, 1),
      //                     fontSize: 25,
      //                     fontWeight: FontWeight.bold,
      //                     fontFamily: 'Kanit',
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             shape: StadiumBorder(
      //                 side: BorderSide(
      //               width: 1.0,
      //               color: Color.fromRGBO(250, 120, 186, 1),
      //             )),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(20.0),
      //           child: new FlatButton(
      //             minWidth: 300.0,
      //             height: 100.0,
      //             color: Color.fromRGBO(247, 207, 205, 1),
      //             onPressed: () {
      //               Navigator.pushNamed(context, '/Elecpay-page',arguments: null);
      //             },
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Icon(
      //                   Icons.wb_incandescent,
      //                   color: Colors.orangeAccent,
      //                   size: 50,
      //                 ),
      //                 Text(
      //                   "ค่าไฟฟ้า",
      //                   style: TextStyle(
      //                     height: 2,
      //                     color: Color.fromRGBO(2, 97, 26, 1),
      //                     fontSize: 25,
      //                     fontWeight: FontWeight.bold,
      //                     fontFamily: 'Kanit',
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             shape: StadiumBorder(
      //                 side: BorderSide(
      //               width: 1.0,
      //               color: Color.fromRGBO(250, 120, 186, 1),
      //             )),
      //           ),
      //         ),
            ],
          ),
        ),
       ),
    );
  }

Widget body(){
  return Container(
  alignment: Alignment.topCenter,
  height: MediaQuery.of(context).size.height,
  color: Colors.white,

    // color: Colors.blueGrey[100],
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        FlatButton(
                  minWidth: MediaQuery.of(context).size.width/0.8,
                  height: MediaQuery.of(context).size.height/8,
                  // color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {

                    Navigator.pushNamed(context, '/Rentpay-page', arguments: null);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        child: Image.asset('img/biglogo.png')),
                      // Icon(
                      //   Icons.home_rounded,
                      //   color: Color.fromRGBO(250, 120, 186, 1),
                      //   size: 50,
                      // ),
                      Text(
                        "ค่าเช่าบ้าน",
                        style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                    width: 1.0,
                    color: Color.fromRGBO(250, 120, 186, 1),
                  )),
                ),
        SizedBox(height: 15,),
        FlatButton(
                  minWidth: MediaQuery.of(context).size.width/0.8,
                  height: MediaQuery.of(context).size.height/8,
                  // color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Waterpay-page',arguments: null);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        child: Image.asset('img/PWAlogo.png')),
                      // Icon(
                      //   imgIcon.water,
                      //   color: Colors.lightBlueAccent,
                      //   size: 30,
                      // ),
                      Text(
                        "ค่าน้ำประปา",
                        style: TextStyle(
                          height: 2,
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                    width: 1.0,
                    color: Color.fromRGBO(250, 120, 186, 1),
                  )),
                ),
                SizedBox(height: 15,),
                FlatButton(
                  minWidth: MediaQuery.of(context).size.width/0.8,
                  height: MediaQuery.of(context).size.height/8,
                  // color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Elecpay-page',arguments: null);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 95,
                        child: Image.asset('img/PEAlogo.png',)),
                      // Icon(
                      //   Icons.wb_incandescent,
                      //   color: Colors.orangeAccent,
                      //   size: 50,
                      // ),
                      Text(
                        "ค่าไฟฟ้า",
                        style: TextStyle(
                          height: 2,
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                    width: 1.0,
                    color: Color.fromRGBO(250, 120, 186, 1),
                  )),
                ),
      ],
  
  ),
  );
}

}
