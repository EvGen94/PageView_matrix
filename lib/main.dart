import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:neumorphic_design_app/presentation/pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeuApp(
      title: 'Neumorphic App',
      theme: NeuThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade300,
        ),
        backgroundColor: Colors.blueGrey.shade200,
        scaffoldBackgroundColor: Colors.blueGrey.shade200,
        dialogBackgroundColor: Colors.blueGrey.shade200,
      ),
      home: const MainPage(),
    );
  }
}
