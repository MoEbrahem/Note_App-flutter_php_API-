import 'package:flutter/material.dart';
import 'package:flutter_php/app/auth/fails.dart';
import 'package:flutter_php/app/auth/login.dart';
import 'package:flutter_php/app/auth/signup.dart';
import 'package:flutter_php/app/auth/success.dart';
import 'package:flutter_php/app/home.dart';
import 'package:flutter_php/app/notes/add.dart';
import 'package:flutter_php/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/services.dart';

late SharedPreferences sharedPref ;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  sharedPref = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  runApp( MyApp());
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
      title: 'PhP Rest API',
      initialRoute: sharedPref.getString("id") == null ? "login" : "Home",
      routes: {
        "login" : (context)=> Login(),
        "Signup" : (context)=> SignUp(),
        "Home" : (context)=> Home(),
        "Success":(context)=>Success(),
        "Fails":(context)=>Fails(),
        "add":(context) =>AddNotes(),
        "edit":(context) => EditNotes(),

      },

      home: Login(),
    );
  }
}
 
