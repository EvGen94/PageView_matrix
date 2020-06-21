import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:neumorphic_design_app/presentation/widgets/neumorphic_button.dart';

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
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                child: NeumorphicButton(
                  title: 'wow',
                  isLarge: false,
                  onPressed: () {

                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              NeumorphicButton(
                title: 'wow',
                isLarge: true,
                onPressed: () {

                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
