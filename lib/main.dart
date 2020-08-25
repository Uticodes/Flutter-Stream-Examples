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
  StreamController<double> _controller = StreamController<double>.broadcast();
  StreamSubscription<double> _streamSubscription;
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  void dispose() {
    //the warning close instances of dart.core.Sink will not clear until you add this function
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Example',
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    child: Text("Subscribe: "),
                    color: Colors.yellow[200],
                    //for Future onPress
                    /*onPressed: () async {
                      //stream the controller manages
                      var value1 = await getDelayedRandomValue();
                      var value2 = await getDelayedRandomValue();
                    }*/

                    onPressed: () {
                      //stream the controller manages
                      /* getDelayeddRandomValue().listen((value) {
                        print("Value from the controller: $value");
                      });*/

                      Stream stream = _controller.stream;
                      _streamSubscription = stream.listen((value) {
                        print("Value from the controller: $value");
                      });
                    }),
                MaterialButton(
                    child: Text("Emit Value: "),
                    color: Colors.blue[200],
                    onPressed: () {
                      _controller.add(10);
                    }),
                MaterialButton(
                    child: Text("Emit Value: "),
                    color: Colors.green[200],
                    onPressed: () {
                      _streamSubscription?.cancel();
                    })
              ],
            ),
            Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                  stream: numberStream().map((number) => "number $number"),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text("hey there is some error");
                    else if (snapshot.connectionState ==
                        ConnectionState.waiting)
                      return CircularProgressIndicator();
                    return Text(
                      "${snapshot.data}",
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
              ],
            ),
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

  addData() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      _streamController.sink.add(i);
    }
  }

  Stream<int> numberStream() async* {
    for (int i = 1; i <= 20; i++) {
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
