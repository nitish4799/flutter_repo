import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/gradient_container.dart';
import 'package:flutter_repo/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.selectCategory,
  });

  final void Function() selectCategory;

  final Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: selectCategory,
        borderRadius: BorderRadius.circular(16),
        splashColor: Theme.of(context).primaryColor,
        child: GradientContainer(
          padding: EdgeInsets.symmetric(vertical: 10),
          borderRadius: BorderRadius.circular(16),
          gradientColor: [
            category.color.withAlpha(150),
            category.color.withAlpha(225),
          ],
          columnWidgets: [DitchText(text: category.title)],
        ),
      ),
    );
  }
}
