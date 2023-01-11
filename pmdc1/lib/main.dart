import 'package:flutter/material.dart';
import 'package:pmdc/Views/login_screen.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pmdc/Views/splash_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash_Screen(),
    );
  }
}

