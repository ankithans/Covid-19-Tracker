import 'dart:async';

import 'package:covid19_tracker_application/bloc/zones_bloc.dart';
import 'package:covid19_tracker_application/repositories/enums.dart';
import 'package:covid19_tracker_application/ui/widgets/loading.dart';
import 'package:covid19_tracker_application/ui/widgets/noNetwork.dart';
import 'package:covid19_tracker_application/ui/widgets/search_districts.dart';
import 'package:covid19_tracker_application/ui/widgets/zone_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Zones extends StatefulWidget {
  @override
  _ZonesState createState() => _ZonesState();
}

class _ZonesState extends State<Zones> with AutomaticKeepAliveClientMixin {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<ZonesBloc>(context).add(FetchZone());

    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }

  var zoneData;
  var zoneDataLength;
  bool zoneLoad = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'District',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF325384),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Zones',
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => zoneLoad
            ? showSearch(
                context: context,
                delegate: SearchDistricts(zoneDataLength, zoneData))
            : null,
      ),
      body: connectionStatus == ConnectivityStatus.offline
          ? NoNetwork()
          : BlocConsumer<ZonesBloc, ZonesState>(
              listener: (context, state) {
                if (state is ZoneLoaded) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                }
              },
              builder: (context, state) {
                if (state is ZoneLoading) {
                  return Center(child: Loading());
                }
                if (state is ZoneLoaded) {
                  zoneLoad = true;
                  final zoneData = state.zoneData;
                  final zoneDataLength = state.zoneDataLength;
                  // final Color a = zoneData['zones'][1]['zone'].toLowerCase();
                  // print(a);

                  zoneColor(int index) {
                    if (zoneData['zones'][index]['zone'] == 'Green') {
                      return Color(0xFFE1F2E8);
                    } else if (zoneData['zones'][index]['zone'] == 'Red') {
                      return Color(0xFFFDE1E1);
                    } else if (zoneData['zones'][index]['zone'] == 'Orange') {
                      return Colors.orange.withOpacity(.2);
                    }
                  }

                  textColor(int index) {
                    if (zoneData['zones'][index]['zone'] == 'Green') {
                      return Color(0xFF41A745);
                    } else if (zoneData['zones'][index]['zone'] == 'Red') {
                      return Color(0xFFF83F38);
                    } else if (zoneData['zones'][index]['zone'] == 'Orange') {
                      return Colors.orange;
                    }
                  }

                  // print(zoneData);

                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<ZonesBloc>(context).add(
                        RefreshZone(),
                      );
                      return _refreshCompleter.future;
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: zoneDataLength.length,
                      // shrinkWrap: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ZoneCard(
                          color: zoneColor(index),
                          district: zoneData['zones'][index]['district'],
                          state: zoneData['zones'][index]['state'],
                          textColor: textColor(index),
                        );
                      },
                    ),
                  );
                }
                if (state is ZoneError) {
                  return Text('Something went wrong!');
                }
                return Center(
                  child: SpinKitFadingCube(
                    color: Colors.blue,
                  ),
                );
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
