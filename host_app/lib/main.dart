// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:mini2/route_generator.dart';
import 'package:supper_app/supper_app.dart';

void main() {
  ModuleManagement().addModules([
    Mini2Route(),
  ]);
  runApp(const MyApp());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future delay() async {
      await Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.of(context).pushNamed('haha/FirstScreen');
      });
    }

    delay();
    return Scaffold(
        appBar: AppBar(title: const Text('This is the secoind screen')),
        body: const Text(
          'Home page',
          textScaleFactor: 2,
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: ModuleManagement().onGenerateRoute,
      home: DefaultRoute.splashScreen(const HomeScreen()),
    );
  }
}
