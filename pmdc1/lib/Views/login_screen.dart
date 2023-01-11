import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:pmdc/Views/Teacher/dashboard_teacher.dart';
import 'package:pmdc/Views/dashboard_screen.dart';
import 'package:pmdc/Views/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  String id = "";
  String password = "";
  String campuseid = "0";
  // String role = "";
  bool _isloading = false;
  bool _isstudent = true;

  int? _radioValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _isstudent = true;

          break;
        case 1:
          _isstudent = false;

          break;
      }
    });
  }

  Future<void> loginteacher() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map map = {
      'action': 'login',
      'regid': '$id',
      'password': '$password',
      'campusid': '$campuseid',
      'role': 'Employee',
    };
    String url = Link_Model.url + "main.php";
    var response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      if (data['status'] == "Success") {
        await prefs.setString('reg_id', id);
        await prefs.setString('password', password);
        await prefs.setString('campusid', campuseid);
        await prefs.setString('isstudent', _radioValue.toString());
        setState(() {
          _isloading = false;
        });
        //print("Logged in");
        print(prefs.get('reg_id'));
        print(prefs.get('password'));
        print(prefs.get('campusid'));
        if (prefs.get('campusid').toString().isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboard_Teacher()));
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));
      } else {
        setState(() {
          _isloading = false;
        });
        print("Logged in Faile3d");
      }
    } else {
      print("There is some error");
    }

    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Teacher()));
  }

  Future<void> loginstd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map map = {
      'action': 'login',
      'regid': '$id',
      'password': '$password',
      'campusid': '$campuseid',
      'role': 'Student',
    };
    String url = Link_Model.url + "main.php";
    var response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      if (data['status'] == "Success") {
        await prefs.setString('reg_id', id);
        await prefs.setString('password', password);
        await prefs.setString('campusid', campuseid);
        await prefs.setString('isstudent', _radioValue.toString());
        setState(() {
          _isloading = false;
        });
        //print("Logged in");
        print(prefs.get('reg_id'));
        print(prefs.get('password'));
        print(prefs.get('campusid'));
        if (prefs.get('campusid').toString().isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboard_Screen()));
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));
      } else {
        setState(() {
          _isloading = false;
        });
        print("Logged in Faile3d");
      }
    } else {
      print("There is some error");
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("PMDC Boys Dalazak Road"), value: "0"),
      DropdownMenuItem(child: Text("PMDC Girls Dalazak Road"), value: "1"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _isloading == true
          ? Container(
              alignment: Alignment.center,
              child: SpinKitFadingCircle(
                color: Colors.black,
                size: 100.0,
              ),
            )
          : Container(
              height: height,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.45,
                      height: height * 0.26,
                      child: Image.asset(
                        'assets/yoga.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     hintText: 'CampusId',
                    //     suffixIcon: Icon(Icons.email),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //
                    //   ),
                    //   onChanged: (value){
                    //     setState(() {
                    //
                    //       campuseid = value;
                    //     });
                    //   },
                    // ),

                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Select Role',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Student',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Faculty & Other',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                        value: campuseid,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        onChanged: (String? value) {
                          setState(() {
                            campuseid = value.toString();
                          });
                        },
                        items: dropdownItems),
                    SizedBox(
                      height: 30.0,
                    ),

                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Registration Id',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          id = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      margin: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard_Screen()));
                          // if (_isstudent) {
                          //   setState(() {
                          //     _isloading = true;
                          //   });
                          //   loginstd();
                          // } else {
                          //   loginteacher();
                          // }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).accentColor),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text('',style: TextStyle(fontSize: 12.0),),
                    //       RaisedButton(
                    //         child: Text('Login'),
                    //         color: Color(0xffEE7B23),
                    //         onPressed: (){
                    //           setState(() {
                    //             _isloading = true;
                    //           });
                    //           loginstd();
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
    );
  }
}
