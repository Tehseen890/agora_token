import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Changepass_Teacher extends StatefulWidget {
  const Changepass_Teacher({Key? key}) : super(key: key);

  @override
  _Changepass_TeacherState createState() => _Changepass_TeacherState();
}

class _Changepass_TeacherState extends State<Changepass_Teacher> {
  bool _isloading = false;
  String oldpassword = "";
  String newpassword = "";
  String confirmpassword = "";
  bool _isHidden = true;
  bool _isHidden1 = true;
  bool _isHidden2 = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  void _togglePasswordView3() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  Future<void> updatepass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newpassword == confirmpassword) {
      print("Updated");
      Map map = {
        'action': 'changepass',
        'regno': prefs.getString('reg_id').toString(),
        'password': '$newpassword',
      };

      String url = Link_Model.url + "main.php";
      var response = await http.post(Uri.parse(url), body: map);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        if (data['status'] == "Success") {
          print("Updated");
          await prefs.setString('password', newpassword);
          await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Message'),
              content: Text('New Password Updated'),
              actions: <Widget>[
                new TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pop(); // dismisses only the dialog and returns nothing
                  },
                  child: new Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } else {
      print("Password didnt matched");
    }
  }

  Future<void> chkoldpass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (oldpassword == prefs.getString("password")) {
      updatepass();
    } else {
      print("Not matched");
    }

    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard_Teacher()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
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

                    SizedBox(
                      height: 30.0,
                    ),

                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),

                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        hintText: 'Old Password',
                        //suffixIcon: Icon(Icons.visibility_off),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          oldpassword = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      obscureText: _isHidden1,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        suffix: InkWell(
                          onTap: _togglePasswordView2,
                          child: Icon(
                            _isHidden1
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newpassword = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      obscureText: _isHidden2,
                      decoration: InputDecoration(
                        hintText: 'Confirm New Password',
                        suffix: InkWell(
                          onTap: _togglePasswordView3,
                          child: Icon(
                            _isHidden2
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          confirmpassword = value;
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
                          chkoldpass();
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
