import 'dart:convert';
import 'package:flutter/services.dart';

class GlobalConfiguration {
  factory GlobalConfiguration() {
    return _instance;
  }
  GlobalConfiguration._internal();
  static final GlobalConfiguration _instance = GlobalConfiguration._internal();

  ///
  /// Loading a configuration [map] into the current app config.
  ///
  static Map<String, dynamic> _appConfig = <String, dynamic>{};

  /// Get value config
  T getValue<T>(String key) => _appConfig[key] as T;

  /// Load data config from `assets`
  /// Params `path` is path assets
  ///
  /// And file must be, extensions `.json`
  static Future<GlobalConfiguration> setup(String path) async {
    final String config = await rootBundle.loadString(path);
    final Map<String, dynamic> configMap = json.decode(config);
    _appConfig = configMap;

    return GlobalConfiguration();
  }
}
