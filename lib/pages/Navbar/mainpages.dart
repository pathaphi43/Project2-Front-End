import 'dart:convert';

import 'package:homealone/model/loginmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:condition/condition.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  List<Widget> showWidgets = [HomePage(), PaymentPage(), ProfilePage()];
  int index = 0;
  String message = ' ';
  @override
  Widget build(BuildContext context) {
    List<String> args = ModalRoute.of(context).settings.arguments;
    print('MainContext' + args.toString());
    if (args[1] == '0') {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
                size: 25,
              ),
              tooltip: 'Add User',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('MenuAdd')));
                Navigator.pushNamed(context, '/manu-page', arguments: args);
              }),
          title: Center(
            child: Text(
              'Home Alone',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                tooltip: 'LOGOUT',
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    '/login-page',
                  );

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('LOGOUT')));
                })
          ],
          backgroundColor: Colors.grey[200],
        ),
        body: showWidgets[index],
        bottomNavigationBar: myButtonNavBar(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          // leading:  IconButton(
          //     icon: const Icon(
          //       Icons.add_box_outlined,
          //       color: Colors.black,
          //       size: 25,
          //     ),
          //     tooltip: 'Add User',
          //     onPressed: () {
          //       ScaffoldMessenger.of(context)
          //           .showSnackBar(const SnackBar(content: Text('MenuAdd')));
          //       Navigator.pushNamed(context, '/manu-page', arguments: args);
          //     }),

          title: Center(
            child: Text(
              'Home Alone',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                tooltip: 'LOGOUT',
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    '/login-page',
                  );

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('LOGOUT')));
                })
          ],
          backgroundColor: Colors.grey[200],
        ),
        body: showWidgets[index],
        bottomNavigationBar: myButtonNavBar(),
      );
    }
  }

  Widget myButtonNavBar() {
    return BottomNavigationBar(
      onTap: (int i) {
        setState(() {
          index = i;
        });
      },
      currentIndex: index,
      items: <BottomNavigationBarItem>[homeNav(), paymentNav(), profileNav()],
    );
  }

  BottomNavigationBarItem homeNav() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 20.00,
        ),
        title: Text('Home'));
  }

  BottomNavigationBarItem paymentNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.payment,
        size: 20.00,
      ),
      title: Text('Pay'),
    );
  }

  BottomNavigationBarItem profileNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.account_box_rounded,
        size: 20.00,
      ),
      title: Text('Profile'),
    );
  }
}
