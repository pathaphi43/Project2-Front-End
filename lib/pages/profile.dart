import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> showWidgets = [HomePage(), PaymentPage(), ProfilePage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Text('หน้าโปรไฟล์');
  }
}
