import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/categories.dart';

class CategoryCard extends StatefulWidget {
  final List<String> names;
  Function(String) modifyTotalCategories;
  Function() isIncrementable;

  CategoryCard(this.names, this.modifyTotalCategories, this.isIncrementable,
      {super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isSelected = false;
  late final Categories categories;

  @override
  void initState() {
    super.initState();
    categories = Provider.of<Categories>(context, listen: false);
  }

  String _filterCategoryWithUnderline() {
    List<String> auxCateg = widget.names.sublist(1);

    if (auxCateg.length > 1) {
      final underlineElement = auxCateg.where((e) => e.contains('_'));

      return underlineElement.toList()[0];
    } else {
      return auxCateg[0];
    }
  }

  void _pickCategory() {
    final categ = _filterCategoryWithUnderline();

    if (!_isSelected && widget.isIncrementable()) {
      categories.selectedCategory(categ);
      setState(() {
        _isSelected = !_isSelected;
      });

      widget.modifyTotalCategories('increment');
    } else if (categories.containsCategory(categ)) {
      setState(() {
        _isSelected = !_isSelected;
      });
      categories.removeCategories(categ);
      widget.modifyTotalCategories('decrement');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: _isSelected
            ? Colors.green
            : Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: _pickCategory,
          splashColor: const Color.fromRGBO(255, 214, 10, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.names[0],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }
}
