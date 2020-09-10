import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'router.dart';
import 'configs/Consts.dart' as Consts;
import 'package:test/redux/reducers.dart';
import 'package:test/models/AppState.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({@required this.store});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
      systemNavigationBarColor: Colors.grey[800],
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return StoreProvider(
        store: store,
        // child: MaterialApp(
        //   theme: ThemeData.light(),
        //   title: "Kuro's notes",
        //   onGenerateRoute: Router.generateRoute,
        //   initialRoute: Consts.HOME_ROUTE,
        // ),
        child: StoreConnector<AppState, bool>(
          converter: (store) => store.state.theme,
          builder: (context, theme) => MaterialApp(
            theme: theme ? ThemeData.dark() : ThemeData.light(),
            title: "Kuro's notes",
            onGenerateRoute: Router.generateRoute,
            initialRoute: Consts.HOME_ROUTE,
          ),
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = Persistor<AppState>(
      storage: FlutterStorage(location: FlutterSaveLocation.sharedPreferences),
      serializer: JsonSerializer<AppState>(AppState.fromJSON));

  final initialState = await persistor.load();

  final store = Store<AppState>(appStateReducers,
      initialState: initialState ?? AppState.empty(),
      middleware: [persistor.createMiddleware()]);

  runApp(MyApp(store: store));
}
