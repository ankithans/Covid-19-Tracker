import 'dart:io';
import 'package:covid19_tracker_application/models/topheadlinesnews/response_top_headlinews_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19_tracker_application/bloc/home_bloc.dart';
import 'package:covid19_tracker_application/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldState,
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 10.0,
                bottom: 0.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
                  /*SizedBox(height: 8.0),
                  buildWidgetSearch(),*/
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            // _buildWidgetLabelLatestNews(context),
            _buildWidgetSubtitleLatestNews(context),
            Expanded(
              child: WidgetLatestNews(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSubtitleLatestNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Top stories at the moment',
        style: Theme.of(context).textTheme.caption.merge(
              TextStyle(
                color: Color(0xFF325384).withOpacity(0.5),
              ),
            ),
      ),
    );
  }

  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(" ")[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + "st";
    } else if (strDay == '2') {
      strDay = strDay + "nd";
    } else if (strDay == '3') {
      strDay = strDay + "rd";
    } else {
      strDay = strDay + "th";
    }
    var strMonth = today.split(" ")[0];
    var strYear = today.split(" ")[2];
    return "$strDay $strMonth $strYear";
  }
}

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Health News\n',
              style: Theme.of(context).textTheme.title.merge(
                    TextStyle(
                      color: Color(0xFF325384),
                    ),
                  ),
            ),
            TextSpan(
              text: strToday,
              style: Theme.of(context).textTheme.caption.merge(
                    TextStyle(
                      color: Color(0xFF325384).withOpacity(0.8),
                      fontSize: 10.0,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  @override
  void initState() {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(DataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: BlocListener<HomeBloc, DataState>(
        listener: (context, state) {
          if (state is DataFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (BuildContext context, DataState state) {
            return _buildWidgetContentLatestNews(state, mediaQuery);
          },
        ),
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(
      DataState state, MediaQueryData mediaQuery) {
    if (state is DataLoading) {
      return Center(
        child: Loading(),
      );
    } else if (state is DataSuccess) {
      ResponseTopHeadlinesNews data = state.data;
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: data.articles.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          Article itemArticle = data.articles[index];
          if (index == 0) {
            return Stack(
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: itemArticle.urlToImage,
                    height: 192.0,
                    width: mediaQuery.size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(itemArticle.url)) {
                      await launch(itemArticle.url);
                    } else {
                      scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text('Could not launch news'),
                      ));
                    }
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 192.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.7,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 12.0,
                        right: 12.0,
                      ),
                      child: Text(
                        itemArticle.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 4.0,
                        right: 12.0,
                      ),
                      child: Wrap(
                        children: <Widget>[
                          Icon(
                            Icons.launch,
                            color: Colors.white.withOpacity(0.8),
                            size: 12.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '${itemArticle.source.name}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () async {
                if (await canLaunch(itemArticle.url)) {
                  await launch(itemArticle.url);
                }
              },
              child: Container(
                width: mediaQuery.size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 72.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              itemArticle.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF325384),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.launch,
                                  size: 12.0,
                                  color: Color(0xFF325384).withOpacity(0.5),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  itemArticle.source.name,
                                  style: TextStyle(
                                    color: Color(0xFF325384).withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        /*child: Image.network(
                          itemArticle.urlToImage ??
                              'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                          width: 72.0,
                          height: 72.0,
                          fit: BoxFit.cover,
                        ),*/
                        child: CachedNetworkImage(
                          imageUrl: itemArticle.urlToImage,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 72.0,
                            height: 72.0,
                            child: Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.cover,
                            width: 72.0,
                            height: 72.0,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}
