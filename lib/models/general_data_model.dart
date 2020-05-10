// To parse this JSON data, do
//
//     final covid19 = covid19FromJson(jsonString);

import 'dart:convert';

Covid19 covid19FromJson(String str) => Covid19.fromJson(json.decode(str));

String covid19ToJson(Covid19 data) => json.encode(data.toJson());

class Covid19 {
  final List<CasesTimeSery> casesTimeSeries;
  final List<Statewise> statewise;
  final List<Tested> tested;

  Covid19({
    this.casesTimeSeries,
    this.statewise,
    this.tested,
  });

  factory Covid19.fromJson(Map<String, dynamic> json) => Covid19(
        casesTimeSeries: json["cases_time_series"] == null
            ? null
            : List<CasesTimeSery>.from(json["cases_time_series"]
                .map((x) => CasesTimeSery.fromJson(x))),
        statewise: json["statewise"] == null
            ? null
            : List<Statewise>.from(
                json["statewise"].map((x) => Statewise.fromJson(x))),
        tested: json["tested"] == null
            ? null
            : List<Tested>.from(json["tested"].map((x) => Tested.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cases_time_series": casesTimeSeries == null
            ? null
            : List<dynamic>.from(casesTimeSeries.map((x) => x.toJson())),
        "statewise": statewise == null
            ? null
            : List<dynamic>.from(statewise.map((x) => x.toJson())),
        "tested": tested == null
            ? null
            : List<dynamic>.from(tested.map((x) => x.toJson())),
      };
}

class CasesTimeSery {
  final String dailyconfirmed;
  final String dailydeceased;
  final String dailyrecovered;
  final String date;
  final String totalconfirmed;
  final String totaldeceased;
  final String totalrecovered;

  CasesTimeSery({
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.date,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
  });

  factory CasesTimeSery.fromJson(Map<String, dynamic> json) => CasesTimeSery(
        dailyconfirmed:
            json["dailyconfirmed"] == null ? null : json["dailyconfirmed"],
        dailydeceased:
            json["dailydeceased"] == null ? null : json["dailydeceased"],
        dailyrecovered:
            json["dailyrecovered"] == null ? null : json["dailyrecovered"],
        date: json["date"] == null ? null : json["date"],
        totalconfirmed:
            json["totalconfirmed"] == null ? null : json["totalconfirmed"],
        totaldeceased:
            json["totaldeceased"] == null ? null : json["totaldeceased"],
        totalrecovered:
            json["totalrecovered"] == null ? null : json["totalrecovered"],
      );

  Map<String, dynamic> toJson() => {
        "dailyconfirmed": dailyconfirmed == null ? null : dailyconfirmed,
        "dailydeceased": dailydeceased == null ? null : dailydeceased,
        "dailyrecovered": dailyrecovered == null ? null : dailyrecovered,
        "date": date == null ? null : date,
        "totalconfirmed": totalconfirmed == null ? null : totalconfirmed,
        "totaldeceased": totaldeceased == null ? null : totaldeceased,
        "totalrecovered": totalrecovered == null ? null : totalrecovered,
      };
}

class Statewise {
  final String active;
  final String confirmed;
  final String deaths;
  final String deltaconfirmed;
  final String deltadeaths;
  final String deltarecovered;
  final String lastupdatedtime;
  final String recovered;
  final String state;
  final String statecode;
  final String statenotes;

  Statewise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.recovered,
    this.state,
    this.statecode,
    this.statenotes,
  });

