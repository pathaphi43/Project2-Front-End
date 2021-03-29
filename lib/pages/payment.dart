import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/profile.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<Widget> showWidgets = [HomePage(), PaymentPage(), ProfilePage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Text('หน้าการจ่ายเงิน');
  }
}
