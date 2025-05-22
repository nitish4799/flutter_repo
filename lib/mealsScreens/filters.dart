import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
// import 'package:flutter_repo/mealsScreens/side_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_repo/providers/filters_provider.dart';

class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: DitchText(text: 'Your Filters')),
      body:
      // PopScope(
      //   canPop: false,
      //   onPopInvokedWithResult: (bool didPop, dynamic result) {
      //     if (didPop) {
      //       return;
      //     }
      //     ref.read(filtersProvider.notifier).setFilters({
      //       Filter.glutenFree: glutenFreeFilterSet,
      //       Filter.lactoseFree: lactoseFreeFilterSet,
      //       Filter.vegeterian: vegFreeFilterSet,
      //       Filter.vegan: veganFreeFilterSet,
      //     });
      //     Navigator.of(context).pop();
      //   },
      // child:
      Column(
        children: [
          SwitchListTile(
            // value: glutenFreeFilterSet,
            value: filters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: DitchText(text: 'GLuten Free'),
            subtitle: DitchText(
              text: 'Only inldude gluten free food.',
              fontSize: 15,
            ),
            activeColor: Colors.green,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: filters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: DitchText(text: 'Lactose Free'),
            subtitle: DitchText(
              text: 'Only inldude Lactose free food.',
              fontSize: 15,
            ),
            activeColor: Colors.green,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: filters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: DitchText(text: 'Vegan'),
            subtitle: DitchText(text: 'Only Vegan food.', fontSize: 15),
            activeColor: Colors.green,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: filters[Filter.vegeterian]!,
            onChanged: (isChecked) {
              ref
                  .watch(filtersProvider.notifier)
                  .setFilter(Filter.vegeterian, isChecked);
            },
            title: DitchText(text: 'Vegeterian'),
            subtitle: DitchText(text: 'Only Veg food.', fontSize: 15),
            activeColor: Colors.green,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
    // );
  }
}
