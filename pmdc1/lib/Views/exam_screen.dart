import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;


class exam_screen extends StatefulWidget {
  const exam_screen({Key? key}) : super(key: key);

  @override
  _exam_screenState createState() => _exam_screenState();
}

class examModel{
  String rollno = '';
  String term = '';
  String institute = '';
  String board = '';
  String year = '';
  String marks = '';
  String tmarks = '';
  String grade = '';

  examModel(this.rollno,this.term,this.institute,this.board,this.year,this.marks,this.tmarks,this.grade);

}

class _exam_screenState extends State<exam_screen> {

  String reg_id = "";
  String campusid = "";
  List<examModel> mylist = <examModel>[];

  bool _isloading = false;
  Future<List<examModel>> subjectinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<examModel>? order = <examModel>[];
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });
    Map map = {
      'action': 'examination',
      'regid':reg_id,
      'campusid':campusid,
    };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new examModel(e['RollNo'],e['Term'],e['Institute'],e['Board'],e['Year'],e['MarksObtain'],e['TotalMarks'],e['Grade'])));
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),

        elevation: 0,
        title: Text("Exam Details",style: TextStyle(color: Colors.black),),
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
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          ListTile(title: Text('Roll No '+e.rollno),subtitle: Text('Board '+e.board),trailing: Container(
                            width: 120,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.blue,
                                ],
                              ),

                              // color: Colors.blue,

                              borderRadius: BorderRadius.circular(50),
                            ),

                            child:  Text(e.term,style: TextStyle(fontSize: 20,color: Colors.white),),),),
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

                            child:  Text('Marks '+e.marks+' out of '+e.tmarks,style: TextStyle(fontSize: 20,color: Colors.white),),),
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.lightGreen,
                                ],
                              ),

                              // color: Colors.blue,

                              borderRadius: BorderRadius.circular(50),
                            ),

                            child:  Text(' Grade '+e.grade,style: TextStyle(fontSize: 20,color: Colors.white),),),


                         // Text(' Grade '+e.grade,style: TextStyle(fontSize: 30),),

                        ],
                      ),
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
