import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class notesModel{
  String subject = '';
  String clas = '';
  String teacher = '';
  String file = '';


  notesModel(this.subject,this.clas,this.teacher,this.file);

}


class _NotesScreenState extends State<NotesScreen> {

  String reg_id = "";
  String campusid = "";
  List<notesModel> mylist = <notesModel>[];

  bool _isloading = false;
  Future<List<notesModel>> subjectinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<notesModel>? order = <notesModel>[];
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
      data.forEach((e)=>order.add(new notesModel(e['subject'],e['class'],e['teacherName'],e['fileName'])));
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
        title: Text("Notes Details",style: TextStyle(color: Colors.black),),
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
                        ListTile(title: Text('Roll No '+e.subject),subtitle: Text('Teacher '+e.teacher),trailing: ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.download, color: Colors.white),
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
