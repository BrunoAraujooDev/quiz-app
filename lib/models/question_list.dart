// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:quiz_app/exceptions/http_error.dart';
import 'package:quiz_app/models/question.dart';

class QuestionList extends ChangeNotifier {
  List<Question> _questions = [];
  String url = 'https://the-trivia-api.com/api/questions?limit=10&categories=';
  List<String> categories;
  QuestionList([this.categories = const []]);

  List<Question> get question {
    return [..._questions];
  }

  int get listLength {
    return _questions.length;
  }

  String _transformToString() {
    String categAsString = categories.join(',');
    return categAsString;
  }

  Future<bool> loadQuestions() async {
    String categ = _transformToString();

    final response = await http.get(Uri.parse('$url$categ'));

    if (response.statusCode >= 400) {
      throw HttpError(
          statusCode: response.statusCode,
          message: 'Não foi possível carregar as informações.');
    }

    final result = jsonDecode(response.body);

    for (int i = 0; i < result.length; i++) {
      _questions.add(Question(
        id: result[i]['id'],
        category: result[i]['category'],
        correctAnswer: result[i]['correctAnswer'],
        incorrectAnswers: result[i]['incorrectAnswers'],
        question: result[i]['question'],
        tags: result[i]['tags'],
        difficulty: result[i]['difficulty'],
      ));
    }

    return true;
  }
}
