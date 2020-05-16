import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String number;
  final String description;
  final Color titleAndDescriptionColor;
  final Color numberColor;
  final Color backgroundColor;

  const InfoCard({
    Key key,
    this.title,
    this.number,
    this.description,
    this.titleAndDescriptionColor,
    this.numberColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
        // left: ScreenUtil().setWidth(10),
        // right: ScreenUtil().setWidth(10),
      ),
      child: Container(
        height: 550.w,
        width: 480.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: titleAndDescriptionColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                number,
                style: GoogleFonts.montserrat(
                  fontSize: 21,
                  color: numberColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                description,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: titleAndDescriptionColor,
                  // fontWeight: FontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
