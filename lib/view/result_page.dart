import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/utils/app_routes.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Total score: ${user.score}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  )),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AppRoutes.categoriesPage);
              },
              child: const Text(
                'Retonar ao menu',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
