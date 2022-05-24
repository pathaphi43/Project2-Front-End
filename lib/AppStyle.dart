import 'package:flutter/cupertino.dart';

class AppStyle {
  TextStyle textStyleUrSize(double size) => TextStyle(
      color: Color.fromRGBO(250, 120, 186, 1),
      fontSize: size,
      fontWeight: FontWeight.bold);

  TextStyle textStyle18() => TextStyle(
      color: Color.fromRGBO(250, 120, 186, 1),
      fontSize: 18,
      fontWeight: FontWeight.bold);

  TextStyle textStyle10() => TextStyle(
      color: Color.fromRGBO(250, 120, 186, 1),
      fontSize: 10,
      fontWeight: FontWeight.bold);

  EdgeInsets edgeInsets1() => EdgeInsets.fromLTRB(20, 5, 20, 5);
}
