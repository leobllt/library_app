import 'package:flutter/material.dart';
import 'package:library_app/pages/login_page.dart';
import 'package:library_app/pages/navigation_page.dart';
import 'package:library_app/services/auth_services.dart';
import 'package:provider/provider.dart';

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
