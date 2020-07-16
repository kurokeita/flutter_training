import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test/models/AppState.dart';

import 'package:test/redux/actions.dart';
import '../components/BottomBar.dart';

class Second extends StatefulWidget {

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions', textAlign: TextAlign.right,),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          width: 150,
          child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () => _likeAll(),
                  child: Text('Like all'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => _dislikeAll(),
                  child: Text('Dislike all'),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => _reset(),
                  child: Text('Reset counter'),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => _deleteAll(),
                  child: Text('Delete all'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  _reset() => StoreProvider.of<AppState>(context).dispatch(ResetCounterAction());

  _deleteAll() => StoreProvider.of<AppState>(context).dispatch(DeleteAllAction());

  _likeAll() => StoreProvider.of<AppState>(context).dispatch(LikeAllAction());

  _dislikeAll() => StoreProvider.of<AppState>(context).dispatch(DislikeAllAction());
}
