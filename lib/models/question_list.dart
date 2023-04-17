// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quiz_app/exceptions/http_error.dart';
import 'package:quiz_app/models/question.dart';

class QuestionList {
  List<Question> _questions = [];
  String url = 'https://the-trivia-api.com/api/questions?limit=10&categories=';
  List<String> categories;
  QuestionList(this.categories);

  List<Question> get question {
    return [..._questions];
  }

  String _transformToString() {
    String categAsString = categories.join(',');

    // for (int i = 0; i < categories.length; i++) {
    //   categAsString += categories[i];
    // }

    return categAsString;
  }

  Future<void> loadQuestions() async {
    String categ = _transformToString();

    final response = await http.get(Uri.parse('$url$categ'));

    if (response.statusCode >= 400) {
      throw HttpError(
          statusCode: response.statusCode,
          message: 'Não foi possível carregar as informações.');
    }

    final result = jsonDecode(response.body);

    await result.map((item) {
      //não tá adicionando ao vetor, provavelmente vai ter que tirar o map zzz
      print(item);
      _questions.add(Question(
        id: item.id,
        category: item.category,
        correctAnswer: item.correctAnswer,
        incorrectAnswers: item.incorrectAnswers,
        question: item.question,
        tags: item.tags,
        difficulty: item.difficulty,
      ));
    });
    print(_questions);
  }
}
