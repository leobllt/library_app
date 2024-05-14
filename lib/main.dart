import 'package:flutter/material.dart';
import 'package:library_app/repositories/favorite_repository.dart';
import 'package:library_app/repositories/user_books_repository.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:library_app/services/auth_services.dart';
import 'package:library_app/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => UserDataRepository(
            auth: context.read<AuthService>(),
          )
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteRepository(
            auth: context.read<AuthService>(),
          )
        ),
        ChangeNotifierProvider(
          create: (context) => UserBooksRepository(
            auth: context.read<AuthService>(),
          )
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
      home: const AuthCheck(),
    );
  }
}

