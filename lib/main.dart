import 'package:flutter/material.dart';
import 'package:super_hero/screens/hero/detail/hero_detail_screen.dart';
import 'package:super_hero/screens/hero/hero_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuperHero app',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: HeroScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/heroDetail':
      return MaterialPageRoute(
        builder: (_) => HeroDetailScreen(
          hero: settings.arguments,
        ),
      );
      break;
    case '/':
    default:
      return MaterialPageRoute(
        builder: (_) => HeroScreen(),
      );
      break;
  }
}
