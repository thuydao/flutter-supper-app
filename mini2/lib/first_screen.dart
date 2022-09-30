import 'package:flutter/material.dart';
import 'package:mini2/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // List<String> playerNames = <String>[
            //   'Cristiano Ronaldo',
            //   'Lional Messi'
            // ];
            SecondScreenProp prop = SecondScreenProp.fromMap({'list': 'haha'});
            displayResult(context, prop);
          },
          child: const Text('Select Best Football Player'),
        ),
      ),
    );
  }

  displayResult(BuildContext context, SecondScreenProp props) async {
    await Navigator.pushNamed(context, 'haha/SecondScreen?test=1',
        arguments: props);
  }
}
