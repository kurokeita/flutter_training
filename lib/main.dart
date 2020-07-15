import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'router.dart';
import 'configs/Consts.dart' as Consts;
import 'package:test/redux/reducers.dart';
import 'package:test/models/AppState.dart';

class MyApp extends StatelessWidget {
  final store = Store(
    appStateReducers,
    initialState: AppState.empty()
  );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
      systemNavigationBarColor: Colors.grey[800],
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: "Kuro's notes",
        onGenerateRoute: Router.generateRoute,
        initialRoute: Consts.HOME_ROUTE,
      ),
    );
  }
}

void main () => runApp(MyApp());
