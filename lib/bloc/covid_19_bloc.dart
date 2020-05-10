import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:covid19_tracker_application/models/models.dart';
import 'package:covid19_tracker_application/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  CaseLoaded({
    @required this.casesTimeSery,
    @required this.statewise,
    @required this.tested,
  });

  @override
  List<Object> get props => [
        casesTimeSery,
        statewise,
        tested,
      ];
}

class CaseError extends Covid_19State {}

class Covid_19Bloc extends Bloc<Covid_19Event, Covid_19State> {
  final ApiRepository apiRepository;

  Covid_19Bloc({@required this.apiRepository}) : assert(apiRepository != null);

  @override
  Covid_19State get initialState => CaseEmpty();

  @override
  Stream<Covid_19State> mapEventToState(
    Covid_19Event event,
  ) async* {
    if (event is FetchCase) {
      yield* _mapFetchCaseToState(event);
    }
  }

  Stream<Covid_19State> _mapFetchCaseToState(FetchCase event) async* {
    // var firstData = new Covid19();
    yield CaseLoading();
    try {
      final allData = await apiRepository.getAllData();
      print(allData);
      yield CaseLoaded(
        statewise: allData.statewise[0],
        casesTimeSery: allData.casesTimeSeries[0],
        tested: allData.tested[0],
      );
    } catch (_) {
      yield CaseError();
    }
  }
}
