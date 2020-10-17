import 'dart:async';

import 'package:covid19_tracker_application/bloc/covid_19_bloc.dart';
import 'package:covid19_tracker_application/models/regex.dart';
import 'package:covid19_tracker_application/repositories/enums.dart';
import 'package:covid19_tracker_application/ui/widgets/loading.dart';
import 'package:covid19_tracker_application/ui/widgets/noNetwork.dart';
import 'package:covid19_tracker_application/ui/widgets/states_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';
import 'package:provider/provider.dart';

class IndianStates extends StatefulWidget {
  @override
  _IndianStatesState createState() => _IndianStatesState();
}

class _IndianStatesState extends State<IndianStates>
    with AutomaticKeepAliveClientMixin {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

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
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Indian',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF325384),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'States',
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
        ),
        body: connectionStatus == ConnectivityStatus.offline
            ? NoNetwork()
            : BlocConsumer<Covid_19Bloc, Covid_19State>(
                listener: (context, state) {
                  if (state is CaseLoaded) {
                    _refreshCompleter?.complete();
                    _refreshCompleter = Completer();
                  }
                },
                builder: (context, state) {
                  if (state is CaseLoading) {
                    return Center(
                      child: Loading(),
                    );
                  }
                  if (state is CaseLoaded) {
                    final display = createDisplay();
                    final totalData1 = state.totalData;
                    final statesLength = state.statesLength;
                    final stateDailyDataLength = state.stateDailyDataLength;
                    final stateDailyData = state.stateDailyData;

                    // print("districtData: $districtData");

                    List<double> _generateConfirmedData(int index) {
                      List<double> result = <double>[];
                      for (int i = stateDailyDataLength.length - 120;
                          i < stateDailyDataLength.length;
                          i++) {
                        result.add(
                          (double.parse(stateDailyData['states_daily'][i][
                              totalData1['statewise'][index]['statecode']
                                  .toLowerCase()])),
                        );
                      }
                      return result;
                    }

                    // print(totalData1['statewise'][1]['statecode'].toLowerCase());
                    // print(stateDailyData['states_daily'][0]
                    //     [totalData1['statewise'][1]['statecode'].toLowerCase()]);
                    return RefreshIndicator(
                      onRefresh: () {
                        BlocProvider.of<Covid_19Bloc>(context).add(
                          CovidRefreshRequested(),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: statesLength.length - 1,
                        itemBuilder: (context, index) {
                          print(totalData1['statewise'][index + 1]['state']);
                          if (totalData1['statewise'][index + 1]['state'] ==
                              "State Unassigned") {
                            return SizedBox(height: 0.0);
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(30),
                                right: ScreenUtil().setWidth(30),
                              ),
                              child: StatesCard(
                                stateName: totalData1['statewise'][index + 1]
                                    ['state'],
                                confirmed: addSeperator(totalData1['statewise']
                                    [index + 1]['confirmed']),
                                deltaConfirmed: addSeperator(
                                    totalData1['statewise'][index + 1]
                                        ['deltaconfirmed']),
                                active: addSeperator(totalData1['statewise']
                                    [index + 1]['active']),
                                recovered: addSeperator(totalData1['statewise']
                                    [index + 1]['recovered']),
                                deltaRecovered: addSeperator(
                                    totalData1['statewise'][index + 1]
                                        ['deltarecovered']),
                                decreased: addSeperator(totalData1['statewise']
                                    [index + 1]['deaths']),
                                deltaDecreased: addSeperator(
                                    totalData1['statewise'][index + 1]
                                        ['deltadeaths']),
                                data: _generateConfirmedData(index + 1),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }
                  if (state is CaseError) {
                    return Text('Something went wrong!');
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
