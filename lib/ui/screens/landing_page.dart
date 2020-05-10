import 'package:covid19_tracker_application/ui/screens/dashboard.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: DashBoard(),
          ),
        ],
      ),
    );
  }
}
