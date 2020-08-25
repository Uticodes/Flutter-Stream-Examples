import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamController<double> _controller = StreamController();
  StreamSubscription<double> _streamSubscription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Example',
      home: Scaffold(
          body: Center(
        child: Row(
          children: <Widget>[
            MaterialButton(
                child: Text("Subscribe: "),
                color: Colors.yellow[200],
                //for Future onPress
                onPressed: () async {
                  //stream the controller manages
                  var value1 = await getDelayedRandomValue();
                  var value2 = await getDelayedRandomValue();
                }

                /*onPressed: () {
                  //stream the controller manages
                  getDelayeddRandomValue().listen((value) {
                    print("Value from the controller: $value");
                  });
                  */ /*getDelayedRandomValue().listen((value) {
                    print("Value from the controller: $value");
                  });*/ /*

                  */ /*Stream stream = _controller.stream;
                  _streamSubscription = stream.listen((value) {
                    print("Value from the controller: $value");
                  });*/ /*
                }*/
                ),
            MaterialButton(
                child: Text("Emit Value: "),
                color: Colors.blue[200],
                onPressed: () {
                  _controller.add(12);
                }),
            MaterialButton(
                child: Text("Emit Value: "),
                color: Colors.green[200],
                onPressed: () {
                  _streamSubscription.cancel();
                })
          ],
        ),
      )),
    );
  }

  Future<double> getDelayedRandomValue() async {
    var random = Random();
    await Future.delayed(Duration(seconds: 1));
    return random.nextDouble();
  }

  Stream<double> getDelayeddRandomValue() async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield random.nextDouble();
    }
  }
}
