import 'package:flutter/material.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:quiz_app/models/question_list.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    QuestionList list = QuestionList();

    list.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Questão um'),
              // RadioListTile(value: 0, groupValue: '', onChanged: () {}),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CountDownProgressIndicator(
                      duration: 30,
                      backgroundColor: Colors.yellow,
                      valueColor: Colors.red,
                      onComplete: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
