import 'package:flutter/material.dart';
import 'package:simple_crud/ejercicio1/suma.dart';

import 'package:simple_crud/ejercicio2/home_insert.dart';

final String DB_NAME = "contactos1";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Suma.tag: (context) => Suma(),
    '/home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: Suma(),
      routes: routes,
    );
  }
}
