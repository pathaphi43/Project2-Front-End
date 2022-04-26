import 'package:flutter/material.dart';
import 'package:homealone/pages/Navbar/appBar.dart';

class RentpayPage extends StatefulWidget {
  @override
  _RentpayPageState createState() => _RentpayPageState();
}

class Exercise {
  String name;
  Exercise({this.name});
}

String dropdownValue1 = 'สถานะ';

class _RentpayPageState extends State<RentpayPage> {

static const int numItems = 15;
  int selectedCard = -1;
  // ignore: unused_field
  int _counter = 0;
  List<Exercise> monthexercises = [
    Exercise(name: 'มกราคม'),
    Exercise(name: 'กุมภาพันธ์'),
    Exercise(name: 'มีนาคม'),
    Exercise(name: 'เมษายน'),
    Exercise(name: 'พฤษภาคม'),
    Exercise(name: 'มิถุนายน'),
    Exercise(name: 'กรกฎาคม'),
    Exercise(name: 'สิงหาคม'),
    Exercise(name: 'กันยายน'),
    Exercise(name: 'ตุลาคม'),
    Exercise(name: 'พฤศจิกายน'),
    Exercise(name: 'ธันวาคม'),
  ];

  List<Exercise> statusexercises = [
    Exercise(name: 'ชำระแล้ว'),
    Exercise(name: 'ค้างชำระ'),
  ];
  // ignore: unused_field
  int _selected;
  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: NavAppBar(), body: rentBody(context)
    );
  }

    Widget rentBody(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    final mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 18,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("ค่าเช่า",
                style: TextStyle(color: Color.fromRGBO(250, 120, 186, 1),fontSize: 20)),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            child: rentsearch(context),
          ),
          Container(
            width: mqWidth,
            height: mqHeight,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                    width: mqWidth,
                    child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 0,
                        columns: const <DataColumn>[
                          DataColumn(
                              label: Expanded(
                            child: Text('ผู้เช่า',
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('บ้าน',
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('เดือน',
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('จำนวน',
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text('สถานะ',
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                          )),
                        ],
                        rows: List<DataRow>.generate(
                          numItems,
                          (int index) => DataRow(cells: <DataCell>[
                            DataCell(Center(child: Text('นิรมัย'))),
                            DataCell(Center(child: Text('บ้านลักษณาวดี'))),
                            DataCell(Center(child: Text('มกราคม'))),
                            DataCell(Center(child: Text('5,500'))),
                            DataCell(Center(
                              child: Text(
                                'เสร็จสิ้น',
                                style: TextStyle(color: Colors.green),
                              ),
                            )),
                          ]),
                        )))
              ],
            ),
          )
        ],
      ),
    ));
  }

   Widget rentsearch(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 40, width: 300),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Color.fromRGBO(247, 207, 205, 1)),
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white70),
          ),
        ),
        Menusearch(context)
      ],
    ));
  }

   Widget Menusearch(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PopupMenuButton(
          icon: Icon(Icons.list_alt),
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ชำระประจำเดือน"),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                  onTap: () {
                    Future<void>.delayed(
                      const Duration(), // OR const Duration(milliseconds: 500),
                      () => showDialog(
                        context: context,
                        barrierColor: Colors.black26,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "เดือน",
                            style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('ยกเลิก',
                                  style: TextStyle(color: Colors.red)),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: const Text(
                                'ยืนยัน',
                                style: TextStyle(color: Colors.green),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          content: SingleChildScrollView(
                            child: Container(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Divider(),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                    ),
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 110,
                                                childAspectRatio: 4 / 2,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15),
                                        itemCount: monthexercises.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // ontap of each card, set the defined int to the grid view index
                                                selectedCard = index;
                                              });
                                            },
                                            child: Card(
                                              // ignore: unrelated_type_equality_checks
                                              color: selectedCard == index
                                                  ? Color.fromRGBO(
                                                      247, 207, 205, 1)
                                                  : Color.fromRGBO(
                                                      250, 120, 186, 1),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  monthexercises[index].name,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  value: 1,
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("สถานะการชำระ"),
                      Icon(Icons.announcement_rounded)
                    ],
                  ),
                  onTap: () {
                    Future<void>.delayed(
                      const Duration(), // OR const Duration(milliseconds: 500),
                      () => showDialog(
                        context: context,
                        barrierColor: Colors.black26,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "สถานะการชำระ",
                            style: TextStyle(
                                color: Color.fromRGBO(250, 120, 186, 1)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('ยกเลิก',
                                  style: TextStyle(color: Colors.red)),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: const Text(
                                'ยืนยัน',
                                style: TextStyle(color: Colors.green),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              textColor: Theme.of(context).accentColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          content: Container(
                            height: 250,
                            width: double.maxFinite,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Divider(),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                      ),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(20.0),
                                          itemCount: statusexercises.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Container(
                                                  width: 300,
                                                  height: 50,
                                                  color: selectedCard == index
                                                      ? Color.fromRGBO(
                                                          247, 207, 205, 1)
                                                      : Color.fromRGBO(
                                                          250, 120, 186, 1),
                                                  child: Center(
                                                    child: Text(
                                                      statusexercises[index]
                                                          .name,
                                                      style: TextStyle(),
                                                    ),
                                                  )),
                                              onTap: () {
                                                setState(() {
                                                  // ontap of each card, set the defined int to the grid view index
                                                  selectedCard = index;
                                                });
                                              },
                                            );
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  value: 2,
                ),
              ]),
    );
  }

}
