import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../configs/Consts.dart' as Consts;
import 'package:test/models/AppState.dart';
import 'package:test/redux/actions.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _changeScreen(int index) {
    final store = StoreProvider.of<AppState>(context);
    if (store.state.currentTabIndex != index) {
      switch (index) {
        case Consts.HOME:
          Navigator.pushNamedAndRemoveUntil(
              context, Consts.HOME_ROUTE, (route) => false);
          break;
        case Consts.SECOND:
          Navigator.pushNamed(context, Consts.SECOND_ROUTE);
          break;
        case Consts.ANIMATION:
          Navigator.pushNamed(context, Consts.ANIMATION_ROUTE);
          break;
        case Consts.HERO:
          Navigator.pushNamed(context, Consts.HERO_ROUTE);
          break;
        default:
          break;
      }
    }
    store.dispatch(UpdateCurrentTabIndexAction(index));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => BottomNavigationBar(
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
                    title: Text('Animated Widget')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.widgets), title: Text('Hero'))
              ],
              selectedItemColor: Colors.deepPurple,
              currentIndex: state.currentTabIndex,
              onTap: _changeScreen,
              unselectedItemColor: Colors.white,
            ));
  }
}
