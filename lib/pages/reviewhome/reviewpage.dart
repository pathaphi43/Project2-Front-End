import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {


  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
          padding: const EdgeInsets.all(40.0),
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color.fromRGBO(250, 120, 186, 1),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),


            SizedBox(height: 20),
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'เขียนข้อความ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //SizedBox(height: 20),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    IconButton(
                      onPressed: () async{
                      },
                      icon: const Icon(
                        Icons.image,
                      ),
                      iconSize: 200,
                      color: Color.fromRGBO(247, 207, 205, 1),

                    ),
                  ]

              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child :
                  new FlatButton (
                    minWidth: 120.0,
                    height: 50.0,
                    color: Color.fromRGBO(247, 207, 205, 1),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => page18()),
                      // );
                    },
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ยืนยัน",
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
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child :
                  new FlatButton (
                    minWidth: 120.0,
                    height: 50.0,
                    // color: Color.fromRGBO(247, 207, 205, 1),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => page18()),
                      // );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ยกเลิก",
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
                ),
              ],
            ) ,
          ],
        ),
      ),
    );
  }
}
