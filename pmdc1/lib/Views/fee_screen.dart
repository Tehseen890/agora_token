import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmdc/Models/link_model.dart';
import 'package:http/http.dart' as http;

class Fee_Screen extends StatefulWidget {
  const Fee_Screen({Key? key}) : super(key: key);

  @override
  _Fee_ScreenState createState() => _Fee_ScreenState();
}
class feeModel{
  String subhead = '';
  String month = '';
  String year = '';
  String amount = '';
  String ispaid = '';
  String status = '';
  feeModel(this.subhead,this.month,this.year,this.amount,this.ispaid,this.status);

}
class _Fee_ScreenState extends State<Fee_Screen> {
  String reg_id = "";
  String campusid = "";
  List<feeModel> mylist = <feeModel>[];

  bool _isloading = false;
  Future<List<feeModel>> subjectinfo()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<feeModel>? order = <feeModel>[];
    setState(() {
      reg_id =   prefs.getString("reg_id").toString();
      campusid =  prefs.getString("campusid").toString();
    });
    Map map = {
      'action': 'fee',
      'regid':reg_id,
      'campusid':campusid,
    };
    String url = Link_Model.url+"main.php";
    var response = await http.post(Uri.parse(url),body: map);
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      print (data);
      data.forEach((e)=>order.add(new feeModel(e['Subhead'],e['Month'],e['Year'],e['FeeAmount'],e['IsPaid'],e['ReceiveDate'],)));
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
        title: Text("My Fee",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: new Container(
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
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        ListTile(title: Text(e.month),subtitle: Text(e.status),leading: Text(e.year),),
                        Text(e.amount,style: TextStyle(fontSize: 30),),

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
