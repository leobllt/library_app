import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/pages/navigation_page.dart';
import 'package:library_app/repositories/books_repository.dart';
import 'package:library_app/repositories/memory_books_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<BooksRepository>(
          create: (_) => MemoryBooksRepository(),
        ),
        ChangeNotifierProvider<BooksController>(
          create: (context) => BooksController(context.read<BooksRepository>()),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Library App",
      theme: ThemeData(
        fontFamily: 'Jost',
        scaffoldBackgroundColor:  const Color.fromRGBO(252, 252, 255, 1),
      ),
      home: const NavigationPage(),
    );
  }
}

