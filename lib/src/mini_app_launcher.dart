import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import '../supper_app.dart';

class AppLauncherProps {
  AppLauncherProps(this.appName, this.module, this.root, this.debugWidget);
  final String appName;
  final BaseModule module;
  final String root;
  final Widget? debugWidget;
}

class AppLauncher extends StatefulWidget {
  const AppLauncher({Key? key, required this.props}) : super(key: key);
  final AppLauncherProps props;

  @override
  // ignore: library_private_types_in_public_api
  _AppLauncherState createState() =>
      // ignore: no_logic_in_create_state
      _AppLauncherState(props);
}

class _AppLauncherState extends State<AppLauncher> {
  _AppLauncherState(this.props);
  final AppLauncherProps props;

  @override
  void initState() {
    super.initState();
    if (mounted && props.debugWidget != null) {
      ShakeDetector.autoStart(
        onPhoneShake: () {
          final Center debugWidget = Center(child: props.debugWidget);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (_) => Scaffold(body: Center(child: debugWidget))));
        },
        minimumShakeCount: 1,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 2.7,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(props.appName),
        backgroundColor: const Color.fromARGB(255, 222, 104, 14),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, props.root);
              },
              child: Container(
                  color: const Color.fromARGB(255, 222, 104, 14),
                  width: 110,
                  height: 45,
                  child: const Center(
                      child: Text(
                    'Start App',
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniApp extends StatelessWidget {
  const MiniApp({Key? key, required this.props}) : super(key: key);
  final AppLauncherProps props;

  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    return BlocProvider.value(
      value: GetIt.instance<AppCubit>(),
      child: BlocBuilder<AppCubit,
          AppState<Pair<AppTheme, ThemeData>, AppLanguage>>(
        builder: (BuildContext ctx,
            AppState<Pair<AppTheme, ThemeData>, AppLanguage> state) {
          final Locale locale =
              Locale((state.appLanguage ?? AppLanguage.en).name);
          return MaterialApp(
            title: 'MiniApp',
            theme: state.appTheme?.right,
            home: AppLauncher(
              props: props,
            ),
            onGenerateRoute: ModuleManagement().onGenerateRoute,
            localizationsDelegates: ModuleManagement().localizationsDelegates(),
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            locale: locale,
          );
        },
      ),
    );
  }
}
