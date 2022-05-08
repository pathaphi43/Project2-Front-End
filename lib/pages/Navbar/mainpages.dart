import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homealone/model/homemodel.dart';
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



List<int> args;
SharedPreferences prefs;
int id,status;
String firstName,lastName,userName,imageProfile;



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
  Manager managerdata;
  Tenant tenantdata;

  @override
  void initState() {
    super.initState();
    asyncFunc();
    _determinePosition();
    print("initState");
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // Permissions are denied forever, handle appropriately.
      // print(position.latitude + position.longitude);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  asyncFunc() async {
    print("Main Page AsyncFunc");
    prefs = await SharedPreferences.getInstance();
    if(prefs.getInt('id') != null && prefs.getInt('status') != null){
      id = prefs.getInt('id');
      status = prefs.getInt('status');
      if(status == 0){
        await  getManager(id);
        setState(() {
        prefs.setString("imageprofile", managerdata.managerImage);
        prefs.setString("firstname", managerdata.managerFirstname);
        prefs.setString("lastname", managerdata.managerLastname);
        prefs.setString("username", managerdata.managerUsername);

        firstName = prefs.getString('firstname');
        lastName = prefs.getString('lastname');
        userName = prefs.getString('username');
        imageProfile = prefs.getString('imageprofile');
        // args[0] = id;
        // args[1] = status;
        ProfilePage().createState().asyncFunc();
        });


      }else if(status == 1){
        await  getTenant(id);

        setState(() {
          prefs.setString("imageprofile", tenantdata.tenantImage);
          prefs.setString("firstname", tenantdata.tenantFirstname);
          prefs.setString("lastname", tenantdata.tenantLastname);
          prefs.setString("username", tenantdata.tenantUsername);

          firstName = prefs.getString('firstname');
          lastName = prefs.getString('lastname');
          userName = prefs.getString('username');
          imageProfile = prefs.getString('imageprofile');
          // args[0] = id;
          // args[1] = status;
          ProfilePage().createState().asyncFunc();
        });
      }
    }else{
      setState(() {
        managerdata = null;
        tenantdata = null;
        id = null;
        status = null;
        firstName = null;
        lastName = null;
        imageProfile = null;
        userName = null;
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
        Uri.http('home-alone-csproject.herokuapp.com', '/manager/id/' + id.toString()));
      if (response.statusCode == 200) {
        print("Main Page Get Manager");
        return managerdata = managerFromJson(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load data');
      }
  }

  Future<Tenant> getTenant(int id) async {
    final response = await http.get(
        Uri.http('home-alone-csproject.herokuapp.com', '/tenant/id/' + id.toString()));
    setState(() {
      print(response.statusCode);
      if (response.statusCode == 200) {
        tenantdata = tenantFromJson(utf8.decode(response.bodyBytes));
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
                  accountName: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text(firstName +
                        "\t" +
                        lastName,style: TextStyle(
                      color: Color.fromRGBO(250, 120, 186, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),),],
                  ),
                  accountEmail: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(userName,style: TextStyle(
                      color: Colors.blueGrey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                    ),),],
                  ),
                  currentAccountPictureSize: Size(MediaQuery.of(context).size.width * 0.75, 80),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('images/background_drawer.jpg'.toString()),
                          fit: BoxFit.cover)),
                  currentAccountPicture: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(imageProfile),
                    ),
                  ),

                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('แก้ไขข้อมูลส่วนตัว'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Editmanager-page',
                        arguments: [ prefs.getInt("id"),prefs.getInt("status") ]);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add_business_outlined),
                  title: Text('เพิ่มบ้านเช่า'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Addhome-page',
                        arguments: id);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.attachment_rounded),
                  title: Text('เพิ่มการเช่า'),
                  onTap: () {
                    Navigator.pushNamed(context, '/PreRent-page',
                        arguments: id);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.apartment),
                  title: Text('ข้อมูลบ้านเช่า'),
                  onTap: () {
                    Navigator.pushNamed(context, '/Myhouse-page',
                        arguments:  prefs.getInt("id").toString());
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
                    managerdata = null;
                    tenantdata = null;
                    id = null;
                    status = null;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/main-page',
                      (Route<dynamic> route) => false,
                    );


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
                     icon: const Icon(Icons.filter_list_alt,color: Color.fromRGBO(250, 120, 186, 1), ),
                    // icon: Container(
                    //   child: Hero(
                    //     tag: 'Profile Picture',
                    //     child: CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //           imageProfile),
                    //     ),
                    //   ),
                    // ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    // tooltip:
                    //     MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                  accountName: Text(firstName +
                      "\t" +
                     lastName,style: TextStyle(
              color: Color.fromRGBO(250, 120, 186, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
            ),),
                  accountEmail: Text(userName,style: TextStyle(
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
                        imageProfile
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
                              imageProfile),
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
        label:'หน้าแรก');
  }

  BottomNavigationBarItem searchNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
        // size: 20,
      ),
      label:'ค้นหา');
  }

  BottomNavigationBarItem mapNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.map,
        // size: 20,
      ),
      label: 'แผนที่',
    );
  }

  BottomNavigationBarItem paymentNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.payment,
        // size: 20,
      ),
      label: 'การเงิน',
    );
  }

  BottomNavigationBarItem profileNav() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.account_box_rounded,
        // size: 20,
      ),
      label: 'โปรไฟล์',
    );
  }
}
