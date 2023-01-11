import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;


class Lecture_teacher extends StatefulWidget {
  const Lecture_teacher({Key? key}) : super(key: key);

  @override
  _Lecture_teacherState createState() => _Lecture_teacherState();
}

class coursesModel{
  String coursename = '';
  String section = '';



  coursesModel(this.coursename,this.section);

}

class _Lecture_teacherState extends State<Lecture_teacher> {

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
      'action': 'notes',
      'regid':reg_id,
      'campusid':campusid,
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
        title: Text("Lectures",style: TextStyle(color: Colors.black),),

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
                        ListTile(title: Text(' '+e.coursename),subtitle: Text('Section '+e.coursename),trailing: ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.book, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.blue, // <-- Button color
                            onPrimary: Colors.red, // <-- Splash color
                          ),
                        ),



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
