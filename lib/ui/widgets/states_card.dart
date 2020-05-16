import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';

class StatesCard extends StatelessWidget {
  final String stateName;
  final String confirmed;
  final String deltaConfirmed;
  final String active;
  final String recovered;
  final String deltaRecovered;
  final String decreased;
  final String deltaDecreased;
  var data;

  StatesCard(
      {Key key,
      this.stateName,
      this.confirmed,
      this.deltaConfirmed,
      this.active,
      this.recovered,
      this.deltaRecovered,
      this.decreased,
      this.deltaDecreased,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      height: 400.w,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60.w,
                  width: 480.w,
                  child: Text(
                    stateName,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      // color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Confirmed: ",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFF83F38),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$confirmed [+$deltaConfirmed]",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFF83F38),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.w,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Active: ",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF0278F9),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$active",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF0278F9),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.w,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Recovered: ",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF41A745),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$recovered [+$deltaRecovered]",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF41A745),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.w,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Decreased: ",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF6B747C),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$decreased [+$deltaDecreased]",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF6B747C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Sparkline(
              data: data,
              fallbackHeight: 100.w,
              fallbackWidth: 400.w,
              lineColor: Colors.red,
              pointsMode: PointsMode.last,
              pointColor: Colors.red,
              pointSize: 5,
              sharpCorners: true,
            ),
          ],
        ),
      ),
    );
  }
}
