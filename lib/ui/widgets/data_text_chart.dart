import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTextChart extends StatelessWidget {
  final String title;
  final String number;
  final String deltaNumber;
  final Color titleColor;
  final Color numberColor;
  final Color deltaNumberColor;
  var data;
  final Color lineColor;
  final Color pointColor;

  DataTextChart({
    Key key,
    this.title,
    this.number,
    this.deltaNumber,
    this.deltaNumberColor,
    this.numberColor,
    this.titleColor,
    this.data,
    this.lineColor,
    this.pointColor,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Container(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(140.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    color: titleColor,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      number,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: numberColor,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      // height: 15.w,
                      width: 25.w,
                    ),
                    Text(
                      deltaNumber,
                      style: GoogleFonts.montserrat(
                        color: deltaNumberColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.w,
                ),
                Sparkline(
                  data: data,
                  fallbackHeight: 100.w,
                  fallbackWidth: 200.w,
                  lineColor: lineColor,
                  pointsMode: PointsMode.last,
                  pointColor: pointColor,
                  pointSize: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
