import 'package:flutter/material.dart';

class Classes_Screen extends StatefulWidget {
  const Classes_Screen({Key? key}) : super(key: key);

  @override
  _Classes_ScreenState createState() => _Classes_ScreenState();
}

class _Classes_ScreenState extends State<Classes_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("My Classes",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
