// import 'package:flutter/material.dart';
// import 'package:homealone/pages/Navbar/cart-button.dart';

// class AddMenu extends StatefulWidget {
//   AddMenu({Key key}) : super(key: key);

//   @override
//   _AddMenuState createState() => _AddMenuState();
// }

// class _AddMenuState extends State<AddMenu> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> args = ModalRoute.of(context).settings.arguments;
//     print('ContextAddMenu' + args.toString());
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 75, 0),
//           child: Text('HomeAlone'),
//         )),
//         actions: <Widget>[],
//       ),
//       body: Container(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/Adduser-page',
//                             arguments: null);
//                       },
//                       child: Column(
//                         children: <Widget>[
//                           Icon(
//                             Icons.add,
//                             size: 50,
//                           ),
//                           Text(
//                             'เพิ่มสมาชิก'.toUpperCase(),
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green),
//                           ),
//                         ],
//                       ),
//                       style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsets>(
//                               EdgeInsets.all(15)),
//                           foregroundColor:
//                               MaterialStateProperty.all<Color>(Colors.black45),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.amber[100]),
//                           minimumSize:
//                               MaterialStateProperty.all<Size>(Size(100, 100)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 side: BorderSide(color: Colors.white)),
//                           ))),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/Addrent-page',
//                             arguments: null);
//                       },
//                       child: Column(
//                         children: <Widget>[
//                           Image.asset(
//                             'images/home.jpg',
//                             width: 200,
//                           ),
//                           Text(
//                             'เพิ่มข้อมูลการเช่าบ้าน'.toUpperCase(),
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green),
//                           )
//                         ],
//                       ),
//                       style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsets>(
//                               EdgeInsets.all(15)),
//                           shadowColor:
//                               MaterialStateProperty.all<Color>(Colors.black),
//                           foregroundColor:
//                               MaterialStateProperty.all<Color>(Colors.black45),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.amber[100]),
//                           minimumSize:
//                               MaterialStateProperty.all<Size>(Size(100, 100)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 side: BorderSide(color: Colors.white)),
//                           ))),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/Addhome-page',
//                               arguments: args);
//                         },
//                         child: Column(
//                           children: <Widget>[
//                             Image.asset(
//                               'images/home.jpg',
//                               width: 200,
//                             ),
//                             Text(
//                               'เพิ่มบ้านเช่า'.toUpperCase(),
//                               style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green),
//                             )
//                           ],
//                         ),
//                         style: ButtonStyle(
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.all(15)),
//                             shadowColor:
//                                 MaterialStateProperty.all<Color>(Colors.black),
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                                 Colors.black45),
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Colors.amber[100]),
//                             minimumSize:
//                                 MaterialStateProperty.all<Size>(Size(100, 100)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                   side: BorderSide(color: Colors.white)),
//                             ))),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
