import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/BottomBar.dart';
import '../configs/Consts.dart' as Consts;

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actions', textAlign: TextAlign.right,),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          width: 150,
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _reset,
                child: Text('Reset counter'),
              ),
              RaisedButton(
                onPressed: _deleteAll,
                child: Text('Delete all'),
              ),
              RaisedButton(
                onPressed: _likeAll,
                child: Text('Like all'),
              ),
              RaisedButton(
                onPressed: _dislikeAll,
                child: Text('Dislike all'),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: Consts.SECOND),
    );
  }

  _reset() {

  }

  _deleteAll() {

  }

  _likeAll() {

  }

  _dislikeAll() {

  }
}
