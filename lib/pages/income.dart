import 'package:flutter/material.dart';
import 'package:homealone/pages/Navbar/appBar.dart';

class IncomePage extends StatefulWidget {
  IncomePage({key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavAppBar(),
    );
  }

  Widget bodyIncome(){
    return Container();
  }
}