import 'package:flutter/material.dart';
import 'package:library_app/pages/navigation_page.dart';

// Aqui ficam as configurações gerais do app
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Biblioteca",
      theme: ThemeData(
        fontFamily: 'Jost',
        scaffoldBackgroundColor: const Color.fromRGBO(252, 252, 255, 1),
      ),
      home: const NavigationPage(),
    );
  }
}
