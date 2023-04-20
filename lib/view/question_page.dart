import 'dart:math';

import 'package:flutter/material.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/utils/app_routes.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Question> list;
  Future<bool>? _future;
  int questionIndex = 0;
  String selectedRadioTile = '';
  late User username;
  int listLength = 0;
  int timerDuration = 30;
  final _controller = CountDownController();
  List<String> mixedAnswers = [];
  bool _getColor = false;

  @override
  void initState() {
    super.initState();

    final auxList = Provider.of<QuestionList>(context, listen: false);

    username = Provider.of<User>(context, listen: false);

    _future = auxList.loadQuestions().then((value) {
      list = auxList.question;
      listLength = auxList.listLength;

      _createMixedList();

      return value;
    });
  }

  _validateColor(int index) {
    if (list[questionIndex].correctAnswer == mixedAnswers[index] && _getColor) {
      //Color.fromARGB(255, 169, 247, 172);
      return const LinearGradient(
        colors: [
          Color.fromRGBO(130, 210, 146, 1),
          Color.fromRGBO(246, 248, 249, 1)
        ],
      );
    } else if (_getColor) {
      //const Color.fromARGB(255, 243, 155, 153);
      return const LinearGradient(colors: [
        Color.fromRGBO(210, 130, 130, 1),
        Color.fromRGBO(246, 248, 249, 1)
      ]);
    }

    //return const Color.fromRGBO(246, 248, 249, 100);
    return const LinearGradient(colors: [
      Color.fromRGBO(236, 235, 235, 1),
      Color.fromRGBO(246, 248, 249, 1)
    ]);
  }

  void _validateAnswer() {
    if (selectedRadioTile == list[questionIndex].correctAnswer) {
      username.increaseHits();
      username.scorePoints(100);
    }

    setState(() {
      _getColor = true;
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (listLength == questionIndex + 1) {
        Navigator.of(context).popAndPushNamed(AppRoutes.resultPage);
      } else {
        setState(() {
          _getColor = false;
          questionIndex++;
        });
        _controller.restart(initialPosition: 0);
        _createMixedList();
      }
    });
  }

  void _createMixedList() {
    List<dynamic> auxList = [];
    mixedAnswers.clear();
    auxList.add(list[questionIndex].correctAnswer);
    int max = list[questionIndex].incorrectAnswers.length;
    int total = list[questionIndex].incorrectAnswers.length;

    for (int i = 0; i < max; i++) {
      auxList.add(list[questionIndex].incorrectAnswers[i]);
    }

    for (int j = 0; j <= max; j++) {
      if (total > 0) {
        var random = Random().nextInt(total);
        mixedAnswers.add(auxList[random]);
        auxList.removeAt(random);
      } else {
        mixedAnswers.add(auxList[0]);
      }

      total--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questão ${questionIndex + 1}'),
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: 60,
            height: 60,
            child: CountDownProgressIndicator(
              controller: _controller,
              duration: timerDuration,
              labelTextStyle: const TextStyle(color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              valueColor: Theme.of(context).colorScheme.primary,
              onComplete: () {
                setState(() {
                  _getColor = true;
                });
              },
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 25),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${questionIndex + 1}- ${list[questionIndex].question}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: mixedAnswers.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: _validateColor(index),
                          ),
                          child: RadioListTile(
                            activeColor: Theme.of(context).colorScheme.primary,
                            tileColor: const Color.fromRGBO(246, 248, 249, 100),
                            value: mixedAnswers[index],
                            groupValue: selectedRadioTile,
                            title: Text(
                              mixedAnswers[index],
                              style: const TextStyle(fontSize: 17),
                            ),
                            onChanged: (val) {
                              setState(() {
                                selectedRadioTile = val!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          margin: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                )),
                            onPressed: _validateAnswer,
                            child: const Text(
                              'Next',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
