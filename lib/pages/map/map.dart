import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homealone/model/house/HouseAndImageModel.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/payment.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';


class MapPage extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  @override
  _MapPageState createState() => _MapPageState();
}



class _MapPageState extends State<MapPage> {
  // PickResult selectedPlace;
  LatLng currentLatLng;
  Completer<GoogleMapController> _controller = Completer();
  // final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  final Set<Marker> markers = new Set();
  List<HouseAndImageModel> homeMark;
  CameraPosition cameraPosition;
  BitmapDescriptor customIcon;

  @override
  void initState() {
    print("Map Page");
    // _getUserLocation();
    // _determinePosition();
    Geolocator.getCurrentPosition().then((currLocation) async {

        homeMark = homeall;
        currentLatLng = new LatLng(currLocation.latitude, currLocation.longitude);
        // print( "Lat: "+currLocation.latitude.toString() +"Lng:"+currentLatLng.longitude.toString() );
       cameraPosition  =  CameraPosition(
          target: LatLng(currLocation.latitude, currentLatLng.longitude),
          zoom: 14.4746,
        );
        print(markers.length.toString());
      for(HouseAndImageModel home in homeall){
        Uint8List markerIcon = await getBytesFromCanvas(home.houseRent, 150, 100);
        markers.add(Marker(markerId:MarkerId(home.hid.toString()),
          position: LatLng(double.parse(home.houseLatitude) ,double.parse(home.houseLongitude)),
          infoWindow: InfoWindow(
            onTap: () {
              Navigator.pushNamed(context, '/Homeinfo-page',
                  arguments: [ home.hid ]);
            },
            title: home.houseName,
            snippet: home.houseRent == null ? "":home.houseRent.toString(),
          ),icon:  BitmapDescriptor.fromBytes(markerIcon),
        ));
      }
      setState(() {

      });
    });

    super.initState();
  }


  // void currency() {
  //   Locale locale = Localizations.localeOf(context);

  //   var format = NumberFormat.simpleCurrency(locale: locale.toString());
  //   print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
  //   print("CURRENCY NAME ${format.currencyName}"); // USD
  // }
  Future<Uint8List> getBytesFromCanvas(int customNum, int width, int height) async  {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Color.fromRGBO(250,120, 186, 1);
    final Radius radius = Radius.circular(width/2);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(),  height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      children: [TextSpan(
        text: customNum.toString() +" บาท", // your custom number here
        style: TextStyle( color: Colors.white,
            fontSize: 25,fontWeight:
            FontWeight.bold
        ),
      ),
     ],);

    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * .5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  List<Widget> showWidgets = [
    SearchPage(),
    MapPage(),
    HomePage(),
    PaymentPage(),
    ProfilePage()
  ];
  int index = 0;


  var textController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraPosition == null ? Center(child:CircularProgressIndicator()) :
          MapPicker(
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers:markers,
            ),
          ),
    );

  }
  // void _currentLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   LocationData currentLocation;
  //   var location;
  //   try {
  //     currentLocation = await location.getLocation();
  //   } on Exception {
  //     currentLocation = null;
  //   }
  //
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       bearing: 0,
  //       target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //       zoom: 17.0,
  //     ),
  //   ));
  // }
}
