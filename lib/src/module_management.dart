// import 'package:alice/alice.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supper_app/src/services/app_service/app_service.dart';
import 'package:supper_app/src/services/bus_service/bus_service.dart';
import 'package:supper_app/src/services/storage_service/storage_service.dart';
import 'package:supper_app/src/utils/pair/pair.dart';

import 'base_module.dart';
import 'services/web_service/dio_base.dart';

abstract class Argument {
  factory Argument.fromMap(Map<String, dynamic> map) =>
      throw UnimplementedError();
  Map<String, dynamic> toMap();
}

class DefaultRoute {
  static Route<dynamic> notFound() => MaterialPageRoute<void>(
      builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found !'),
            ),
          ));

  static Widget splashScreen(Widget? screen) {
    if (screen != null) {
      return screen;
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Hello'),
        ),
      );
    }
  }
}

class ModuleManagement {
  factory ModuleManagement() {
    return _singleton;
  }

  ModuleManagement._internal();
  static final ModuleManagement _singleton = ModuleManagement._internal();
  final List<BaseModule> _modules = <BaseModule>[];
  final GetIt serviceLocator = GetIt.instance;

  void addModules(List<BaseModule> modules) {
    _modules.addAll(modules);
  }

  List<BaseModule> getModules() => _modules;

  static T? arguments<T extends Argument>(RouteSettings settings, String path,
      T Function(Map<String, dynamic> data) fromMap) {
    if (settings.name != null) {
      final Uri uri = Uri.parse(settings.name ?? '');
      if (settings.arguments != null) {
        return settings.arguments as T;
      }
      if (uri.pathSegments.isNotEmpty || uri.queryParameters.isNotEmpty) {
        final List<String> segments = <String>[...uri.pathSegments];
        if (segments.length % 2 == 1) {
          segments.removeAt(0);
        }
        Map<String, String> result = <String, String>{};
        for (int a = 0; a < segments.length; a = a + 2) {
          result[segments[a]] = segments[a + 1];
        }
        result = <String, String>{...result, ...uri.queryParameters};
        final T arg1 = fromMap(result);
        return arg1;
      }
    }
    return null;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final BaseModule module in _modules) {
      if ((settings.name ?? '').contains(module.modulePath())) {
        return module.onGenerateRoute(settings);
      }
    }
    return DefaultRoute.notFound();
  }

  List<LocalizationsDelegate<dynamic>> localizationsDelegates() {
    final List<LocalizationsDelegate<dynamic>> result =
        <LocalizationsDelegate<dynamic>>[];
    for (final BaseModule module in _modules) {
      result.addAll(module.localizationsDelegates());
    }
    return result;
  }

  void injectDependencies() async {
    serviceLocator.registerSingleton(() => StorageService());
    serviceLocator.registerSingleton(() => BusService());
    serviceLocator.registerLazySingleton(() => AppCubit(
        const AppState<Pair<AppTheme, ThemeData>, AppLanguage>(
            appTheme: null, appLanguage: AppLanguage.vi)));

    // final _configPath = 'assets/cfg/dev_env.json';
    // GlobalConfiguration globalConfig;
    // globalConfig = await GlobalConfiguration.setup(_configPath);

    // GetIt.I.registerLazySingleton<GlobalConfiguration>(() => globalConfig);

    final Dio dio = await setupDio();
    serviceLocator.registerLazySingleton<Dio>(() => dio);
    final Alice alice = Alice(
      showNotification: false,
      showInspectorOnShake: false,
    );
    dio.interceptors.add(alice.getDioInterceptor());
    serviceLocator.registerSingleton(alice);

    // final storageService = GetIt.instance<StorageService>();
    // final appTheme = storageService.shared.getString("theme") ?? "";
    // final language = storageService.shared.getString("language") ?? "";

    for (final BaseModule module in _modules) {
      module.injectServices(serviceLocator);
    }
  }
}
