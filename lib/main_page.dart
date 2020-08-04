import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> listWidget = List<Widget>();
  List<List<Widget>> listOfLists = List<List<Widget>>();



   var _controllerRow = PageController();

  var _controllerColumn = PageController();

  List<Widget> _getNeumorphicButton(int index) {
    for (int i = 0; i < 8; i++) {
      listWidget.add(_buildNeumorphicButton(i + 1));
    }
    listOfLists.add(listWidget);
    listWidget = List<Widget>();

    return listOfLists[index];
  }

  @override
  Widget build(BuildContext context) {
   
    _controllerRow = PageController(
      viewportFraction: 0.353 * (MediaQuery.of(context).size.height/MediaQuery.of(context).size.width) + 0.254,);
     // viewportFraction: 1);
    
     _controllerColumn = PageController(
      viewportFraction: -0.128 * (MediaQuery.of(context).size.height/MediaQuery.of(context).size.width) + 1.1,);
      //viewportFraction: 0.865);
    

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: PageView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(0),
                  //  physics: NeverScrollableScrollPhysics(),
                  controller: _controllerRow,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(1),
                  //   physics: NeverScrollableScrollPhysics(),
                  controller: _controllerRow,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(2),
                  //  physics: NeverScrollableScrollPhysics(),
                  controller: _controllerRow,
                ),
              ),
            ],
          ),
        ],
        scrollDirection: Axis.vertical,
        controller: _controllerColumn,
      ),
    );
  }

  Widget _buildNeumorphicButton(int amount) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.001,
          top: MediaQuery.of(context).size.width * 0.001),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            height: (MediaQuery.of(context).size.height /
                        MediaQuery.of(context).size.width <
                    1.5)
                ? MediaQuery.of(context).size.height * 0.94
                : (MediaQuery.of(context).size.width * 0.94) * 1.7,
            width: (MediaQuery.of(context).size.height /
                        MediaQuery.of(context).size.width >
                    1.5)
                ? MediaQuery.of(context).size.width * 0.94
                : (MediaQuery.of(context).size.height * 0.94) / 1.7,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(45.0)),
              ),
              color: Colors.grey[50],
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset('assets/third.jpg', fit: BoxFit.fill),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 45.0, right: 15.0, top: 15.0),
                        child: Center(
                          child: AutoSizeText(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[50],
                                  fontFamily: 'Roboto2'),
                              minFontSize: 10,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: AutoSizeText(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce semper augue ac massa egestas, non luctus purus cursus',
                        style: TextStyle(fontSize: 22),
                        minFontSize: 20,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
