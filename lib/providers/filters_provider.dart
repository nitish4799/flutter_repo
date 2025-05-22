import 'package:flutter_repo/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegeterian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegan: false,
        Filter.vegeterian: false,
      });

  void setFilters(Map<Filter, bool> chooseFilter) {
    state = chooseFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final providerMeals = ref.watch(mealsProvider);
  final choosenFilter = ref.watch(filtersProvider);
  return providerMeals
      .where(
        (meal) =>
            (meal.isGlutenFree && choosenFilter[Filter.glutenFree]!) ||
            (meal.isLactoseFree && choosenFilter[Filter.lactoseFree]!) ||
            (meal.isVegetarian && choosenFilter[Filter.vegeterian]!) ||
            (meal.isVegan && choosenFilter[Filter.vegan]!),
      )
      .toList();
});
