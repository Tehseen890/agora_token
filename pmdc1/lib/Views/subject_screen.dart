import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;

class Subject_Screen extends StatefulWidget {
  const Subject_Screen({Key? key}) : super(key: key);

  @override
  _Subject_ScreenState createState() => _Subject_ScreenState();
}

class subjectModel{
  String subjectname = '';
  String isurdu = '';
  subjectModel(this.subjectname,this.isurdu);

}

class _Subject_ScreenState extends State<Subject_Screen> {
  String reg_id = "";
  String campusid = "";


  List<subjectModel> mylist = <subjectModel>[];

  bool _isloading = false;
  Future<List<subjectModel>> subjectinfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<subjectModel>? order = <subjectModel>[];
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });
      Map map = {
        'action': 'subject',
        'regid':reg_id,
        'campusid':campusid,
      };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new subjectModel(e['SubjectName'],e['isUrdu'],)));
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
        title: Text("My Subjects",style: TextStyle(color: Colors.black),),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            )
        ),
        child: ListView(
          children: [
            Column(
              children: mylist.map((e){
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color:Colors.pink,width: 10),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white24,
                            offset: Offset(5,5),
                          blurRadius: 10,
                          spreadRadius: 10,

                        )
                      ]
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  child: ListTile(title: Text('Subject Name'),subtitle:
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      Colors.red,
                    ],
                  ),

                   // color: Colors.blue,

                    borderRadius: BorderRadius.circular(50),
                ),

                    child:  Text(e.subjectname,style: TextStyle(fontSize: 20,color: Colors.white),),)
                  ),
                );
              }).toList(),
            )
            // ListTile(title: Text("Biology"),onTap: (){},),
            // Divider(thickness: 1,),
            // ListTile(title: Text("Physics"),onTap: (){},),
            // Divider(thickness: 1,),
            // ListTile(title: Text("Maths"),onTap: (){},),
            // Divider(thickness: 1,),
          ],
        ),
      ),
    );
  }
}
