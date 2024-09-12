import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskaDBApp',
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Color(0xff01c851),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          //ICONOS POR ENCIMA DEL APPBAR:
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //   backgroundColor: Color(0xff01c851),
        // ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
