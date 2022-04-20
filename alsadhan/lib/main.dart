import 'dart:async';
import 'package:alsadhan/localization/app_translations_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home/home_screen.dart';
import 'localization/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/app_translations_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Directionality(textDirection: TextDirection.rtl,child: MyHomePage(title: 'Al- sadhan')),

      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  navigatePage() {
    // Navigator.of(context)
    //     .pushReplacement(new MaterialPageRoute(builder: (context) => LoginScreen()));

    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  splashMove() {
    return Timer(Duration(seconds: 3), navigatePage);
  }

  @override
  void initState() {
    super.initState();
    splashMove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Alsadhan_banner1.jpg"),
          fit: BoxFit.fill
        ) ,
      ),
    )
      // FittedBox(
      //     fit: BoxFit.fill,
      //         child: Image( height:1200,
      //           image: AssetImage("images/Alsadhan_banner1.jpg"),
      //         ),
      // )
    );
  }

}
