import 'package:flutter/material.dart';
import 'package:library_app/pages/login_page.dart';
import 'package:library_app/pages/navigation_page.dart';
import 'package:library_app/services/auth_service.dart';
import 'package:provider/provider.dart';

// Classe que alterna entre área de login e área funcional do app (com usuário já autenticado)
class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if(auth.isLoading)
      return loading();
    else if(auth.usuario == null)
      return LoginPage();
    else
      return const NavigationPage();
  }

  Widget loading(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
