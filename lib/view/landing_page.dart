import 'package:flutter/material.dart';
import 'package:quiz_app/utils/app_routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color.fromRGBO(3, 4, 94, 1)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A quiz that challenges your knowlegde!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.rulesPage),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 195, 0, 1),
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  'Rules',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
