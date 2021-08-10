import 'package:flutter/material.dart';

class WaterpayPage extends StatefulWidget {
  @override
  _WaterpayPageState createState() => _WaterpayPageState();
}
String dropdownValue1 = 'สถานะ';

class _WaterpayPageState extends State<WaterpayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 207, 205, 1),
        centerTitle: true,
        title: Image.asset('img/logo.png'),
      ),

      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Column(
              children : [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                      SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                          backgroundColor:  Color.fromRGBO(250, 120, 186, 1),
                          foregroundColor: Colors.white,
                          onPressed: ()  {
                           print("ok");
                          },
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: FloatingActionButton(

                          child: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          backgroundColor:  Color.fromRGBO(250, 120, 186, 1),
                          foregroundColor: Colors.white,
                          onPressed: () => {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => page7()), )
                          },
                        ),
                      ),
                    ]
                ),

              ],

            ),
            SizedBox(width: 20.0,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      //decoration: kBoxDecorationStyle ,
                      height: 33.0,
                      width: 120.0,
                      child: TextField(
                        style: TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ชื่อบ้านเช่า',
                            labelStyle: new TextStyle(
                                color: const Color.fromRGBO(250, 120, 186, 1)
                            ),
                            // hintText: 'Enter valid mail id as abc@gmail.com'
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Color.fromRGBO(250, 120, 186, 1))
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50.0,
                      width: 90.0,
                      child: DropdownButton<String>(
                        value: dropdownValue1,
                        icon: const Icon(

                          Icons.arrow_circle_down,
                          color: Color.fromRGBO(250, 120, 186, 1),
                        ),
                        iconSize: 18,
                        iconDisabledColor: Color.fromRGBO(250, 120, 186, 1),
                        elevation: 10,
                        style: const TextStyle(
                          color: Color.fromRGBO(250, 120, 186, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',

                        ),
                        underline: Container(
                          width: 10.0,
                          height: 1,
                          color: Color.fromRGBO(250, 120, 186, 1),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                          });
                        },
                        items: <String>['สถานะ', 'จ่ายแล้ว', 'ยังไม่จ่าย']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),

                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  new FlatButton (
                    minWidth: 50.0,
                    height: 30.0,
                    color: Color.fromRGBO(247, 207, 205, 1),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => page6 ()),
                      // );
                    },
                    child: Column(
                      children: [
                        Text("ค้นหา",
                          style: TextStyle(
                            color: Color.fromRGBO(250, 120, 186, 1),
                            fontSize: 16  ,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                    shape: StadiumBorder(
                        side: BorderSide(width: 1.0,color: Color.fromRGBO(250, 120, 186, 1),)
                    ),
                  ),
                ]
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.0,),
                Column(
                  children: [
                    Text("ชื่อผู้เช่า",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0,),
                Column(
                  children: [
                    Text("ชื่อบ้านเช่า",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0,),
                Column(

                  children: [
                    Text("เดือน",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10.0,),
                Column(

                  children: [
                    Text("จำนวน (บาท)",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 120, 186, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
