import 'package:flutter/material.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:quiz_app/models/user.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuestionList list;
  late Future hasData;
  late final Categories categories;
  int questionIndex = 0;
  String selectedRadioTile = '';
  User username = User(name: 'Bruno', score: 0, hits: 0);

  @override
  void initState() {
    super.initState();
    List<String> categories =
        Provider.of<Categories>(context, listen: false).pickedCategories;

    list = QuestionList(categories);

    hasData = list.loadQuestions();
  }

  void _validateAnswer() {
    if (selectedRadioTile == list.question[questionIndex].correctAnswer) {
      username.increaseHits();
      username.scorePoints(100);
    }

    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quest = list.question[questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Questão ${questionIndex + 1}'),
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: 60,
            height: 60,
            child: CountDownProgressIndicator(
              duration: 30,
              labelTextStyle: const TextStyle(color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              valueColor: Theme.of(context).colorScheme.primary,
              onComplete: () {
                setState(() {
                  questionIndex++;
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
            future: hasData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${questionIndex + 1}- ${quest.question}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: quest.correctAnswer,
                      groupValue: selectedRadioTile,
                      title: Text(
                        quest.correctAnswer,
                        style: const TextStyle(fontSize: 17),
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedRadioTile = val!;
                        });
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: quest.incorrectAnswers.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromRGBO(246, 248, 249, 100),
                          ),
                          child: RadioListTile(
                            activeColor: Theme.of(context).colorScheme.primary,
                            tileColor: const Color.fromRGBO(246, 248, 249, 100),
                            value: quest.incorrectAnswers[index],
                            groupValue: selectedRadioTile,
                            title: Text(
                              quest.incorrectAnswers[index],
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
                              )),
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
              ;
            },
          ),
        ),
      ),
    );
  }
}
