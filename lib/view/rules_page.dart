import 'package:flutter/material.dart';
import 'package:quiz_app/utils/app_routes.dart';

class RulesPage extends StatelessWidget {
  RulesPage({super.key});

  final List<String> tutorial = [
    'Choose a subject or more (three at max).',
    'Try to answer the questions that you assume that respond more correctly to make score.',
    'Remember to answer the question as fast as you can to win bonus points.',
    'At the end, it will be presented your score.',
    'Challenge yourself and try again to make more points and raise your score!'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How to play:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tutorial.length,
                  itemBuilder: (context, index) {
                    return Wrap(
                      children: [
                        Text(
                          "\u2022 ${tutorial[index]}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(AppRoutes.categoriesPage),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                        child: const Text(
                          'Play',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
