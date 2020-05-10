import 'package:covid19_tracker_application/bloc/covid_19_bloc.dart';
import 'package:covid19_tracker_application/repositories/repositories.dart';
import 'package:covid19_tracker_application/simple_bloc_delegate.dart';
import 'package:covid19_tracker_application/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ApiRepository apiRepository = ApiRepository(
    apiClient: ApiClient(),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => Covid_19Bloc(apiRepository: apiRepository))
    ],
    child: MyApp(
      apiRepository: apiRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final ApiRepository apiRepository;

  const MyApp({Key key, @required this.apiRepository})
      : assert(apiRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Covid_19Bloc, Covid_19State>(
      builder: (BuildContext context, Covid_19State state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
            create: (context) => Covid_19Bloc(
              apiRepository: apiRepository,
            ),
            child: HomeScreen(),
          ),
        );
      },
    );
  }
}