  factory Statewise.fromJson(Map<String, dynamic> json) => Statewise(
        active: json["active"] == null ? null : json["active"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        deaths: json["deaths"] == null ? null : json["deaths"],
        deltaconfirmed:
            json["deltaconfirmed"] == null ? null : json["deltaconfirmed"],
        deltadeaths: json["deltadeaths"] == null ? null : json["deltadeaths"],
        deltarecovered:
            json["deltarecovered"] == null ? null : json["deltarecovered"],
        lastupdatedtime:
            json["lastupdatedtime"] == null ? null : json["lastupdatedtime"],
        recovered: json["recovered"] == null ? null : json["recovered"],
        state: json["state"] == null ? null : json["state"],
        statecode: json["statecode"] == null ? null : json["statecode"],
        statenotes: json["statenotes"] == null ? null : json["statenotes"],
      );

  Map<String, dynamic> toJson() => {
        "active": active == null ? null : active,
        "confirmed": confirmed == null ? null : confirmed,
        "deaths": deaths == null ? null : deaths,
        "deltaconfirmed": deltaconfirmed == null ? null : deltaconfirmed,
        "deltadeaths": deltadeaths == null ? null : deltadeaths,
        "deltarecovered": deltarecovered == null ? null : deltarecovered,
        "lastupdatedtime": lastupdatedtime == null ? null : lastupdatedtime,
        "recovered": recovered == null ? null : recovered,
        "state": state == null ? null : state,
        "statecode": statecode == null ? null : statecode,
        "statenotes": statenotes == null ? null : statenotes,
      };
}

class Tested {
  final String individualstestedperconfirmedcase;
  final String positivecasesfromsamplesreported;
  final String samplereportedtoday;
  final String source;
  final String testpositivityrate;
  final String testsconductedbyprivatelabs;
  final String testsperconfirmedcase;
  final String totalindividualstested;
  final String totalpositivecases;
  final String totalsamplestested;
  final String updatetimestamp;

  Tested({
    this.individualstestedperconfirmedcase,
    this.positivecasesfromsamplesreported,
    this.samplereportedtoday,
    this.source,
    this.testpositivityrate,
    this.testsconductedbyprivatelabs,
    this.testsperconfirmedcase,
    this.totalindividualstested,
    this.totalpositivecases,
    this.totalsamplestested,
    this.updatetimestamp,
  });

  factory Tested.fromJson(Map<String, dynamic> json) => Tested(
        individualstestedperconfirmedcase:
            json["individualstestedperconfirmedcase"] == null
                ? null
                : json["individualstestedperconfirmedcase"],
        positivecasesfromsamplesreported:
            json["positivecasesfromsamplesreported"] == null
                ? null
                : json["positivecasesfromsamplesreported"],
        samplereportedtoday: json["samplereportedtoday"] == null
            ? null
            : json["samplereportedtoday"],
        source: json["source"] == null ? null : json["source"],
        testpositivityrate: json["testpositivityrate"] == null
            ? null
            : json["testpositivityrate"],
        testsconductedbyprivatelabs: json["testsconductedbyprivatelabs"] == null
            ? null
            : json["testsconductedbyprivatelabs"],
        testsperconfirmedcase: json["testsperconfirmedcase"] == null
            ? null
            : json["testsperconfirmedcase"],
        totalindividualstested: json["totalindividualstested"] == null
            ? null
            : json["totalindividualstested"],
        totalpositivecases: json["totalpositivecases"] == null
            ? null
            : json["totalpositivecases"],
        totalsamplestested: json["totalsamplestested"] == null
            ? null
            : json["totalsamplestested"],
        updatetimestamp:
            json["updatetimestamp"] == null ? null : json["updatetimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "individualstestedperconfirmedcase":
            individualstestedperconfirmedcase == null
                ? null
                : individualstestedperconfirmedcase,
        "positivecasesfromsamplesreported":
            positivecasesfromsamplesreported == null
                ? null
                : positivecasesfromsamplesreported,
        "samplereportedtoday":
            samplereportedtoday == null ? null : samplereportedtoday,
        "source": source == null ? null : source,
        "testpositivityrate":
            testpositivityrate == null ? null : testpositivityrate,
        "testsconductedbyprivatelabs": testsconductedbyprivatelabs == null
            ? null
            : testsconductedbyprivatelabs,
        "testsperconfirmedcase":
            testsperconfirmedcase == null ? null : testsperconfirmedcase,
        "totalindividualstested":
            totalindividualstested == null ? null : totalindividualstested,
        "totalpositivecases":
            totalpositivecases == null ? null : totalpositivecases,
        "totalsamplestested":
            totalsamplestested == null ? null : totalsamplestested,
        "updatetimestamp": updatetimestamp == null ? null : updatetimestamp,
      };
}
