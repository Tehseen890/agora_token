import 'package:flutter/material.dart';
import 'package:pmdc/Views/Teacher/assignments_teacher.dart';
import 'package:pmdc/Views/Teacher/changepass_teacher.dart';
import 'package:pmdc/Views/Teacher/course_content.dart';
import 'package:pmdc/Views/Teacher/course_outline.dart';
import 'package:pmdc/Views/Teacher/courses_teacher.dart';
import 'package:pmdc/Views/Teacher/info_teacher.dart';
import 'package:pmdc/Views/Teacher/lectures_teacher.dart';
import 'package:pmdc/Views/fee_screen.dart';
import 'package:pmdc/Views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:badges/badges.dart';

import 'announcements_teacher.dart';

class Dashboard_Teacher extends StatefulWidget {
  const Dashboard_Teacher({Key? key}) : super(key: key);

  @override
  _Dashboard_TeacherState createState() => _Dashboard_TeacherState();
}

class _Dashboard_TeacherState extends State<Dashboard_Teacher> {


  Future<void> logout()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Screen()));


  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();




  @override
  Widget build(BuildContext context) {
    //Color _color = _randomColor.randomColor();
    return SafeArea(child: Scaffold(

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
                      'assets/teacher1.jpg',
                      width: MediaQuery.of(context).size.width,
                    ),
                    ListTile(
                        leading: Icon(Icons.new_releases),
                        title: Text('Courses'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Courses_Teacher()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Course Content'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Course_Content()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.map),
                        title: Text('Course Outline'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Course_Outline()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('My Lectures'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Lecture_teacher()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Assignments'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Assignment_teacher()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Announcements'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Annoucements_teacher()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Change Password'),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Changepass_Teacher()));}
                    ),
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Sign Out'),
                        onTap: (){logout();}
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
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text("Faculty Dashboard",style: TextStyle(color: Colors.white),),
      //   centerTitle: true,
      // ),
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

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
                margin: EdgeInsets.only(right: 20,top: 5),
                padding: EdgeInsets.only(right: 20,top: 5),
                child:  InkWell(
                  onTap: (){},
                    child:  Badge(
                      badgeContent: Text(' '),
                      child: Icon(Icons.notifications,size: 30,),
                    )
                ),
              ),
            ],
            expandedHeight: 300,
            // floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/teacher2.jpg",
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
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(

                children: [
                  Expanded(child: widgetbuttons("Courses",FaIcon(FontAwesomeIcons.bookJournalWhills), (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Courses_Teacher()));}),),
                  SizedBox(width: 10),
                  Expanded(child: widgetbuttons("Course Content",FaIcon(FontAwesomeIcons.book),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Course_Content()));}),),
                  SizedBox(width: 10),
                  Expanded(child: widgetbuttons("Course Outline",FaIcon(FontAwesomeIcons.table),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Course_Outline()));}),),



                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                children: [
                  Expanded(child: widgetbuttons("My Lectures",FaIcon(FontAwesomeIcons.book),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Lecture_teacher()));}),),
                  SizedBox(width: 10),
                  widgetbuttons("Assignments",FaIcon(FontAwesomeIcons.noteSticky),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Assignment_teacher()));}),



                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                children: [
                  Expanded(child: widgetbuttons("Announcements",FaIcon(FontAwesomeIcons.umbrellaBeach),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Annoucements_teacher()));}),),
                  SizedBox(width: 10),
                  widgetbuttons("Change Password",FaIcon(FontAwesomeIcons.signIn),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Changepass_Teacher()));}),



                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                children: [
                  Expanded(child: widgetbuttons("My Info",FaIcon(FontAwesomeIcons.info),(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Teacher()));}),),
                  SizedBox(width: 10),
                  widgetbuttons("Sign Out",FaIcon(FontAwesomeIcons.doorClosed),(){logout();}),



                ],
              ),
            ),
          ),


        ],
      ),
    ));
  }


  Widget widgetbuttons(String name, FaIcon icon, VoidCallback  function){
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
