import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'router.dart';
import 'configs/Consts.dart' as Consts;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: "Kuro's notes",
      onGenerateRoute: Router.generateRoute,
      initialRoute: Consts.HOME_ROUTE,
    );
  }
}

void main () => runApp(MyApp());
