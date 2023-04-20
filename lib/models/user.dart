// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String name;
  int score;
  int hits;

  User({
    required this.name,
    required this.score,
    required this.hits,
  });

  String get username {
    return name;
  }

  int get totalScore {
    return score;
  }

  int get totalhits {
    return hits;
  }

  void createName(String newName) {
    name = newName;

    notifyListeners();
  }

  void scorePoints(int points) {
    score += points;
    notifyListeners();
  }

  void increaseHits() {
    hits++;
    notifyListeners();
  }

  void resetPoints() {
    score = 0;
    hits = 0;
  }
}
