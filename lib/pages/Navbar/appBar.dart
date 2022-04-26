import 'package:flutter/material.dart';

class NavAppBar extends StatefulWidget implements PreferredSizeWidget {
  NavAppBar({key}) :preferredSize = const Size.fromHeight(50.0), super(key: key);

  @override
  State<NavAppBar> createState() => _NavAppBarState();

  @override
  final Size preferredSize;
}

class _NavAppBarState extends State<NavAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
          centerTitle: true,
          title: Image.asset('img/logo.png'),
    );
  }
}