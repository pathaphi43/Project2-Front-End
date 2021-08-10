import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  List<Widget> showWidgets = [
    SearchPage(),
    MapPage(),
    HomePage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: GoogleMap(mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(16.199775637587717,103.2825989989716),zoom: 15),
      onMapCreated: (GoogleMapController controller){
      _controller.complete(controller);
    },),);
  }
}
