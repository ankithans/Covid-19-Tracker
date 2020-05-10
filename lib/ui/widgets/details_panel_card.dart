import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPanelCard extends StatelessWidget {
  final Color cardColor;
  final String title;
  final Color titleColorAndDescriptionColor;
  final String number;
  final Color numberColor;
  final String description;

  const DetailsPanelCard({
    Key key,
    this.cardColor,
    this.title,
    this.titleColorAndDescriptionColor,
    this.number,
    this.numberColor,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Container(
      height: 600.w,
      width: 480.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: cardColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.5,
                fontFamily: 'MontserratBold',
                color: titleColorAndDescriptionColor,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              number,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MontserratExtraBold',
                color: numberColor,
              ),
            ),
            SizedBox(
              height: 50.w,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: titleColorAndDescriptionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
