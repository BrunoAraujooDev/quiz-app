import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color.fromRGBO(3, 4, 94, 1)),
        child: Center(
          child: Column(children: [
            const Text('How to play:'),
            const Text(
                'Choose a subject or pick up randomly question with sorted themes.'),
            const Text(
                'try to answer the questions by click on the line that you assume that respond more correctly to make score.'),
            Container(
              width: 200,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 195, 0, 1),
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
            )
          ]),
        ),
      ),
    );
  }
}
