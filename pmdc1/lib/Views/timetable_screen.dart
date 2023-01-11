import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Timetable_Screen extends StatefulWidget {
  const Timetable_Screen({Key? key}) : super(key: key);

  @override
  _Timetable_ScreenState createState() => _Timetable_ScreenState();
}

class ttModel {
  String attachment = '';
  String section = '';
  String campus = '';
  String clas = '';

  ttModel(this.attachment, this.section, this.campus, this.clas);
}

class _Timetable_ScreenState extends State<Timetable_Screen> {
  String reg_id = "";
  String campusid = "";
  List<ttModel> mylist = <ttModel>[];

  bool _isloading = false;
  Future<List<ttModel>> subjectinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ttModel>? order = <ttModel>[];
    setState(() {
      reg_id = prefs.getString("reg_id").toString();
      campusid = prefs.getString("campusid").toString();
    });
    Map map = {
      'action': 'timetable',
      'regid': reg_id,
      'campusid': campusid,
    };
    String url = Link_Model.url + "main.php";
    var response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      print(data);
      data.forEach((e) => order.add(new ttModel(
          e['attachment'], e['Section'], e['CampusID'], e['class'])));
      return order;
    } else {
      print("There is some error");
      return [];
    }
  }

  String _url =
      'https://www.bisegrw.edu.pk/download/notifications/2022/DATE%20SHEET%20SSC%20ANNUAL%202022%20(5%20APRIL).pdf';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

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
        title: Text(
          "Timetable",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        )),
        child: new ListView(
          children: [
            new Column(
              children: mylist.map((e) {
                return Card(
                  elevation: 10,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Text(
                              'Class '.toUpperCase() + e.clas.toUpperCase()),
                          subtitle: Text('Section '.toUpperCase() +
                              e.section.toUpperCase()),
                        ),
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
                          child: Text(
                            e.attachment,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        TextButton(
                          child: Text('Download file'),
                          onPressed: _launchURL,
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0))),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
