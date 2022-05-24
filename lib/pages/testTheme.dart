import 'package:bloc_provider/bloc_provider.dart';

import 'package:flutter/material.dart';

import 'package:homealone/theme.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final settings = ValueNotifier(ThemeSettings(
    sourceColor:  Colors.pink,
    themeMode: ThemeMode.system,
  ));
  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.light(settings.value.sourceColor),
      darkTheme: theme.dark(settings.value.sourceColor), // Add this line
      themeMode: theme.themeMode(), // Add this line

    );

  }
}