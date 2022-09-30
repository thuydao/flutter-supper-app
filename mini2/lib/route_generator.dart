library mini2;

import 'package:flutter/material.dart';
import 'package:mini2/first_screen.dart';
import 'package:supper_app/supper_app.dart';

class Mini2Route implements BaseModule {
  @override
  String modulePath() {
    return 'haha';
  }

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if ((settings.name ?? "").contains('/FirstScreen')) {
      return MaterialPageRoute<void>(builder: (_) => const FirstScreen());
    }
    if ((settings.name ?? "").contains('/SecondScreen')) {
      // final args = ModuleManagement.arguments(
      //     settings, "/SecondScreen/", (x) => SecondScreenProp.fromMap(x));
      // return authenticateGuardRoute(
      //     MaterialPageRoute(
      //         builder: (_) => SecondScreen(props: args as SecondScreenProp)),
      //     settings);
      return DefaultRoute.notFound();
    }
    return DefaultRoute.notFound();
  }

  @override
  void injectServices(GetIt getIt) {}

  @override
  List<LocalizationsDelegate> localizationsDelegates() {
    throw UnimplementedError();
  }
}
