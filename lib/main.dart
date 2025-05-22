import 'package:flutter/material.dart';
// import 'package:flutter_repo/mealsScreens/category_screen.dart';
import 'package:flutter_repo/mealsScreens/tabs.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_repo/expensesscreens/expenses.dart';
// import 'package:flutter_repo/quiz.dart';
// import 'package:flutter_repo/quizscreens/start_screen.dart';
// import 'gradient_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.black12);
// var kDarkColorScheme = ColorScheme.fromSeed(
//   seedColor: Colors.indigo,
//   brightness: Brightness.dark,
// );

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) {
  // runApp(
  //   MaterialApp(
  //     darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
  //       colorScheme: kDarkColorScheme,
  //       cardTheme: CardTheme().copyWith(
  //         color: kDarkColorScheme.secondaryContainer,
  //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       ),
  //     ),
  //     theme: ThemeData.from(
  //       colorScheme: kColorScheme,
  //       useMaterial3: true,
  //     ).copyWith(
  //       appBarTheme: const AppBarTheme().copyWith(
  //         backgroundColor: kColorScheme.onPrimaryContainer,
  //         foregroundColor: kColorScheme.primaryContainer,
  //       ),
  //       cardTheme: CardTheme().copyWith(
  //         color: kColorScheme.secondaryContainer,
  //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       ),
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: kColorScheme.primaryContainer,
  //         ),
  //       ),
  //       textTheme: ThemeData().textTheme.copyWith(
  //         titleLarge: TextStyle(
  //           fontWeight: FontWeight.normal,
  //           fontSize: 14,
  //           color: kColorScheme.onSecondaryContainer,
  //         ),
  //       ),
  //     ),
  //     themeMode: ThemeMode.system,
  //     home: const Expenses(),
  //   ),
  // );
  // });
  // runApp(MaterialApp(home: Scaffold(body: GradientContainer())));
  // runApp(Quiz());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: Tabs());
  }
}
