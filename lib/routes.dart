import 'package:flutter/material.dart';

class Routes {
  static const String startPage = '/start';
  static const String loginPage = '/login';
  static const String registerPage = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case loginPage:
      //   return MaterialPageRoute(builder: (_) => const Login());
      // case registerPage:
      //   return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
                child: Text(
              'Bienvenue dans LISTO',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
          ),
        );
    }
  }
}
