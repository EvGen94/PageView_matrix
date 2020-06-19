import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:neumorphic_design_app/presentation/widgets/neumorphic_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NeuAppBar(
        title: Text('Neumorphic Design'),
      ),
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: NeumorphicContainer(
          child: Text(
            'wow',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
