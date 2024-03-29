import 'package:flutter/material.dart';
import 'package:library_app/pages/notification_page.dart';

class HomeView extends StatelessWidget {
  final String username = "FULANO";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, $username!"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            }, 
          ),
        ],
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
    body: const Center(child: Text("Início")),
    );
  }
}