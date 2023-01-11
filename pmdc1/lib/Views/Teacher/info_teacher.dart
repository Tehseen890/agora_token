import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;

class Info_Teacher extends StatefulWidget {
  const Info_Teacher({Key? key}) : super(key: key);

  @override
  _Info_TeacherState createState() => _Info_TeacherState();
}

class _Info_TeacherState extends State<Info_Teacher> {



  String reg_id = "";
  String campusid = "";

  bool _isloading = false;
  String name = '';
  String fname = '';
  String regno = '';
  String dob = '';
  String program = '';
  String section = '';


  Future<void> profileinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });

    Map map = {
      'action': 'info',
      'regid': reg_id,
      'campusid':campusid,
    };
    String url = Link_Model.url + "main.php";
    var response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['status'] == "Success"){
        print(data['0'].toString());
        setState(() {
          name = data['0']['name'];
          fname = data['0']['fname'];
          regno = data['0']['regno'];
          dob = data['0']['dob'];
          program = data['0']['program'];
          section = data['0']['section'];
        });
      }else{
        print("Data Failed");
      }
    } else {
      print("There is some error");

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      profileinfo();
    });

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("My Profile",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: reg_id.endsWith('80')?AssetImage('assets/bg.png'):AssetImage('assets/profile.jpg.png'),
              fit: BoxFit.cover,
            )
        ),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children:[ Column(
              children: [
                SizedBox(height: 20,),
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: AssetImage('assets/zaka.jpg'),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      child: InkWell(onTap: (){}),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),

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

                  child:  Text(name,style: TextStyle(fontSize: 20,color: Colors.white),),)


              ],
            ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                //height: 30,
                child: Container(
                  padding: EdgeInsets.all(10),
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

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Card(elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  ListTile(title: Text('Father Name'),subtitle: Text('$fname',style:TextStyle(fontSize: 20,),),),),
                      Card(elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  ListTile(title: Text('Registration No'),subtitle: Text('$regno',style:TextStyle(fontSize: 20,),),),),
                      Card(elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  ListTile(title: Text('Date of Birth'),subtitle: Text('$dob',style:TextStyle(fontSize: 20,),),),),
                      Card(elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  ListTile(title: Text('Program'),subtitle: Text('$program',style:TextStyle(fontSize: 20,),),),),
                      Card(elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  ListTile(title: Text('Section'),subtitle: Text('$section',style:TextStyle(fontSize: 20,),),),),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );

  }
}
