import 'package:flutter/material.dart';
import 'screens/screen01.dart';
import 'screens/screen02.dart';
import 'screens/screen03.dart';
import 'screens/screen04.dart';
import 'screens/screen05.dart';
import 'screens/screen06.dart';
import 'screens/screen07.dart';
import 'screens/screen08.dart';
import 'screens/screen09.dart';
import 'screens/screen10.dart';
import 'screens/screen11.dart';

void main() {
  runApp(BookLoopApp());
}

class BookLoopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookLoop Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Screen01(),
        '/screen02': (context) => Screen02(),
        '/screen03': (context) => Screen03(),
        '/screen04': (context) => Screen04(),
        '/screen05': (context) => Screen05(),
        '/screen06': (context) => Screen06(),
        '/screen07': (context) => Screen07(),
        '/screen08': (context) => Screen08(),
        '/screen09': (context) => Screen09(),
        '/screen10': (context) => Screen10(),
        '/screen11': (context) => Screen11(),
      },
    );
  }
}
