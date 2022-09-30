import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supper_app/src/utils/pair/pair.dart';

enum AppTheme {
  light,
  dark,
}

enum AppLanguage { en, vi }

class AppState<T extends Pair<AppTheme, ThemeData>, V extends AppLanguage>
    extends Equatable {
  const AppState({this.appLanguage, this.appTheme});
  final T? appTheme;
  final V? appLanguage;

  @override
  List<Object?> get props => <Object?>[appTheme, appLanguage];
}

class AppCubit extends Cubit<AppState<Pair<AppTheme, ThemeData>, AppLanguage>> {
  AppCubit(AppState<Pair<AppTheme, ThemeData>, AppLanguage> appState)
      : super(const AppState<Pair<AppTheme, ThemeData>, AppLanguage>(
            appTheme: null, appLanguage: AppLanguage.en));

  Future<bool> saveLanguage(String langCode) {
    return SharedPreferences.getInstance().then((SharedPreferences shared) {
      return shared.setString('language', langCode);
    });
  }

  Future<bool> saveTheme(String langCode) {
    return SharedPreferences.getInstance().then((SharedPreferences shared) {
      return shared.setString('theme', langCode);
    });
  }

  void changeTheme({required Pair<AppTheme, ThemeData> theme}) {
    saveTheme(theme.left.toString());
    emit(AppState<Pair<AppTheme, ThemeData>, AppLanguage>(
        appTheme: theme, appLanguage: state.appLanguage));
  }

  void changeLanguage({required AppLanguage language}) {
    saveLanguage(language.toString());
    emit(AppState<Pair<AppTheme, ThemeData>, AppLanguage>(
        appLanguage: language, appTheme: state.appTheme));
  }
}
