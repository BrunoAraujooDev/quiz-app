import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/exceptions/http_error.dart';

class Categories {
  Map<String, dynamic> _categories = {};
  String uri = 'https://the-trivia-api.com/api/categories';

  Map<String, List<String>> get categories {
    return {..._categories};
  }

  Future<void> loadCategories() async {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode >= 400) {
      throw HttpError(
          statusCode: response.statusCode,
          message: 'Houve um erro ao recuperar as categorias.');
    }

    final data = jsonDecode(response.body);

    _categories = data;

    print(_categories);
    print('oi');
  }
}
