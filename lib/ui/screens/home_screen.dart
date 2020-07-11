import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19_tracker_application/ui/screens/dashboard.dart';
import 'package:covid19_tracker_application/ui/screens/details.dart';
import 'package:covid19_tracker_application/ui/screens/health.dart';
import 'package:covid19_tracker_application/ui/screens/indian_states.dart';
import 'package:covid19_tracker_application/ui/screens/news_page.dart';
import 'package:covid19_tracker_application/ui/screens/zones.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//FontAwesome Icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          dragStartBehavior: DragStartBehavior.down,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            DashBoard(),
            IndianStates(),
            Zones(),
            Health(),
            NewsScreen(),
            //Details(),
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
            title: Text('Dashboard', style: GoogleFonts.montserrat()),
            icon: Icon(Icons.dashboard),
            activeColor: Colors.blueGrey,
          ),
          BottomNavyBarItem(
            title: Text(' States', style: GoogleFonts.montserrat()),
            icon: Icon(Icons.flag),
            activeColor: Colors.indigo,
          ),
          BottomNavyBarItem(
            title: Text(' Zones', style: GoogleFonts.montserrat()),
            icon: Icon(Icons.my_location),
            activeColor: Color(0xFFA05AB3),
          ),
          BottomNavyBarItem(
            title: Text(' Health', style: GoogleFonts.montserrat()),
            icon: Icon(FontAwesomeIcons.stethoscope),
            activeColor: Color(0xFF28a745),
          ),
          BottomNavyBarItem(
            title: Text(' News', style: GoogleFonts.montserrat()),
            icon: Icon(Icons.explore),
            activeColor: Color(0xFFFFB339),
          ),
          /*BottomNavyBarItem(
            title: Text(' Facts', style: GoogleFonts.montserrat()),
            icon: Icon(Icons.lightbulb_outline),
            activeColor: Color(0xFF299489),
          ),*/
        ],
      ),
    );
  }
}
