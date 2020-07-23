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

  var _pageContraller = PageController();

  final _controller = PageController(viewportFraction: 0.8);

  void nextPage() async {
    await _pageContraller.nextPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.slowMiddle,
    );
  }

  void prevPage() async {
    await _pageContraller.previousPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.slowMiddle,
    );
  }

  List<Widget> _getNeumorphicButton(int index) {
    for (int i = 0; i < 5; i++) {
      listWidget.add(_buildNeumorphicButton(i + 1));
    }
    listOfLists.add(listWidget);
    listWidget = List<Widget>();

    return listOfLists[index];
    // return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: PageView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(0),
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageContraller,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(1),
                  //  physics: NeverScrollableScrollPhysics(),
                  controller: _pageContraller,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: _getNeumorphicButton(1),
                  //  physics: NeverScrollableScrollPhysics(),
                  controller: _pageContraller,
                ),
              ),
            ],
          ),
        ],
        scrollDirection: Axis.vertical,
          controller: _controller,
      ),
    );
  }

  Widget _buildNeumorphicButton(int amount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx < 0) {
                nextPage();
              }
              if (details.delta.dx > 0) {
                prevPage();
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.width * 1.25,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
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
                                'Lorem ipsum dolor sit amet, elit consectetur adipiscing elit',
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
                          'Lorem ipsum dolor sit amet, consectetur adip amet, consectetur adipiscing elit. Fusce semper augue ac massa egestas, non luctus purus cursus',
                          style: TextStyle(fontSize: 30),
                          minFontSize: 18,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
