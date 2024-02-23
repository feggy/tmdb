import 'package:flutter/material.dart';
import 'package:tmdb/app/core/config/build_config.dart';
import 'package:tmdb/app/routes/app_pages.dart';
import 'package:tmdb/app/routes/app_routes.dart';

Future launchApp(Env environment) async {
  BuildConfig.setEnvironment(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.init,
      routes: routes,
    );
  }
}
