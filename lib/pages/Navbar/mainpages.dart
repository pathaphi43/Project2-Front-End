import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/model/managermodel.dart';
import 'package:homealone/model/tenantmodel.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';

import 'package:homealone/pages/search/search.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

List<Manager> managerdata;
List<Tenant> tenantdata;
List<String> args;
SharedPreferences prefs;
int id,status;

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  List<Widget> showWidgets = [
    HomePage(),
    SearchPage(),
    MapPage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;
  String message = ' ';

  @override
  void initState() {
    super.initState();
    asyncFunc();
    print("initState");
  }

  asyncFunc()async {
    prefs = await SharedPreferences.getInstance();

    if(prefs.getInt('id') != null && prefs.getInt('status') != null){
      id = prefs.getInt('id');
      status = prefs.getInt('status');
      if(status == 0){
        await  getManager(id);
      }else if(status == 1){
        await  getTenant(id);
      }
    }else{
      setState(() {
        managerdata = null;
        tenantdata = null;
        id = null;
        status = null;
      });
    }

  }


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   print("didChangeDependencies");
  //   args = ModalRoute.of(context).settings.arguments;
  //   if (prefs != null) {
  //     if (status == 0 && status != null) {
  //       getManager(id);
  //     } else if (status == 1 && status != null) {
  //       print("Tennant");
  //       getTenant(id);
  //     } else {
  //       print("Error");
  //     }
  //   }
  // }

  Future<Manager> getManager(int id) async {
    final response = await http.get(
        Uri.http('homealone.comsciproject.com', '/manager/manager/' + id.toString()));
    setState(() {
      // print(response.statusCode);
      if (response.statusCode == 200) {
        managerdata = managerFromJson(response.body);

      } else {
        throw Exception('Failed to load data');
      }
    });
  }

  Future<Tenant> getTenant(int id) async {
    final response = await http.get(
        Uri.http('homealone.comsciproject.com', '/tenant/tenant/' + id.toString()));
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
    if (managerdata != null || tenantdata != null) {
      if (status == 0 && status != null) {
        return Scaffold(
          endDrawer: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(managerdata[0].managerFirstname +
                      "\t" +
                      managerdata[0].managerLastname,style: TextStyle(
                    color: Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),),
                  accountEmail: Text(managerdata[0].managerUsername,style: TextStyle(
                    color: Color.fromRGBO(247, 207, 205, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('images/back.jpg'.toString()),
                          fit: BoxFit.cover)),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(managerdata[0].managerImage.toString()),
                  ),

                ),
                // ListTile(
                //   leading: Icon(Icons.person_add_outlined),
                //   title: Text('เพิ่มสมาชิก'),
                //   onTap: () {
                //     Navigator.pushNamed(context, '/Adduser-page',
                //         arguments: null);
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('แก้ไขข้อมูลส่วนตัว'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Editmanager-page',
                        arguments: args);
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
                  leading: Icon(Icons.apartment),
                  title: Text('ข้อมูลบ้านเช่า'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Myhouse-page',
                        arguments: args);
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
                    setState(() {
                    prefs.clear();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/main-page',
                      (Route<dynamic> route) => false,
                    );
                    managerdata = null;
                    tenantdata = null;
                    });
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 207, 205, 1),
            centerTitle: true,
            title: Image.asset('img/logo.png'),
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
          ),
          body: showWidgets[index],
          bottomNavigationBar: myButtonNavBar(),
        );
      }
      // ผู้เช่า//////////////
      else if (status == 1 && status != null) {
        return Scaffold(
          endDrawer: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(tenantdata[0].tenantFirstname +
                      "\t" +
                      tenantdata[0].tenantLastname,style: TextStyle(
              color: Color.fromRGBO(250, 120, 186, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
            ),),
                  accountEmail: Text(tenantdata[0].tenantUsername,style: TextStyle(
                    color: Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('images/back.jpg'.toString()),
                          fit: BoxFit.cover)),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        tenantdata[0].tenantImage
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
                    prefs.clear();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/main-page',
                      (Route<dynamic> route) => false,
                    );
                    managerdata = null;
                    tenantdata = null;
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 207, 205, 1),
            centerTitle: true,
            title: Image.asset('img/logo.png'),
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
                              tenantdata[0].tenantImage.toString()),
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
          ),
          body: showWidgets[index],
          bottomNavigationBar: myButtonNavBar(),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 207, 205, 1),
          centerTitle: true,
          title: Image.asset('img/logo.png'),
          actions: <Widget>[
            Row(children: [
              FlatButton(
                textColor: Color.fromRGBO(250, 120, 186, 1),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/Prelogin-page',
                  );
                },
                child: Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(
                    color: Color.fromRGBO(250, 120, 186, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),
                ),
                shape: StadiumBorder(
                    side: BorderSide(width: 2.0, color: Colors.transparent)),
              ),
            ])
          ],
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
      unselectedItemColor: Color.fromRGBO(247, 207, 205, 1),
      selectedItemColor: Color.fromRGBO(250, 120, 186, 1),
      backgroundColor: Colors.pink[200],
      items: <BottomNavigationBarItem>[
        homeNav(),
        searchNav(),
        mapNav(),
        paymentNav(),
        profileNav()
      ],
    );
  }

  BottomNavigationBarItem homeNav() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          // size: 20,
        ),
        title: Text('หน้าแรก'));
  }

  BottomNavigationBarItem searchNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
        // size: 20,
      ),
      title: Text('ค้นหา'),
    );
  }

  BottomNavigationBarItem mapNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.map,
        // size: 20,
      ),
      title: Text('แผนที่'),
    );
  }

  BottomNavigationBarItem paymentNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.payment,
        // size: 20,
      ),
      title: Text('การเงิน'),
    );
  }

  BottomNavigationBarItem profileNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.account_box_rounded,
        // size: 20,
      ),
      title: Text('โปรไฟล์'),
    );
  }
}
