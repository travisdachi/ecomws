import 'package:async_redux/async_redux.dart';
import 'package:ecomws/app_state.dart';
import 'package:ecomws/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final store = Store<AppState>(initialState: AppState.initialState());

  @override
  Widget build(BuildContext context) {
    return AsyncReduxProvider<AppState>.value(
      value: store,
      child: MaterialApp(
        title: 'e-commerce ws',
        home: HomePage(),
      ),
    );
  }
}
