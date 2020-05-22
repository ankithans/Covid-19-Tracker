import 'package:covid19_tracker_application/bloc/covid_19_bloc.dart';
import 'package:covid19_tracker_application/ui/widgets/data_text_chart.dart';
import 'package:covid19_tracker_application/ui/widgets/info_card.dart';
import 'package:covid19_tracker_application/ui/widgets/loading.dart';
import 'package:covid19_tracker_application/ui/widgets/most_affected_states.dart';
import 'package:covid19_tracker_application/ui/widgets/requirements.dart';
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
  void didChangeDependencies() {
    BlocProvider.of<Covid_19Bloc>(context).add(FetchCase());

    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Covid-19',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325384),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Tracker',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        actions: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_7,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<Covid_19Bloc, Covid_19State>(
        builder: (BuildContext context, Covid_19State state) {
          // print(state);
          if (state is CaseLoading) {
            return Center(
              child: Loading(),
            );
          }

          if (state is CaseLoaded) {
            final statewise = state.statewise;
            final totalData1 = state.totalData;
            final chartData1 = state.chartData;
            final testData = state.testData;
            // print(testData['data']['totalSamplesTested']);

            List<double> _generateConfirmedData() {
              List<double> result = <double>[];
              for (int i = chartData1.length - 20; i < chartData1.length; i++) {
                result.add(
                  (double.parse(
                      totalData1['cases_time_series'][i]['dailyconfirmed'])),
                );
              }
              return result;
            }

            List<double> _generateActiveData() {
              List<double> result = <double>[];
              for (int i = chartData1.length - 20; i < chartData1.length; i++) {
                result.add((double.parse(
                        totalData1['cases_time_series'][i]['dailyconfirmed'])) -
                    (double.parse(
                        totalData1['cases_time_series'][i]['dailyrecovered'])) -
                    (double.parse(
                        totalData1['cases_time_series'][i]['dailydeceased'])));
              }
              return result;
            }

            List<double> _generateRecoveredData() {
              List<double> result = <double>[];
              for (int i = chartData1.length - 20; i < chartData1.length; i++) {
                result.add(double.parse(
                    totalData1['cases_time_series'][i]['dailyrecovered']));
              }
              return result;
            }

            List<double> _generateDecreasedData() {
              List<double> result = <double>[];
              for (int i = chartData1.length - 20; i < chartData1.length; i++) {
                result.add(double.parse(
                    totalData1['cases_time_series'][i]['dailydeceased']));
              }
              return result;
            }

            var confirmedData = _generateConfirmedData();
            var activeData = _generateActiveData();
            var recoveredData = _generateRecoveredData();
            var decreasedData = _generateDecreasedData();
            final display = createDisplay();
            // print(totalData1['cases_time_series'][chartData1.length - 1]
            //     ['totalconfirmed']);

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(40),
                  // vertical: ScreenUtil().setWidth(50),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
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
                                    size: 45.w,
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
                                    number:
                                        display(int.parse(statewise.confirmed)),
                                    deltaNumber:
                                        '[+${display(int.parse(statewise.deltaconfirmed))}]',
                                    numberColor: Color(0xFFF83F38),
                                    deltaNumberColor: Color(0xFF9E2726),
                                    titleColor: Color(0xFFF83F38),
                                    data: confirmedData,
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
                                    data: activeData,
                                    lineColor: Color(0xFF0278F9),
                                    pointColor: Color(0xFF0278F9),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10.w,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  DataTextChart(
                                    title: "Recovered",
                                    number:
                                        display(int.parse(statewise.recovered)),
                                    deltaNumber:
                                        '[+${display(int.parse(statewise.deltarecovered))}]',
                                    numberColor: Color(0xFF41A745),
                                    deltaNumberColor: Color(0xFF276A39),
                                    titleColor: Color(0xFF41A745),
                                    data: recoveredData,
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
                                    data: decreasedData,
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
                    ExpansionTile(
                      title: Text(
                        'Most Affected States',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: <Widget>[
                        MostAffectedStates(
                          totalData: totalData1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        // left: 8,
                        // right: 8,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InfoCard(
                                backgroundColor: Color(0xFFFDE1E1),
                                title: 'Confirmed Per Million',
                                description:
                                    '${((double.parse(statewise.confirmed) / 135260000) * 1000000).toStringAsFixed(0)} out of every 1 million people in India have tested positive for the virus.',
                                number:
                                    '${((double.parse(statewise.confirmed) / 135260000) * 1000000).toStringAsFixed(2)}',
                                numberColor: Color(0xFFF83F38),
                                titleAndDescriptionColor: Color(0xFFF96B6A),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              InfoCard(
                                backgroundColor: Color(0xFFF3F3FE),
                                title: 'Active',
                                description:
                                    'For every 100 confirmed cases, ${(double.parse(statewise.active) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} are currently infected.',
                                number:
                                    '${(double.parse(statewise.active) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
                                numberColor: Color(0xFF2684FA),
                                titleAndDescriptionColor: Color(0xFF7E98FB),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: <Widget>[
                              InfoCard(
                                backgroundColor: Color(0xFFE1F2E8),
                                title: 'Recovery Rate',
                                description:
                                    'For every 100 confirmed cases, ${(double.parse(statewise.recovered) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} have recovered from the virus.',
                                number:
                                    '${(double.parse(statewise.recovered) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
                                numberColor: Color(0xFF41A745),
                                titleAndDescriptionColor: Color(0xFF6DC386),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              InfoCard(
                                backgroundColor: Color(0xFFF6F6F7),
                                title: 'Mortality Rate',
                                description:
                                    'For every 100 confirmed cases, ${(double.parse(statewise.deaths) / double.parse(statewise.confirmed) * 100).toStringAsFixed(0)} have unfortunately passed away from the virus.',
                                number:
                                    '${(double.parse(statewise.deaths) / double.parse(statewise.confirmed) * 100).toStringAsFixed(2)}%',
                                numberColor: Color(0xFF6F757D),
                                titleAndDescriptionColor: Color(0xFFBEB2AF),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: <Widget>[
                              InfoCard(
                                backgroundColor: Color(0xFFFAF7F3),
                                title: 'Avg. Growth Rate',
                                description:
                                    'In the last one week, the number of new infections has grown by an average of ${((((double.parse(totalData1['cases_time_series'][chartData1.length - 1]['totalconfirmed']) - double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) / double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) * 100) / 7).toStringAsFixed(0)}% every day.',
                                number:
                                    '${((((double.parse(totalData1['cases_time_series'][chartData1.length - 1]['totalconfirmed']) - double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) / double.parse(totalData1['cases_time_series'][chartData1.length - 8]['totalconfirmed'])) * 100) / 7).toStringAsFixed(2)}%',
                                numberColor: Color(0xFFB6854D),
                                titleAndDescriptionColor: Color(0xFFD2B28E),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              InfoCard(
                                backgroundColor: Color(0xFFE5E3F3),
                                title: 'Tests Per Million',
                                description:
                                    'For every 1 million people in India, ${(((testData['data']['totalSamplesTested']) / 135260000) * 1000000).toStringAsFixed(0)} people were tested.',
                                number:
                                    '≈ ${(((testData['data']['totalSamplesTested']) / 135260000) * 1000000).toStringAsFixed(0)}',
                                numberColor: Color(0xFF4655AC),
                                titleAndDescriptionColor: Color(0xFF7878C2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is CaseError) {
            return Text('Something went wrong!');
          }
          return Center(
            child: Loading(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
