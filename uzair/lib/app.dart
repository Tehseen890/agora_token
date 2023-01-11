import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uzair/ui/object_detection_page.dart';

class MyApp extends HookWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'MyApp',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark(),
      ),
      navigatorKey: GlobalKey<NavigatorState>(),
      initialRoute: ObjectDetectionPage.routeName,
      routes: {
        ObjectDetectionPage.routeName: (context) => ObjectDetectionPage(),
      },
    );
  }
}
