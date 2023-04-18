// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String id;
  final String category;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;
  final String question;
  final List<dynamic> tags;
  final String difficulty;

  Question({
    required this.id,
    required this.category,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.question,
    required this.tags,
    required this.difficulty,
  });
}
