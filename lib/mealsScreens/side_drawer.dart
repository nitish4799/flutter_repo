import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key, required this.selectScreen});
  final void Function(String identifier) selectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(136, 18, 16, 16),
                  const Color.fromARGB(133, 94, 75, 75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.fastfood, size: 48),
                SizedBox(width: 18),
                DitchText(text: 'Cooking Up!'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant, size: 26),
            title: DitchText(text: 'Meals'),
            onTap: () {
              selectScreen('meals');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 26),
            title: DitchText(text: 'Filters'),
            onTap: () {
              selectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
