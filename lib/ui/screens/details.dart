import 'package:covid19_tracker_application/repositories/enums.dart';
import 'package:covid19_tracker_application/ui/widgets/learn.dart';
import 'package:covid19_tracker_application/ui/widgets/noNetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF325384),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Covid-19',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Facts',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325384),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          SvgPicture.asset('assets/facts/undraw-learn-qa.svg'),
        ],
      ),
      body: connectionStatus == ConnectivityStatus.offline
          ? NoNetwork()
          : Learn(),
    );
  }
}
