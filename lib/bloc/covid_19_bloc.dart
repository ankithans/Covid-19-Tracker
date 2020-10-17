import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker_application/models/models.dart';
import 'package:covid19_tracker_application/repositories/repositories.dart';
import '../models/general_data_model.dart';

abstract class Covid_19Event extends Equatable {
  const Covid_19Event();
}

class FetchCase extends Covid_19Event {
  @override
  List<Object> get props => [];
}

class RefreshCase extends Covid_19Event {
  @override
  List<Object> get props => [];
}

class CovidRefreshRequested extends Covid_19Event {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

abstract class Covid_19State extends Equatable {
  const Covid_19State();

  @override
  List<Object> get props => [];
}

class CaseEmpty extends Covid_19State {}

class CaseLoading extends Covid_19State {}

class CaseLoaded extends Covid_19State {
  final CasesTimeSery casesTimeSery;
  final Statewise statewise;
  final Tested tested;
  final totalData;
  final List chartData;
  final Map testData;
  final List statesLength;
  final stateDailyData;
  final List stateDailyDataLength;

  CaseLoaded({
    @required this.casesTimeSery,
    @required this.statewise,
    @required this.tested,
    @required this.totalData,
    @required this.chartData,
    @required this.testData,
    @required this.statesLength,
    @required this.stateDailyData,
    @required this.stateDailyDataLength,
  });

  @override
  List<Object> get props => [
        casesTimeSery,
        statewise,
        tested,
        totalData,
        chartData,
        testData,
        stateDailyData,
      ];
}

class CaseError extends Covid_19State {}

class Covid_19Bloc extends Bloc<Covid_19Event, Covid_19State> {
  final ApiRepository apiRepository;

  Covid_19Bloc({@required this.apiRepository})
      : assert(apiRepository != null),
        super(null);

  Covid_19State get initialState => CaseEmpty();

  @override
  Stream<Covid_19State> mapEventToState(
    Covid_19Event event,
  ) async* {
    if (event is FetchCase) {
      yield* _mapFetchCaseToState(event);
    } else if (event is CovidRefreshRequested) {
      yield* _mapCovidRefreshRequestedToState(event);
    }
  }

  Stream<Covid_19State> _mapFetchCaseToState(FetchCase event) async* {
    // var firstData = new Covid19();
    yield CaseLoading();
    try {
      final allData = await apiRepository.getAllData();
      final totalData = await apiRepository.fetchTotalData();
      final List chartData = await apiRepository.fetchChartData();
      final Map testData = await apiRepository.fetchTestData();
      final List statesLength = await apiRepository.fetchStatesLength();
      final stateDailyData = await apiRepository.fetchStatesDailyData();
      final List stateDailyDataLength =
          await apiRepository.fetchStatesDailyDataLength();
      // print(allData);
      yield CaseLoaded(
        statewise: allData.statewise[0],
        casesTimeSery: allData.casesTimeSeries[0],
        tested: allData.tested[0],
        totalData: totalData,
        chartData: chartData,
        testData: testData,
        statesLength: statesLength,
        stateDailyData: stateDailyData,
        stateDailyDataLength: stateDailyDataLength,
      );
    } catch (_) {
      yield CaseError();
    }
  }

  Stream<Covid_19State> _mapCovidRefreshRequestedToState(
    CovidRefreshRequested event,
  ) async* {
    try {
      final allData = await apiRepository.getAllData();
      final totalData = await apiRepository.fetchTotalData();
      final List chartData = await apiRepository.fetchChartData();
      final Map testData = await apiRepository.fetchTestData();
      final List statesLength = await apiRepository.fetchStatesLength();
      final stateDailyData = await apiRepository.fetchStatesDailyData();
      final List stateDailyDataLength =
          await apiRepository.fetchStatesDailyDataLength();
      yield CaseLoaded(
        statewise: allData.statewise[0],
        casesTimeSery: allData.casesTimeSeries[0],
        tested: allData.tested[0],
        totalData: totalData,
        chartData: chartData,
        testData: testData,
        statesLength: statesLength,
        stateDailyData: stateDailyData,
        stateDailyDataLength: stateDailyDataLength,
      );
    } catch (_) {}
  }
}
