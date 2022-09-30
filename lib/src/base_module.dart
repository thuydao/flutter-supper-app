import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class BaseModule {
  Route<dynamic> onGenerateRoute(RouteSettings settings);
  String modulePath();
  void injectServices(GetIt getIt);
  List<LocalizationsDelegate<dynamic>> localizationsDelegates();
}
