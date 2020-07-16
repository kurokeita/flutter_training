import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'screens/Home.dart';
import 'screens/Actions.dart';
import 'screens/AnimatedWidget.dart';
import 'screens/HeroAnimation.dart';
import 'configs/Consts.dart' as Consts;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Consts.SECOND_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Second(),
          transitionDuration: Duration(milliseconds: 0)
        );
      case Consts.ANIMATION_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Third(),
          transitionDuration: Duration(milliseconds: 1000)
        );
      case Consts.HERO_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => HeroWidget(),
          transitionDuration: Duration(milliseconds: 1000)
        );
      case Consts.HERO2_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Test(),
          transitionDuration: Duration(milliseconds: 1000)
        );
      case Consts.HOME_ROUTE:
      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Home(),
          transitionDuration: Duration(milliseconds: 1000)
        );
    }
  }
}