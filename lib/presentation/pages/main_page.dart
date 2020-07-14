import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:neumorphic_design_app/presentation/widgets/neumorphic_button.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 

  List<Widget> listWidget = List<Widget>();
  List<List<Widget>> listOfLists = List<List<Widget>>();

  var _pageContraller = PageController();

  final _controller = PageController();

  void nextPage() async {
    await _pageContraller.nextPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInQuart,
    );
  }

  void prevPage() async {
    await _pageContraller.previousPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInQuart,
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

  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() =>
          pageOffset = pageController.page); //<-- add listener and set state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NeuAppBar(
        title: Text('Neumorphic Design'),
      ),
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
                  controller: pageController,
                  children: <Widget>[
                    FittedBox(
                      child: Container(
                        height: 400,
                        width: 350,
                        child: Card(
                          color: Colors.blue[100],
                          elevation: 8,
                          child: FittedBox(
                            child: Padding(
                              padding: EdgeInsets.all(80),
                              child: Image.network(
                                'https://avatars.mds.yandex.net/get-pdb/881477/049bbdf6-ae6f-4179-9a80-a5a591af8be8/s1200?webp=false',
                                width: 500,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                fit: BoxFit.none,
                                alignment: Alignment(-pageOffset.abs() , 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Container(
                        height: 400,
                        width: 350,
                        child: Card(
                          color: Colors.blue[100],
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: FittedBox(
                              child: Image.network(
                                'https://s1.1zoom.me/b5050/55/Stars_Sky_454921_1920x1200.jpg',
                                width: 500,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                fit: BoxFit.none,
                                alignment: Alignment(-pageOffset.abs() +1 , 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Container(
                        height: 400,
                        width: 350,
                        child: Card(
                          color: Colors.blue[100],
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: FittedBox(
                              child: Image.network(
                                'https://s2.best-wallpaper.net/wallpaper/1600x1200/1312/Yellow-flowers-raindrops-glare_1600x1200.jpg',
                                width: 500,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                fit: BoxFit.none,
                                alignment: Alignment(-pageOffset.abs() + 1, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        scrollDirection: Axis.vertical,
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
            height: 100,
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
              width: 250,
              height: 400,
              child: NeumorphicButton(
                title: 'WOW $amount',
                isLarge: false,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*


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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          child: Center(
            child: Text(
              'Item ' + (itemIndex + 1).toString(),
            ),
          ),
        ),
      ),





PerspectivePageView(
              hasShadow: true, // Enable-Disable Shadow
              shadowColor: Colors.black12, // Change Color
              aspectRatio: PVAspectRatio.ONE_ONE, // Add Aspect Ratio
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    debugPrint("Statement One");
                  },
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Statement Two");
                  },
                  child: Container(
                    color: Colors.green,
                  ),
                )
              ],
              
            ),




physics: NeverScrollableScrollPhysics(),

  body: PageView(
        children: <Widget>[
          Expanded(
            child: PageView(
              children: _getNeumorphicButton(),
            ),
          ),
          Expanded(
            child: PageView(
              children: _getNeumorphicButton(),
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
      ),



body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return PageView.builder(itemBuilder: (context, position) {
            return Expanded(
              child: PageView(
                children: _getNeumorphicButton(),
              ),
            );
          });
        },
      ),



        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),
              const SizedBox(
                height: 120,
              ),
              Container(
                width: 300,
                height: 400,
                child: NeumorphicButton(
                  title: 'wow wow wow wow wow',
                  isLarge: false,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),\
      
      
      List<Widget> getNeumorphicButton(int amount) {
  List<Widget> listWidget = List<Widget>();
  for (int i = 0; i < amount; i++) {
    listWidget.add(Container(child: Text('$i')));
  }
  return listWidget;
}
      
      


       Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: PageView(children: <Widget>[
            Text('Page 1'),
            Text('Page 2'),
            Text('Page 3'),
          ]),
        ),
        Expanded(child: Text("Test"), flex: 10), #<- add this if you don't want it to be at the bottom of the page
      ]),
      


PageView(
        children: _getNeumorphicButton(),
      ),




      */
