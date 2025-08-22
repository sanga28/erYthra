import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

class ErythraApp extends StatelessWidget {
  const ErythraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erythra',
      theme: buildErythraTheme(),
      initialRoute: Routes.splash,
      routes: Routes.getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
