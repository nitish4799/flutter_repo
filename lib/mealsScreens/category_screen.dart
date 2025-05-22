import 'package:flutter/material.dart';
// import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/mealsScreens/category_grid_item.dart';
import 'package:flutter_repo/data/category_data.dart';
import 'package:flutter_repo/mealsScreens/meals_screen.dart';
import 'package:flutter_repo/models/category.dart';
import 'package:flutter_repo/models/meal.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(
    BuildContext context,
    String categoryTitle,
    List<Meal> mealsData,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) =>
                MealsScreen(meals: mealsData, categoryTitle: categoryTitle),
      ),
    );
  }

  List<Meal> getMealsByCategory(Category category) {
    return widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map(
            (category) => CategoryGridItem(
              category: category,
              selectCategory: () {
                _selectCategory(
                  context,
                  category.title,
                  getMealsByCategory(category),
                );
              },
            ),
          ),
        ],
      ),
      // builder:
      //     (context, child) => Padding(
      //       padding: EdgeInsets.only(
      //         top: 100 - _animationController.value * 100,
      //       ),
      //       child: child,
      //     ),
      // builder:
      //     (context, child) => SlideTransition(
      //       position: _animationController.drive(
      //         Tween(begin: Offset(0, 0.3), end: Offset(0, 0)),
      //       ),
      //       child: child,
      builder:
          (context, child) => SlideTransition(
            position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
    );
  }
}
