import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19_tracker_application/ui/screens/dashboard.dart';
import 'package:covid19_tracker_application/ui/screens/indian_states.dart';
import 'package:covid19_tracker_application/ui/screens/news_page.dart';
import 'package:covid19_tracker_application/ui/screens/zones.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          dragStartBehavior: DragStartBehavior.start,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            DashBoard(),
            IndianStates(),
            Zones(),
            NewsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        curve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 500),
        // itemCornerRadius: 15,
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Dashboard'),
            icon: Icon(Icons.home),
            activeColor: Colors.blueGrey,
          ),
          BottomNavyBarItem(
            title: Text('Indian states'),
            icon: Icon(Icons.flag),
            activeColor: Color(0xFF299489),
          ),
          BottomNavyBarItem(
            title: Text('District zone'),
            icon: Icon(Icons.place),
            activeColor: Color(0xFFA05AB3),
          ),
          BottomNavyBarItem(
            title: Text('Health News'),
            icon: Icon(Icons.settings),
            activeColor: Color(0xFFFFB339),
          ),
        ],
      ),
    );
  }
}
