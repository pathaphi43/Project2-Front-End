import 'dart:convert';
import 'dart:ui';
import 'package:homealone/model/loginmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:condition/condition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

List<Manager> managerdata;
List<Tenant> tenantdata;
List<String> args;

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  List<Widget> showWidgets = [HomePage(), PaymentPage(), ProfilePage()];
  int index = 0;
  String message = ' ';

  @override
  void initState() {
    super.initState();

    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
    args = ModalRoute.of(context).settings.arguments;

    if (args[1] == '0' && args[1].isNotEmpty) {
      print("Manager:" + args[1]);
      getManager(args);
    } else if (args[1] == '1' && args[1].isNotEmpty) {
      print("Tennant");
      getTenant(args);
    } else {
      print("Error");
    }

    print(managerdata != null);
  }

  Future<Manager> getManager(List<String> args) async {
    final response = await http.get(Uri.http(
        'homealone.comsciproject.com', '/usersdata/manager/' + args[0]));
    setState(() {
      // print(response.statusCode);
      if (response.statusCode == 200) {
        managerdata = managerFromJson(response.body);
        // print(managerdata[0].managerImage);
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  Future<Tenant> getTenant(List<String> args) async {
    final response = await http.get(Uri.http(
        'homealone.comsciproject.com', '/usersdata/tenant/' + args[0]));
    setState(() {
      print(response.statusCode);
      if (response.statusCode == 200) {
        tenantdata = tenantFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Widget build");
    // print("Manager" + managerdata.isNotEmpty.toString());
    if (args[1] == '0' && args != null) {
      return Scaffold(
        endDrawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(managerdata[0].managerFullname),
                accountEmail: Text(managerdata[0].managerOffice),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/back.jpg'.toString()),
                        fit: BoxFit.cover)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      NetworkImage(managerdata[0].managerImage.toString()),
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
                            managerdata[0].managerImage.toString()),
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

  Widget myAppbar() {
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
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
