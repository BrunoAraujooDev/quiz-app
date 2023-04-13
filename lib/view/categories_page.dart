import 'package:flutter/material.dart';
import 'package:quiz_app/components/category_card.dart';
import 'package:quiz_app/models/categories.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Categories().loadCategories().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Categories().categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a category bellow: '),
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryList.keys.toList().length,
              itemBuilder: (context, index) {
                return CategoryCard(categoryList.keys.toList()[index]);
              },
            ),
    );
  }
}
