import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;

class Attendance_Screen extends StatefulWidget {
  const Attendance_Screen({Key? key}) : super(key: key);

  @override
  _Attendance_ScreenState createState() => _Attendance_ScreenState();
}

class aModel{
  String session = '';
  String date = '';
  String status = '';

  aModel(this.session,this.date,this.status);

}

class _Attendance_ScreenState extends State<Attendance_Screen> {

  String reg_id = "";
  String campusid = "";
  List<aModel> mylist = <aModel>[];

  bool _isloading = false;
  Future<List<aModel>> attendanceinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<aModel>? order = <aModel>[];
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });
    Map map = {
      'action': 'attendance',
      'regid':reg_id,
      'campusid':campusid,
    };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new aModel(e['Session'],e['Dated'],e['Status'])));
      return order;
    }else{
      print("There is some error");
      return [];
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attendanceinfo().then((value) {
      setState(() {
        mylist = value;
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Attendance",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            )
        ),
        child: new ListView(
          children: [
            new Column(
              children: mylist.map((e){
                return Card(
                  elevation: 8,
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        ListTile(title: Text('Dated '+e.date),subtitle: Text('Status  '+e.status),trailing: e.status.contains('Present')? ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.bookmark_added, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.green, // <-- Button color
                            onPrimary: Colors.red, // <-- Splash color
                          ),
                        ):ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.bookmark_remove, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.red, // <-- Button color
                            onPrimary: Colors.red, // <-- Splash color
                          ),
                        ),),


                      ],
                    ),
                  ),
                );
              }).toList(),            ),
          ],
        ),
      ),
    );
  }
}
