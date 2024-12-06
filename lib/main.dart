<<<<<<< HEAD
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:listo/core/theme/theme.dart';
import 'package:listo/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.homePage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
=======
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
import 'package:flutter/material.dart';
import 'package:listo/core/theme/theme.dart';
import 'package:listo/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.homePage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
<<<<<<< HEAD
=======
>>>>>>> 21e5289 (initial commit)
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
