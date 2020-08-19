import 'package:flutter/material.dart';
import 'package:tccapp/ui/home_page.dart';
import 'package:tccapp/ui/login_page.dart';
import 'package:tccapp/ui/register_page.dart';

void main(){
  runApp(MaterialApp(
    home: LoginPage(),
    routes: <String, WidgetBuilder> {
      '/home': (BuildContext context) => HomePage(),
      '/login': (BuildContext context) => LoginPage(),
      '/register': (BuildContext context) => RegisterPage()
    },
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.blueAccent
      ),
      scaffoldBackgroundColor: Colors.lightBlue[100],
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        )
      )
    ),
    debugShowCheckedModeBanner: false,
  ));
}