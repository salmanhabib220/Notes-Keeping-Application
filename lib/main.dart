import 'package:flutter/material.dart';
import 'package:note_keeper_app/Pages/Notelist.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note Keep",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Notelist(),
    );
  }
}
