import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker_application/bloc/covid_19_bloc.dart';
import 'package:covid19_tracker_application/ui/widgets/data_text_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    fetchchartData();
    fetchTotalData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<Covid_19Bloc>(context).add(FetchCase());

    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  fetchTotalData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    setState(() {
      totalData = json.decode(response.body);
    });
  }

  List chartData;
  Map totalData;

  fetchchartData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    setState(() {
      chartData = json.decode(response.body)['cases_time_series'];
    });
  }

  List<double> _generateConfirmedData() {
    List<double> result = <double>[];
    for (int i = chartData.length - 20; i < chartData.length; i++) {
      result.add(
        (double.parse(totalData['cases_time_series'][i]['dailyconfirmed'])),
      );
    }
    return result;
  }

  List<double> _generateActiveData() {
    List<double> result = <double>[];
    for (int i = chartData.length - 20; i < chartData.length; i++) {
      result.add((double.parse(
              totalData['cases_time_series'][i]['dailyconfirmed'])) -
          (double.parse(totalData['cases_time_series'][i]['dailyrecovered'])) -
          (double.parse(totalData['cases_time_series'][i]['dailydeceased'])));
    }
    return result;
  }

  List<double> _generateRecoveredData() {
    List<double> result = <double>[];
    for (int i = chartData.length - 20; i < chartData.length; i++) {
      result.add(
          double.parse(totalData['cases_time_series'][i]['dailyrecovered']));
    }
    return result;
  }

  List<double> _generateDecreasedData() {
    List<double> result = <double>[];
    for (int i = chartData.length - 20; i < chartData.length; i++) {
      result.add(
          double.parse(totalData['cases_time_series'][i]['dailydeceased']));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.w,
            ),
            BlocBuilder<Covid_19Bloc, Covid_19State>(
              builder: (BuildContext context, Covid_19State state) {
                print(state);
                if (state is CaseLoading) {
                  return Center(
                    child: Text(''),
                  );
                }
                if (chartData != null && totalData != null) {
                  if (state is CaseLoaded) {
                    var confirmedData = _generateConfirmedData();
                    var activeData = _generateActiveData();
                    var recoveredData = _generateRecoveredData();
                    var decreasedData = _generateDecreasedData();
                    final display = createDisplay();
                    final statewise = state.statewise;
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40),
                          // vertical: ScreenUtil().setWidth(50),
                        ),
                        child: Container(
                          height: 950.w,
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
                                  style: GoogleFonts.montserrat(
                                    color: Color(0xFF6B747C),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      statewise.lastupdatedtime,
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF6B747C),
                                        fontWeight: FontWeight.bold,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    DataTextChart(
                                      title: "Confirmed",
                                      number: display(
                                          int.parse(statewise.confirmed)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltaconfirmed))}]',
                                      numberColor: Color(0xFFF83F38),
                                      deltaNumberColor: Color(0xFF9E2726),
                                      titleColor: Color(0xFFF83F38),
                                      data: chartData == null
                                          ? Text('')
                                          : confirmedData,
                                      lineColor: Color(0xFFF83F38),
                                      pointColor: Color(0xFFF83F38),
                                    ),
                                    DataTextChart(
                                      title: "Active",
                                      number:
                                          display(int.parse(statewise.active)),
                                      deltaNumber: "",
                                      numberColor: Color(0xFF0278F9),
                                      deltaNumberColor: Color(0xFF0055B1),
                                      titleColor: Color(0xFF0278F9),
                                      data: chartData == null
                                          ? Text('')
                                          : activeData,
                                      lineColor: Color(0xFF0278F9),
                                      pointColor: Color(0xFF0278F9),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    DataTextChart(
                                      title: "Recovered",
                                      number: display(
                                          int.parse(statewise.recovered)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltarecovered))}]',
                                      numberColor: Color(0xFF41A745),
                                      deltaNumberColor: Color(0xFF276A39),
                                      titleColor: Color(0xFF41A745),
                                      data: chartData == null
                                          ? Text('')
                                          : recoveredData,
                                      lineColor: Color(0xFF41A745),
                                      pointColor: Color(0xFF41A745),
                                    ),
                                    DataTextChart(
                                      title: "Decreased",
                                      number:
                                          display(int.parse(statewise.deaths)),
                                      deltaNumber:
                                          '[+${display(int.parse(statewise.deltadeaths))}]',
                                      numberColor: Color(0xFF6B747C),
                                      deltaNumberColor: Color(0xFF494E58),
                                      titleColor: Color(0xFF6B747C),
                                      data: chartData == null
                                          ? Text('')
                                          : decreasedData,
                                      lineColor: Color(0xFF6B747C),
                                      pointColor: Color(0xFF6B747C),
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
                } else {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CaseError) {
                  return Text('Something went wrong!');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
