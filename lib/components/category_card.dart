import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String name;

  const CategoryCard(this.name, {super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          splashColor: const Color.fromRGBO(255, 214, 10, 1),
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
