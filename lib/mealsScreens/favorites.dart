import 'package:flutter/material.dart';
// import 'package:flutter_repo/data/category_data.dart';
import 'package:flutter_repo/mealsScreens/meals_screen.dart';
import 'package:flutter_repo/models/meal.dart';
// import 'package:flutter_repo/providers/favorites_provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key, required this.mealIds, required this.meals});
  final List<Meal> meals;

  final List<String> mealIds;

  @override
  Widget build(BuildContext context) {
    // final favoriteMeals =
    //     dummyMeals.where((meal) => mealIds.contains(meal.id)).toList();

    return MealsScreen(meals: meals);
  }
}
