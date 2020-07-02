import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My first layout',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample layout', textAlign: TextAlign.right,),
      ),
      body: Padding(
        padding: EdgeInsets.only(top:10),
        child: Column(
          children: <Widget>[
            Text('1st line', textAlign: TextAlign.start,),
            Divider(),
            Text('2nd line', textAlign: TextAlign.center,),
            Divider(),
            Text('3rd line', textAlign: TextAlign.end,),
            Divider(),
            Text('The button has been pressed $_count times', textAlign: TextAlign.end,),
            Divider(),
            ButtonTheme(
              child: RaisedButton(
                onPressed: () => this.setState(() => this._count = 0),
                child: Text(
                  'Reset',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Colors.deepPurpleAccent,
              ),
              minWidth: 150,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCount,
        tooltip: 'Floating button',
        icon: Icon(
            Icons.thumb_up
        ),
        label: Text('Like'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  _incrementCount() {
    this.setState(() => this._count++);
  }
}

void main () => runApp(MyApp());

