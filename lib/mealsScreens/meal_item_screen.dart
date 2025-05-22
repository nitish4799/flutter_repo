import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/meal.dart';
import 'package:flutter_repo/providers/favorites_provider.dart';
// import 'package:flutter_repo/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealItemScreen extends ConsumerWidget {
  const MealItemScreen({
    super.key,
    required this.meal,
    // required this.toggleFavoriteMealIds,
  });
  final Meal meal;
  // final void Function(String) toggleFavoriteMealIds;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeals = ref.watch(favoriteMealsProvider);
    return Scaffold(
      appBar: AppBar(
        title: DitchText(text: meal.title),
        actions: [
          IconButton(
            onPressed: () {
              // toggleFavoriteMealIds(meal.id);
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: DitchText(
                    text:
                        'Meal ${wasAdded ? 'added to' : 'removed from'} favorites',
                    color: Colors.black,
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                favMeals.contains(meal)
                    ? Icons.star
                    : Icons.star_border_outlined,
                key: ValueKey(favMeals.contains(meal)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            DitchText(
              text: 'Ingredients',
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 15),
            for (final ingredient in meal.ingredients)
              DitchText(text: ingredient, fontSize: 15),
            SizedBox(height: 24),
            DitchText(
              text: 'Recipe',
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
            for (var i = 0; i < meal.steps.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DitchText(
                      text: '${i + 1}.',
                      fontSize: 15,
                      align: TextAlign.left,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DitchText(
                        text: meal.steps[i],
                        fontSize: 15,
                        align: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
