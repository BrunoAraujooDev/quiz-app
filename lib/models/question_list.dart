import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/exceptions/http_error.dart';
import 'package:quiz_app/models/question.dart';

class QuestionList {
  List<Question> _questions = [];
  String url = 'https://the-trivia-api.com/api/questions?limit=10';

  List<Question> get question {
    return [..._questions];
  }

  Future<void> loadQuestions() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode >= 400) {
      throw HttpError(
          statusCode: response.statusCode,
          message: 'Não foi possível carregar as informações.');
    }

    final result = jsonDecode(response.body);

    result.map((item) => {
          _questions.add(Question(
            id: item.id,
            category: item.category,
            correctAnswer: item.correctAnswer,
            incorrectAnswers: item.incorrectAnswers,
            question: item.question,
            tags: item.tags,
            difficulty: item.difficulty,
          ))
        });
  }
}
