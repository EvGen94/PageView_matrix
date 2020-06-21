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
                height: 15,
              ),
              Container(
                width: 300,
                height: 300,
                child: NeumorphicButton(
                  title: 'wow wow wow wow wow',
                  isLarge: false,
                  onPressed: () {

                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              NeumorphicButton(
                title: 'wow wow wow wow wow',
                isLarge: true,
                onPressed: () {

                },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
