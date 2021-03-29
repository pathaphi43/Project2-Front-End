import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  //50, 0, 50, 10
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('เพิ่มข้อมูลผู้เช่า')),
      ),
      body: Center(
        child: Container(
          child: Card(
            color: Colors.grey[200],
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 55, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.account_box,
                          size: 100,
                        ),
                        onPressed: () => null,
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 55, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'ชื่อ',
                            prefixIcon: Icon(Icons.account_circle)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'นามสกุล',
                            prefixIcon: Icon(Icons.account_circle)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'เลขบัตรประชาชน',
                            prefixIcon: Icon(Icons.assignment_ind_outlined)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'เบอร์โทร',
                            prefixIcon: Icon(Icons.phone)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail_outline)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.account_circle_outlined)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                      child: TextField(
                        obscureText: true,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded)),
                        controller: null, //ส่งข้อมูลTextField
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                          onPressed: () => null,
                          child: Text('เพิ่มผู้เช่า'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black45),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(200, 45)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.blue)),
                              ))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
