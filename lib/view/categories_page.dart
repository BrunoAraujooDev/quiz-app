import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/components/category_card.dart';
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/utils/app_routes.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _isLoading = true;
  List<dynamic> categoryList = [];
  int _totalCategories = 0;
  late final Categories categories;
  // Categories category = Categories();

  @override
  void initState() {
    super.initState();

    categories = Provider.of<Categories>(context, listen: false);
    categories.loadCategories().then((value) {
      setState(() {
        categoryList = value;
        _isLoading = false;
      });
    });
  }

  bool isIncrementable() {
    return _totalCategories < 3;
  }

  bool isDecrementable() {
    return _totalCategories >= 0;
  }

  void _countSelectedCategories(String modification) {
    if (modification == 'increment' && isIncrementable()) {
      setState(() {
        _totalCategories++;
      });
    } else if (modification == 'decrement' && isDecrementable()) {
      setState(() {
        _totalCategories--;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories '),
        centerTitle: true,
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.black87),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'Choose a category bellow: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          categoryList[index],
                          _countSelectedCategories,
                          isIncrementable,
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 20,
                      width: double.infinity,
                      child: Text(
                        'Total selected: ${_totalCategories.toString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      margin: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              )),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.questionPage,
                            );

                            print(categories.pickedCategories);
                          },
                          child: const Text(
                            'Continuar',
                            style: TextStyle(fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
