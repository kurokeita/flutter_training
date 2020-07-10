import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/Consts.dart' as Consts;
import '../components/BottomBar.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> with SingleTickerProviderStateMixin<Third> {
  bool _playing = false;
  Color _begin = Colors.white;
  Color _end = Colors.deepOrangeAccent;
  AnimationController _rotationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Animated Widget'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _body(),
      bottomNavigationBar: BottomBar(currentIndex: Consts.ANIMATION),
      floatingActionButton: FloatingActionButton(
        child: _playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        backgroundColor: Colors.deepPurple,
        onPressed: _playing ? _pause : _play,
      ),
    );
  }

  Widget _body() {
    return Center(
      child: AnimatedBuilder(
        animation: _rotationController,
        child: TweenAnimationBuilder(
            tween: ColorTween(
                begin: _begin,
                end: _end
            ),
            duration: Duration(seconds: 3),
            builder: (_, Color color, ___) => ColorFiltered(
              child: Image.asset('assets/images/sun.jpg'),
              colorFilter: ColorFilter.mode(color, BlendMode.modulate),
            ),
            onEnd: _swapColor
        ),
        builder: (_, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: child,
          );
        },
      ),
    );
  }

  void _play() {
    Color _middle = _begin;
    this.setState(() {
      _begin = _end;
      _end = _middle;
      _playing = true;
    });
    _rotationController.repeat();
  }

  void _swapColor() {
    if (_playing) {
      Color _middle = _begin;
      this.setState(() {
        _begin = _end;
        _end = _middle;
      });
    }
  }

  void _pause() {
    this.setState(() {
      _playing = false;
    });
    _rotationController.stop();
  }
}

