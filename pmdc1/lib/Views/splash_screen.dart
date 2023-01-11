import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pmdc/Views/Teacher/dashboard_teacher.dart';
import 'package:pmdc/Views/dashboard_screen.dart';
import 'package:pmdc/Views/login_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {


  Future<void> checklogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('working');
    if( prefs.get('reg_id') != null  ){
      if(prefs.get('isstudent') == '0'){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            // Login_Screen()
            Dashboard_Screen()));
      }else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            // Login_Screen()
            Dashboard_Teacher()));

      }


    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
          // Login_Screen()
          Login_Screen()));
    }



  }






  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            (){
              checklogin();
            }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/yoga.png'),
              Text('Loading'),
              SizedBox(height: 10,),
              SpinKitDualRing(
                size: 30,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
