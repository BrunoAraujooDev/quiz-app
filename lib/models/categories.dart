// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:quiz_app/exceptions/http_error.dart';

class Categories extends ChangeNotifier {
  final List<List<String>> _categories = [];
  final List<String> pickedCategories = [];
  String uri = 'https://the-trivia-api.com/api/categories';

  List<List<String>> get categories => [..._categories];

  Future<dynamic> loadCategories() async {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode >= 400) {
      throw HttpError(
          statusCode: response.statusCode,
          message: 'Houve um erro ao recuperar as categorias.');
    }

    final data = jsonDecode(response.body);

    for (var item in data.keys) {
      List<String> auxCategories = [];
      auxCategories.add(item);

      for (var i = 0; i < data[item].length; i++) {
        auxCategories.add(data[item][i]);
      }

      _categories.add(auxCategories);
    }

    return [..._categories];
  }

  void selectedCategory(String categ) {
    print('antes de selecionar $pickedCategories');

    pickedCategories.add(categ);

    notifyListeners();
  }

  void removeCategories(String categ) {
    pickedCategories.removeWhere((element) => element.contains(categ));
    notifyListeners();
  }

  bool containsCategory(String categ) {
    return pickedCategories.contains(categ);
  }
}
