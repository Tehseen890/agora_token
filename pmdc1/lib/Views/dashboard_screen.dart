import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:pmdc/Views/attendance_screen.dart';
import 'package:pmdc/Views/classes_screen.dart';
import 'package:pmdc/Views/datesheet_screen.dart';
import 'package:pmdc/Views/exam_screen.dart';
import 'package:pmdc/Views/fee_screen.dart';
import 'package:pmdc/Views/info_screen.dart';
import 'package:pmdc/Views/login_screen.dart';
import 'package:pmdc/Views/notes_screen.dart';
import 'package:pmdc/Views/subject_screen.dart';
import 'package:pmdc/Views/test_screen.dart';
import 'package:pmdc/Views/timetable_screen.dart';
//import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Dashboard_Screen extends StatefulWidget {

  const Dashboard_Screen({Key? key}) : super(key: key);


  @override
  _Dashboard_ScreenState createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  String reg_id = "";
  String password = "";
  String campusid = "";
  double iconsize = 30;

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

 // RandomColor _randomColor = RandomColor();
  Future<void> getdata()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      password =  prefs.getString("password").toString();
      campusid =  prefs.getString("campusid").toString();
    });


  }

  Future<void> logout()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Screen()));


  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

      getdata();
      setState(() {
        profileinfo();
      });

  }
  String _url = 'https://flutter.dev';

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';






  @override
  Widget build(BuildContext context) {

    //Color _color = _randomColor.randomColor();
    return Scaffold(

      //backgroundColor: Colors.grey,
      // floatingActionButton: FloatingActionButton(
      //
      //   onPressed: (){
      //     logout();
      //
      //   },
      //
      //   child: Icon(Icons.exit_to_app,color: Colors.white,),
      //   backgroundColor: Colors.blue,
      //
      // ),
      drawer: Drawer(

        child: Container(
          color: Colors.blueAccent,
          child: SafeArea(
            child: Theme(
              data: ThemeData(brightness: Brightness.dark),
              child: SizedBox(
                //width: width,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/std2.jpg',
                      width: MediaQuery.of(context).size.width,
                    ),
                     ListTile(
                      leading: Icon(Icons.new_releases),
                      title: Text('Timetable'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Timetable_Screen()));
                      },
                    ),
                     ListTile(
                      leading: Icon(Icons.star),
                      title: Text('Attendance'),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance_Screen()));
                       },
                    ),
                     ListTile(
                      leading: Icon(Icons.map),
                      title: Text('Datesheet'),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Datesheet_Screen()));
                       },
                    ),
                     ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('My Subjects'),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Subject_Screen()));
                       },
                    ),
                     ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Test'),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Test_Screen()));
                       },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Examination'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>exam_screen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Info'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Screen()));
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Fee Record'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Fee_Screen()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Sign Out'),
                      onTap: (){
                        logout();
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text("Dashboard",style: TextStyle(color: Colors.black),),
      //   centerTitle: true,
      // ),
     // body: newdesign(),
     body: CustomScrollView(
       slivers: [
         SliverAppBar(
           // leading: InkWell(
           //   child: Icon(Icons.menu),
           //
           //   onTap: () => _key.currentState!.openDrawer(),
           // ),
          // title: Text("Dashboard"),
           actions: <Widget>[
             IconButton(
               onPressed: () => _key.currentState!.openDrawer(),
               icon: Icon(Icons.menu),
             )
           ],
           expandedHeight: 300,
          // floating: true,
           pinned: true,
           flexibleSpace: FlexibleSpaceBar(
             background: Container(
               decoration: BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage(
                           "assets/std.jpg",
                       ),
                       fit: BoxFit.cover
                   )
               ),
             ),
             title: Text("D A S H B O A R D"),
             centerTitle: true,

           ),

         ),
         SliverToBoxAdapter(
           child: Container(
             child:     Container(
                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                 margin: EdgeInsets.symmetric(vertical: 10),
                 // width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height*0.2,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Welcome Back",style: TextStyle(color: Colors.blue),),
                         Text("Name: $name".toUpperCase()),
                         Text("ID: $regno"),
                         Text("Program: $program"),
                         SizedBox(width: 5),
                       ],
                     ),
                     ClipOval(
                       child: Material(
                         color: Colors.transparent,
                         child: Ink.image(
                           image: AssetImage('assets/zaka.jpg'),
                           fit: BoxFit.cover,
                           width: 100,
                           height: 100,
                           child: InkWell(onTap: (){}),
                         ),
                       ),
                     ),

                   ],
                 )
             ),
           ),
         ),

         SliverToBoxAdapter(
           child:  Container(
             margin: EdgeInsets.only(bottom: 10),
             padding: EdgeInsets.symmetric(horizontal: 10),
             child: Row(

               children: [
                 Expanded(child: widgetbuttons("Time Table",Icon(Icons.alarm,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Timetable_Screen()));}),),
                 SizedBox(width: 10),
                 Expanded(child: widgetbuttons("Attendance",Icon(Icons.verified_user,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance_Screen()));}),),
                 SizedBox(width: 10),
                 Expanded(child: widgetbuttons("Date Sheet",Icon(Icons.grid_3x3_sharp,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Datesheet_Screen()));}),),



               ],
             ),
           ),
         ),
         SliverToBoxAdapter(
           child:  Container(
             margin: EdgeInsets.only(bottom: 10),
             padding: EdgeInsets.symmetric(horizontal: 10),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,


               children: [
                 Expanded(child: widgetbuttons("My Subjects",Icon(Icons.book,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Subject_Screen()));}),),
                 SizedBox(width: 10),
                 widgetbuttons("Test",Icon(Icons.reset_tv,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Test_Screen()));}),



               ],
             ),
           ),
         ),
         SliverToBoxAdapter(
           child: Container(
             margin: EdgeInsets.only(bottom: 10),
             padding: EdgeInsets.symmetric(horizontal: 10),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,


               children: [
                 Expanded(child: widgetbuttons("Examination",Icon(Icons.margin,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>exam_screen()));}),),
                 SizedBox(width: 10),
                 widgetbuttons("Info",Icon(Icons.bookmark,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Screen()));}),



               ],
             ),
           ),
         ),
         SliverToBoxAdapter(
           child: Container(
             margin: EdgeInsets.only(bottom: 10),
             padding: EdgeInsets.symmetric(horizontal: 10),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,


               children: [
                 Expanded(child: widgetbuttons("Fee Record",Icon(Icons.addchart,size: iconsize,),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Fee_Screen()));}),),
                 SizedBox(width: 10),
                 widgetbuttons("Sign Out",Icon(Icons.exit_to_app,size: iconsize,),(){logout();}),



               ],
             ),
           ),
         ),

       ],
     ),
    );
  }


  Widget olddesign(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/test.jpg'),
            fit: BoxFit.cover,
          )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widgetbuttons("Dashboard",Icon(Icons.dashboard),(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));}),
              widgetbuttons("Profile",Icon(Icons.person),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Screen()));}),
              widgetbuttons("My Subjects",Icon(Icons.book),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Subject_Screen()));}),


            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widgetbuttons("Time Table",Icon(Icons.alarm),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Timetable_Screen()));}),
              widgetbuttons("Date Sheet",Icon(Icons.pages),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Datesheet_Screen()));}),
              widgetbuttons("My Notes",Icon(Icons.video_library_rounded),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));}),


            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widgetbuttons("My Attendance",Icon(Icons.person_add),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance_Screen()));}),
              widgetbuttons("My Fee Record",Icon(Icons.dynamic_feed),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Fee_Screen()));}),
              widgetbuttons("My Exam",Icon(Icons.addchart),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>exam_screen()));}),


            ],
          ),

        ],
      ),

    );
  }
  Widget newdesign(){

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/test.jpg'),
            fit: BoxFit.cover,
          )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //margin: EdgeInsets.only(top: 40),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
           // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back",style: TextStyle(color: Colors.blue),),
                    Text("Muhammad Zakriya".toUpperCase()),
                    Text("ID: 12280"),
                    Text("Class: XII"),
                    SizedBox(width: 5),
                  ],
                ),
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: AssetImage('assets/zaka.jpg'),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      child: InkWell(onTap: (){}),
                    ),
                  ),
                ),

              ],
            )
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(

              children: [
                Expanded(child: widgetbuttons("Time Table",Icon(Icons.alarm),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Timetable_Screen()));}),),
                SizedBox(width: 10),
                Expanded(child: widgetbuttons("Attendance",Icon(Icons.alarm),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance_Screen()));}),),
                SizedBox(width: 10),
                Expanded(child: widgetbuttons("Date Sheet",Icon(Icons.alarm),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Datesheet_Screen()));}),),



              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,


              children: [
                Expanded(child: widgetbuttons("My Subjects",Icon(Icons.dashboard),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Subject_Screen()));}),),
                SizedBox(width: 10),
                widgetbuttons("Test",Icon(Icons.person),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Test_Screen()));}),



              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,


              children: [
                Expanded(child: widgetbuttons("Examination",Icon(Icons.dashboard),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>exam_screen()));}),),
                SizedBox(width: 10),
                widgetbuttons("Notice Board",Icon(Icons.person),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Screen()));}),



              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,


              children: [
                Expanded(child: widgetbuttons("Fee Record",Icon(Icons.dashboard),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Fee_Screen()));}),),
                SizedBox(width: 10),
                widgetbuttons("Sign Out",Icon(Icons.person),(){logout();}),



              ],
            ),
          ),


          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     widgetbuttons("Time Table",Icon(Icons.alarm),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Timetable_Screen()));}),
          //     widgetbuttons("Date Sheet",Icon(Icons.pages),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Datesheet_Screen()));}),
          //     widgetbuttons("My Notes",Icon(Icons.video_library_rounded),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));}),
          //
          //
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     widgetbuttons("My Attendance",Icon(Icons.person_add),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance_Screen()));}),
          //     widgetbuttons("My Fee Record",Icon(Icons.dynamic_feed),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Fee_Screen()));}),
          //     widgetbuttons("My Exam",Icon(Icons.addchart),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>exam_screen()));}),
          //
          //
          //   ],
          // ),

        ],
      ),

    );
  }
  Widget widgetbuttons(String name, Icon icon, VoidCallback  function){
   // Color _color = _randomColor.randomColor(colorHue: ColorHue.multiple(colorHues: [ColorHue.red, ColorHue.blue]));
    return  InkWell(
      onTap: function,
      child: Container(


        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              color: Colors.black12, //New
              blurRadius: 10.0,
              spreadRadius: 5,
              offset: Offset(
                0,
                3,
              ),
            )
          ]



        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 10,),
            //Icon(Icons.dashboard),
            Text("$name",style: TextStyle(color: Colors.black,fontSize: 10),),
          ],
        ),
      ),
    );
  }
}
