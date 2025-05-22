import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_repo/data/category_data.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/mealsScreens/category_screen.dart';
import 'package:flutter_repo/mealsScreens/favorites.dart';
import 'package:flutter_repo/mealsScreens/filters.dart';
import 'package:flutter_repo/mealsScreens/side_drawer.dart';
import 'package:flutter_repo/models/meal.dart';
// import 'package:flutter_repo/providers/meals_provider.dart';
import 'package:flutter_repo/providers/favorites_provider.dart';
import 'package:flutter_repo/providers/filters_provider.dart';

// const Map<Filter, bool> defaultFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegan: false,
//   Filter.vegeterian: false,
// };

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});
  @override
  ConsumerState<Tabs> createState() {
    return _Tabs();
  }
}

class _Tabs extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;
  List<String> mealIds = [];
  // Map<Filter, bool> filters = defaultFilters;

  // void toggleFavoriteMealIds(String id) {
  //   if (mealIds.contains(id)) {
  //     mealIds.remove(id);
  //     showInfoMessage('Meal removed from favorites!');
  //   } else {
  //     mealIds.add(id);
  //     showInfoMessage('Meal added from favorites!');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void setScreen(String idt) async {
    Navigator.pop(context);
    if (idt == 'filters') {
      Navigator.of(
        context,
      ).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => Filters()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoryScreen(availableMeals: availableMeals);
    var acitvePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = Favorites(mealIds: mealIds, meals: favoriteMeals);
      acitvePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: DitchText(text: acitvePageTitle)),
      body: activePage,
      drawer: SideDrawer(selectScreen: setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
