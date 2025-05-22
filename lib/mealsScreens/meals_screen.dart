import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/mealsScreens/meal_item.dart';
import 'package:flutter_repo/mealsScreens/meal_item_screen.dart';
import 'package:flutter_repo/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.categoryTitle,
    // this.toggleFavoriteMealIds,
  });
  final String? categoryTitle;
  final List<Meal> meals;
  // final void Function(String)? toggleFavoriteMealIds;

  void _selecteMealItem(BuildContext context, int idx) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealItemScreen(
              meal: meals[idx],
              // toggleFavoriteMealIds: toggleFavoriteMealIds!,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder:
          (ctx, index) => MealItem(
            meal: meals[index],
            selectMealItem: () {
              _selecteMealItem(context, index);
            },
          ),
    );
    if (meals.isEmpty) {
      content = DitchText(text: 'bhai jaan nhi hai kuch khaane ka ');
    }

    if (categoryTitle == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: DitchText(text: categoryTitle!)),
      body: content,
    );
  }
}
