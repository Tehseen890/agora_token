import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;

class Course_Content extends StatefulWidget {
  const Course_Content({Key? key}) : super(key: key);

  @override
  _Course_ContentState createState() => _Course_ContentState();
}

class coursesModel{
  String weekno = '';
  String topic = '';



  coursesModel(this.weekno,this.topic);

}

class _Course_ContentState extends State<Course_Content> {

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
      'action': 'coursecontent',
      'course_id':"1",
      'section':"A",
    };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new coursesModel(e['week_no'],e['topics'])));
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
        title: Text("Course Content",style: TextStyle(color: Colors.black),),

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
                        ListTile(
                          contentPadding: EdgeInsets. symmetric(horizontal: 10,vertical: 10),
                         // subtitle: Text(' '+e.weekno),
                          title: ReadMoreText('Section '+e.topic,style: TextStyle(color: Colors.black),trimLines: 1,
                          colorClickableText: Colors.black,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          leading: ElevatedButton(
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
