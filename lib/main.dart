import 'package:flutter/material.dart';
import 'package:quiz_app/utils/app_routes.dart';
import 'package:quiz_app/view/landing_page.dart';
import 'package:quiz_app/view/rules_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.landingPage: (ctx) => const LandingPage(),
        AppRoutes.rulesPage: (ctx) => const RulesPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
