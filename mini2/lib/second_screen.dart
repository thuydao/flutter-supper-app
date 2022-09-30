import 'package:flutter/material.dart';
import 'package:supper_app/supper_app.dart';

class SecondScreenProp implements Argument {
  late String list;
  @override
  Map<String, dynamic> toMap() {
    return {"list": list};
  }

  SecondScreenProp.fromMap(Map<String, dynamic> map) {
    list = map["list"] ?? "";
  }
}

class SecondScreen extends StatefulWidget {
  final SecondScreenProp props;
  const SecondScreen({Key? key, required this.props}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen> {
  SecondScreenState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'playerName');
                },
                child: const Text('test')),
          )
        ],
      ),
    ));
  }
}
