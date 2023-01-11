import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Datesheet_Screen extends StatefulWidget {
  const Datesheet_Screen({Key? key}) : super(key: key);

  @override
  _Datesheet_ScreenState createState() => _Datesheet_ScreenState();
}

class _Datesheet_ScreenState extends State<Datesheet_Screen> {


  String _url = 'https://www.bisegrw.edu.pk/download/notifications/2022/DATE%20SHEET%20SSC%20ANNUAL%202022%20(5%20APRIL).pdf';
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Datesheet",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            ElevatedButton(onPressed: _launchURL, child: Text("Download Date Sheet",style: TextStyle(fontSize: 30),)),
          ],
        )
      ),
    );
  }
}
