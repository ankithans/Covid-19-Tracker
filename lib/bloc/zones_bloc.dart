import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:covid19_tracker_application/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ZonesEvent extends Equatable {
  const ZonesEvent();
}

class FetchZone extends ZonesEvent {
  @override
  List<Object> get props => [];
}

class RefreshZone extends ZonesEvent {
  @override
  List<Object> get props => [];
}

abstract class ZonesState extends Equatable {
  const ZonesState();

  @override
  List<Object> get props => [];
}

class ZoneEmpty extends ZonesState {}

class ZoneLoading extends ZonesState {}

class ZoneLoaded extends ZonesState {
  final zoneData;
  final List zoneDataLength;

  ZoneLoaded({
    this.zoneData,
    this.zoneDataLength,
  });

  @override
  List<Object> get props => [
        zoneData,
        zoneDataLength,
      ];
}

class ZoneError extends ZonesState {}

class ZonesBloc extends Bloc<ZonesEvent, ZonesState> {
  final ApiRepository apiRepository;

  ZonesBloc({this.apiRepository}) : assert(apiRepository != null);
  @override
  ZonesState get initialState => ZoneEmpty();

  @override
  Stream<ZonesState> mapEventToState(
    ZonesEvent event,
  ) async* {
    if (event is FetchZone) {
      yield* _mapFetchZoneToState(event);
    }
  }

  Stream<ZonesState> _mapFetchZoneToState(FetchZone event) async* {
    yield ZoneLoading();
    try {
      final zoneData = await apiRepository.fetchZoneData();
      final List zoneDataLength = await apiRepository.fetchZoneDataLength();

      yield ZoneLoaded(
        zoneData: zoneData,
        zoneDataLength: zoneDataLength,
      );
    } catch (_) {
      yield ZoneError();
    }
  }
}
