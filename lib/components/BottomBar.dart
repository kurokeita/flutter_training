import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/Consts.dart' as Consts;

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function refresh;

  BottomBar({Key key, @required this.currentIndex, this.refresh});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    this.setState(() => _currentIndex = widget.currentIndex);
  }

  void _changeScreen(int index) {
    if (_currentIndex != index) {
      switch (index) {
        case Consts.HOME:
          Navigator.popUntil(context, (route) => route.isFirst);
          break;
        case Consts.SECOND:
          Navigator.pushNamed(
            context,
            Consts.SECOND_ROUTE,
            arguments: {
              'refresh': widget.refresh
            }
          );
          break;
        case Consts.ANIMATION:
          Navigator.pushNamed(
            context,
            Consts.ANIMATION_ROUTE
          );
          break;
        case Consts.HERO:
          Navigator.pushNamed(
            context,
            Consts.HERO_ROUTE
          );
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call_to_action),
          title: Text('Actions'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          title: Text('Animated Widget')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          title: Text('Hero')
        )
      ],
      selectedItemColor: Colors.deepPurple,
      currentIndex: _currentIndex,
      onTap: _changeScreen,
      backgroundColor: Colors.white,
      unselectedItemColor: Color(0xFF000000).withOpacity(0.6),
    );
  }
}
