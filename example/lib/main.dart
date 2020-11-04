import 'package:example/instagram_show_comment.dart';
import 'package:example/monitor_children.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(child: List()),
      ),
    );
  }
}

class List extends StatelessWidget {
  const List({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          child: Text('Monitor Children'),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MonitorChildren())),
        ),
        RaisedButton(
          child: Text('Instagram show comment'),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => InstagramShowComment())),
        )
      ],
    );
  }
}
