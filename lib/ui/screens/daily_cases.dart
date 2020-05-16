import 'package:covid19_tracker_application/ui/widgets/data_text_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_display/number_display.dart';

class DailyCases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final display = createDisplay();

    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(40),
          // vertical: ScreenUtil().setWidth(50),
        ),
        child: Container(
          height: 1000.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            child: Column(
              children: <Widget>[
                Text(
                  'Data Based on India',
                  style: TextStyle(
                    color: Color(0xFF6B747C),
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '35353',
                      style: TextStyle(
                        color: Color(0xFF6B747C),
                        fontFamily: "MontserratBold",
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      size: 50.w,
                      color: Color(0xFF6B747C),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DataTextChart(
                      title: "Confirmed",
                      number: '2e322',
                      deltaNumber: '2222',
                      numberColor: Color(0xFFF83F38),
                      deltaNumberColor: Color(0xFF9E2726),
                      titleColor: Color(0xFFF83F38),
                      // data: chartData == null ? Text('') : confirmedData,
                      // lineColor: Color(0xFFF83F38),
                      // pointColor: Color(0xFFF83F38),
                    ),
                    DataTextChart(
                      title: "Active",
                      number: 'dccc',
                      deltaNumber: "",
                      numberColor: Color(0xFF0278F9),
                      deltaNumberColor: Color(0xFF0055B1),
                      titleColor: Color(0xFF0278F9),
                      // data: chartData == null ? Text('') : activeData,
                      // lineColor: Color(0xFF0278F9),
                      // pointColor: Color(0xFF0278F9),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DataTextChart(
                      title: "Recovered",
                      number: 'scee',
                      deltaNumber: "cdcdvd",
                      numberColor: Color(0xFF41A745),
                      deltaNumberColor: Color(0xFF276A39),
                      titleColor: Color(0xFF41A745),
                      // data: chartData == null ? Text('') : recoveredData,
                      // lineColor: Color(0xFF41A745),
                      // pointColor: Color(0xFF41A745),
                    ),
                    DataTextChart(
                      title: "Decreased",
                      number: 'dcscc',
                      deltaNumber: "ddcscec",
                      numberColor: Color(0xFF6B747C),
                      deltaNumberColor: Color(0xFF494E58),
                      titleColor: Color(0xFF6B747C),
                      // data: chartData == null ? Text('') : decreasedData,
                      // lineColor: Color(0xFF6B747C),
                      // pointColor: Color(0xFF6B747C),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
