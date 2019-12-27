import 'package:flutter/material.dart';
import 'package:qr_app/src/pages/home_page.dart';

import 'package:flutter/services.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home'  :(BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
    );
  }
}