import 'dart:convert';
import 'dart:ui';
import 'package:homealone/model/loginmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:condition/condition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    if (args[1] == '0' && args != null) {
      return Scaffold(
        endDrawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Demo'),
                accountEmail: Text('Demo'),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/back.jpg'.toString()),
                        fit: BoxFit.cover)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://homealone.comsciproject.com/img/nong.jpg"
                          .toString()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_add_outlined),
                title: Text('เพิ่มสมาชิก'),
                onTap: () {
                  Navigator.pushNamed(context, '/Adduser-page',
                      arguments: null);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_business_outlined),
                title: Text('เพิ่มบ้านเช่า'),
                onTap: () {
                  Navigator.pushNamed(context, '/Addhome-page',
                      arguments: args);
                },
              ),
              ListTile(
                leading: Icon(Icons.attachment_rounded),
                title: Text('เพิ่มการเช่า'),
                onTap: () {
                  Navigator.pushNamed(context, '/Addrent-page',
                      arguments: null);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('ตั้งค่า'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app_outlined),
                title: Text('ออกจากระบบ'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login-page',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
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
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  // icon: const Icon(Icons.access_alarm_rounded),
                  icon: Container(
                    child: Hero(
                      tag: 'Profile Picture',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "http://homealone.comsciproject.com/img/nong.jpg"),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ],
          backgroundColor: Colors.grey,
        ),
        body: showWidgets[index],
        bottomNavigationBar: myButtonNavBar(),
      );
    }
    // ผู้เช่า//////////////
    else {
      return Scaffold(
        endDrawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Demo'),
                accountEmail: Text('Demo'),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/back.jpg'.toString()),
                        fit: BoxFit.cover)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://homealone.comsciproject.com/img/nong.jpg"
                          .toString()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('ตั้งค่า'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app_outlined),
                title: Text('ออกจากระบบ'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login-page',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
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
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  // icon: const Icon(Icons.access_alarm_rounded),
                  icon: Container(
                    child: Hero(
                      tag: 'Profile Picture',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "http://homealone.comsciproject.com/img/nong.jpg"),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
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
          size: 25.00,
        ),
        title: Text('Home'));
  }

  BottomNavigationBarItem paymentNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.payment,
        size: 25.00,
      ),
      title: Text('Pay'),
    );
  }

  BottomNavigationBarItem profileNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.account_box_rounded,
        size: 25.00,
      ),
      title: Text('Profile'),
    );
  }
}
