import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';
import 'package:url_launcher/url_launcher.dart';


class Test_Screen extends StatefulWidget {
  const Test_Screen({Key? key}) : super(key: key);

  @override
  _Test_ScreenState createState() => _Test_ScreenState();
}

class _Test_ScreenState extends State<Test_Screen> {

  //Decode your json string
  String myjson = '';
  final String jsonSample='[{"name":"Ram","email":"ram@gmail.com","age":23,"DOB":"1990-12-01"},'
      '{"name":"Shyam","email":"shyam23@gmail.com","age":18,"DOB":"1995-07-01"},'
      '{"name":"John","email":"john@gmail.com","age":10,"DOB":"2000-02-24"},'
      '{"name":"Ram","age":12,"DOB":"2000-02-01"}]';

  var columns = [
    JsonTableColumn("regno", label: "regno"),
    JsonTableColumn("name", label: "name"),
    JsonTableColumn("fname", label: "fname"),
    JsonTableColumn("program", label: "program"),
    JsonTableColumn("session", label: "session"),

  ];

  bool _isloading = false;


  Future<void> profileinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map map = {
      'action': 'fee',
      'regid':prefs.getString('regid').toString(),
      'campusid':prefs.getString('campusid').toString(),
    };
    String url = Link_Model.url + "main.php";
    var response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['status'] == "Success"){
       // print(data['0'].toString());
       setState(() {


       });
      }else{
        print("Data Failed");
      }
    } else {
      print("There is some error");

    }

  }

  String _url = 'https://www.bisegrw.edu.pk/download/notifications/2022/DATE%20SHEET%20SSC%20ANNUAL%202022%20(5%20APRIL).pdf';
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';




  @override
  void initState() {
    // TODO: implement initState
    profileinfo();
  }


  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    print(json);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Tests",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ElevatedButton(onPressed: _launchURL, child: Text("Download Test Details",style: TextStyle(fontSize: 30),)),
            ],
          )
      ),
    );
  }
}
