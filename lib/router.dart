import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'screens/Home.dart';
import 'screens/Actions.dart';
import 'configs/Consts.dart' as Consts;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, Function> args = settings.arguments;
    switch (settings.name) {
      case Consts.SECOND_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Second(refresh: args['refresh'],),
          transitionDuration: Duration(milliseconds: 0)
        );
      case Consts.HOME_ROUTE:
      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Home(),
          transitionDuration: Duration(milliseconds: 0)
        );
    }
  }
}