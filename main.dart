import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

final rng = new Random();
// int sum = 0;
Stream<int> getStream() => Stream.periodic(Duration(seconds:1), (int val) => rng.nextInt(100));

Stream<int> s_1 = getStream();
Stream<int> s_2 = getStream();

// Stream<Future<int>> resolver = new Stream.periodic(
//   Duration(seconds:1), 
//   (int val) async {
//     int a = await s_1.last; // listens to the same stream more than once :/
//     int b = await s_2.last; // same
//     sum = a+b; // cheat, doesn't work
//     return a+b;
//   }
// );

// Stream<int> sumStream = new Stream.periodic(
//   Duration(seconds:1), 
//   (int val) {
//     return sum;
//     }
//   );

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Random sum: ',
            ),
            StreamBuilder(
              stream: s_1,
              builder: (BuildContext context, AsyncSnapshot snapshot1) {
                return StreamBuilder( // Another cheat, nesting StreamBuilders
                  stream: s_2,
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                  return Text('${snapshot1.data + snapshot2.data}');
                }
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
