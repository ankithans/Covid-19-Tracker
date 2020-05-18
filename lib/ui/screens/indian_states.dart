import 'package:covid19_tracker_application/bloc/covid_19_bloc.dart';
import 'package:covid19_tracker_application/ui/widgets/states_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_display/number_display.dart';

class IndianStates extends StatefulWidget {
  @override
  _IndianStatesState createState() => _IndianStatesState();
}

class _IndianStatesState extends State<IndianStates>
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

    return Scaffold(body: BlocBuilder<Covid_19Bloc, Covid_19State>(
      builder: (context, state) {
        if (state is CaseLoading) {
          return Center(
            child: CircularProgressIndicator(),
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
            for (int i = stateDailyDataLength.length - 100;
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
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: statesLength.length - 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(40),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                ),
                child: StatesCard(
                  stateName: totalData1['statewise'][index + 1]['state'],
                  confirmed: display(int.parse(
                      totalData1['statewise'][index + 1]['confirmed'])),
                  deltaConfirmed: display(int.parse(
                      totalData1['statewise'][index + 1]['deltaconfirmed'])),
                  active: display(
                      int.parse(totalData1['statewise'][index + 1]['active'])),
                  recovered: display(int.parse(
                      totalData1['statewise'][index + 1]['recovered'])),
                  deltaRecovered: display(int.parse(
                      totalData1['statewise'][index + 1]['deltarecovered'])),
                  decreased: display(
                      int.parse(totalData1['statewise'][index + 1]['deaths'])),
                  deltaDecreased: display(int.parse(
                      totalData1['statewise'][index + 1]['deltadeaths'])),
                  data: _generateConfirmedData(index + 1),
                ),
              );
            },
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
