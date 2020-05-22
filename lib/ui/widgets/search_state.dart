import 'package:covid19_tracker_application/ui/widgets/states_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_display/number_display.dart';

class SearchStates extends SearchDelegate {
  final totalData1;
  final statesLength;
  final stateDailyDataLength;
  final stateDailyData;

  SearchStates({
    this.totalData1,
    this.stateDailyData,
    this.stateDailyDataLength,
    this.statesLength,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final display = createDisplay();
    final suggestionList = query.isEmpty
        ? statesLength
        : statesLength
            .where((element) =>
                element['statecode'].toString().toLowerCase().startsWith(query))
            .toList();

    List<double> _generateConfirmedData(int index) {
      List<double> result = <double>[];
      for (int i = stateDailyDataLength.length - 100;
          i < stateDailyDataLength.length;
          i++) {
        result.add(
          (double.parse(stateDailyData['states_daily'][i]
              [suggestionList[index]['statecode'].toLowerCase()])),
        );
      }
      return result;
    }

    // print(totalData1['statewise'][1]['statecode'].toLowerCase());
    // print(stateDailyData['states_daily'][0]
    //     [totalData1['statewise'][1]['statecode'].toLowerCase()]);
    return ListView.builder(
      itemCount: suggestionList.length - 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(40),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
          ),
          child: StatesCard(
            stateName: suggestionList[index + 1]['state'],
            confirmed:
                display(int.parse(suggestionList[index + 1]['confirmed'])),
            deltaConfirmed:
                display(int.parse(suggestionList[index + 1]['deltaconfirmed'])),
            active: display(int.parse(suggestionList[index + 1]['active'])),
            recovered:
                display(int.parse(suggestionList[index + 1]['recovered'])),
            deltaRecovered:
                display(int.parse(suggestionList[index + 1]['deltarecovered'])),
            decreased: display(int.parse(suggestionList[index + 1]['deaths'])),
            deltaDecreased:
                display(int.parse(suggestionList[index + 1]['deltadeaths'])),
            data: _generateConfirmedData(index + 1),
          ),
        );
      },
    );
  }
}
