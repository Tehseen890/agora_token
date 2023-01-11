import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Notifications_Teacher extends StatefulWidget {
  const Notifications_Teacher({Key? key}) : super(key: key);

  @override
  _Notifications_TeacherState createState() => _Notifications_TeacherState();
}
class coursesModel{
  String coursename = '';
  String section = '';



  coursesModel(this.coursename,this.section);

}
class _Notifications_TeacherState extends State<Notifications_Teacher> {

  String reg_id = "";
  String campusid = "";
  List<coursesModel> mylist = <coursesModel>[];

  bool _isloading = false;
  Future<List<coursesModel>> subjectinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<coursesModel>? order = <coursesModel>[];
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });
    Map map = {
      'action': 'courses',
      'regid':reg_id,

    };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new coursesModel(e['course_name'],e['section'])));
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
    subjectinfo().then((value) {
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
        centerTitle: true,
        title: Text("Courses",style: TextStyle(color: Colors.black),),

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
                        ListTile(title: Text(' '+e.coursename),subtitle: Text('Section '+e.section),trailing: ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.book, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.blue, // <-- Button color
                            onPrimary: Colors.red, // <-- Splash color
                          ),
                        ),onTap: ()async{

                          const url = 'https://google.com';

                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },



                        ),


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
