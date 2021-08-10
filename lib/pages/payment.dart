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
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(
                  child: Text("การจ่ายเงิน",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit',
                        color: Color.fromRGBO(250, 120, 186, 1),
                      ))),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new FlatButton(
                  minWidth: 300.0,
                  height: 100.0,
                  color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {

                    Navigator.pushNamed(context, '/Rentpay-page', arguments: null);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: Color.fromRGBO(250, 120, 186, 1),
                        size: 50,
                      ),
                      Text(
                        "ค่าเช่าบ้าน",
                        style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(2, 97, 26, 1),
                          fontSize: 25,
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
                padding: const EdgeInsets.all(20.0),
                child: new FlatButton(
                  minWidth: 300.0,
                  height: 100.0,
                  color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Waterpay-page',arguments: null);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        imgIcon.water,
                        color: Colors.lightBlueAccent,
                        size: 30,
                      ),
                      Text(
                        "ค่าน้ำประปา",
                        style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(2, 97, 26, 1),
                          fontSize: 25,
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
                padding: const EdgeInsets.all(20.0),
                child: new FlatButton(
                  minWidth: 300.0,
                  height: 100.0,
                  color: Color.fromRGBO(247, 207, 205, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Elecpay-page',arguments: null);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.wb_incandescent,
                        color: Colors.orangeAccent,
                        size: 50,
                      ),
                      Text(
                        "ค่าไฟฟ้า",
                        style: TextStyle(
                          height: 2,
                          color: Color.fromRGBO(2, 97, 26, 1),
                          fontSize: 25,
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
        ),
      ),
    );
  }
}
