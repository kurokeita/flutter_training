import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/Consts.dart' as Consts;
import '../components/BottomBar.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> with TickerProviderStateMixin<Third> {
  bool _playing = false;
  Color _begin = Colors.white;
  Color _end = Colors.orangeAccent;
  Color _currentColor = Colors.white;
  AnimationController _rotationController;
  AnimationController _colorController;
  Animation<Color> _colorTween;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20)
    );
    _colorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3)
    );
    _colorTween = ColorTween(
      begin: _begin,
      end: _end
    ).animate(_colorController)
    ..addListener(() {
      setState(() {
        _currentColor = _colorTween.value;
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
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
        child: _colorFiltered(),
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: child,
          );
        },
      ),
    );
  }

  Widget _colorFiltered() {
    return ColorFiltered(
      child: Image.asset('assets/images/sun.jpg'),
      colorFilter: ColorFilter.mode(_currentColor, BlendMode.modulate),
    );
  }

  void _play() {
    this.setState(() {
      _playing = true;
    });
    _rotationController.repeat();
    _colorController.repeat(reverse: true);
  }

  void _pause() {
    this.setState(() {
      _playing = false;
    });
    _rotationController.stop();
    _colorController.stop();
  }
}

