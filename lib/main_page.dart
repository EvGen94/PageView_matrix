import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 420.0;

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
      listWidget.add(_buildNeumorphicButton(3));
    }
    listOfLists.add(listWidget);
    listWidget = List<Widget>();

    return listOfLists[index];
  }

  double page = 2;
  double viewPortFraction = 0.5;
  int currentPage = 2;
  PageController pageControllerZoom;
  @override
  void initState() {
    pageControllerZoom = PageController(
        initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controllerRow = PageController(
      viewportFraction: 0.353 *
              (MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width) +
          0.254,
    );
    // viewportFraction: 1);

    _controllerColumn = PageController(
      viewportFraction: -0.128 *
              (MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width) +
          1.1,
    );
    // viewportFraction: 0.45);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: PageView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      setState(() {
                        page = pageControllerZoom.page;
                      });
                    }
                  },
                  child: PageView.builder(
                    onPageChanged: (pos) {
                      setState(() {
                        currentPage = pos;
                      });
                    },
                    physics: BouncingScrollPhysics(),
                    controller: pageControllerZoom,
                    itemCount: _getNeumorphicButton(0).length,
                    itemBuilder: (context, index) {
                      final scale = max(
                          SCALE_FRACTION,
                          (FULL_SCALE - (index - page).abs()) +
                              viewPortFraction);
                      return _buildNeumorphicButton(scale);
                    },
                  ),
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

  Widget _buildNeumorphicButton(double scale) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.001,
          top: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          Container(
            /* height: (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width <
                      1.5)
                  ? MediaQuery.of(context).size.height * 0.94
                  : (MediaQuery.of(context).size.width * 0.94) * 1.7,
              width: (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width >
                      1.5)
                  ? MediaQuery.of(context).size.width * 0.94
                  : (MediaQuery.of(context).size.height * 0.94) / 1.7, */
            height: PAGER_HEIGHT * scale,
            width: PAGER_HEIGHT * scale,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(45.0)),
              ),
              color: Colors.grey[50],
              elevation: 10,
           
            ),
          ),
        ],
      ),
    );
  }
}
