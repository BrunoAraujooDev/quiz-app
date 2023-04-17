import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/utils/app_routes.dart';
import 'package:quiz_app/view/categories_page.dart';
import 'package:quiz_app/view/landing_page.dart';
import 'package:quiz_app/view/question_page.dart';
import 'package:quiz_app/view/rules_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Categories(),
        )
      ],
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color.fromRGBO(3, 4, 94, 1),
                  secondary: const Color.fromRGBO(255, 195, 0, 1),
                )),
        routes: {
          AppRoutes.landingPage: (ctx) => const LandingPage(),
          AppRoutes.rulesPage: (ctx) => RulesPage(),
          AppRoutes.categoriesPage: (ctx) => const CategoriesPage(),
          AppRoutes.questionPage: (ctx) => const QuestionPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
