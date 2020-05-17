import 'dart:ui';
import 'package:covid19_tracker_application/ui/screens/dashboard.dart';
import 'package:covid19_tracker_application/ui/screens/indian_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:rolling_nav_bar/indexed.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

double scaledHeight(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.height / 800);
}

double scaledWidth(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.width / 375);
}

class HomeScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color logoColor;
  int activeIndex;

  var iconData = <IconData>[
    Icons.home,
    Icons.people,
    Icons.account_circle,
    Icons.chat,
    Icons.settings,
  ];

  var badges = <int>[null, null, null, null, null];

  var iconText = <Widget>[
    Text('Home', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Indian States', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Account', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Chat', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Settings', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  @override
  void initState() {
    logoColor = Colors.red[600];
    activeIndex = 0;
    super.initState();
  }

  void incrementIndex() {
    setState(() {
      activeIndex = activeIndex < (iconData.length - 1) ? activeIndex + 1 : 0;
      print(activeIndex);
    });
  }

  // ignore: unused_element
  _onAnimate(AnimationUpdate update) {
    setState(() {
      logoColor = update.color;
    });
  }

  _onTap(int index) {
    activeIndex = index;
  }

  List<Widget> get builderChildren => const <Widget>[
        Text('1', style: TextStyle(color: Colors.grey)),
        Text('2', style: TextStyle(color: Colors.grey)),
        Text('3', style: TextStyle(color: Colors.grey)),
      ];

  static List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    IndianStates(),
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // scaffoldBackgroundColor: Colors.white,
          ),
      home: Builder(
        builder: (BuildContext context) {
          double navBarHeight = scaledHeight(context, 70);

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: Colors.white,
                title: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Covid-19',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Tracker',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                elevation: 0,
                actions: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.brightness_7,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: _widgetOptions.elementAt(activeIndex),
            bottomNavigationBar: Container(
              // bottom: 0,
              height: navBarHeight,
              width: MediaQuery.of(context).size.width,
              // Option 1: Recommended
              child: RollingNavBar.iconData(
                activeBadgeColors: <Color>[
                  Colors.white,
                ],
                activeIndex: activeIndex,
                animationCurve: Curves.linear,
                animationType: AnimationType.roll,
                baseAnimationSpeed: 200,
                iconData: iconData,
                iconColors: <Color>[Colors.grey[800]],
                iconText: iconText,
                indicatorColors: indicatorColors,
                iconSize: 25,
                indicatorRadius: scaledHeight(context, 30),
                onAnimate: _onAnimate,
                onTap: _onTap,
              ),

              // Option 2: Possibly more complicated, but there if you need it
              // child: RollingNavBar.builder(
              //   builder: (
              //     BuildContext context,
              //     int index,
              //     AnimationInfo info,
              //     AnimationUpdate update,
              //   ) {
              //     return builderChildren[index];
              //   },
              //   indicatorColors:
              //       indicatorColors.sublist(0, builderChildren.length),
              //   numChildren: builderChildren.length,
              //   onTap: _onTap,
              // ),
            ),
          );
        },
      ),
    );
  }
}
