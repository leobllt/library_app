import 'package:flutter/material.dart';
import 'package:library_app/views/home_view.dart';
import 'package:library_app/views/map_view.dart';
import 'package:library_app/views/search_view.dart';
import 'package:library_app/views/more_view.dart';

// Esta classe engloba toda a navegação entre as views (pelo menu inferior)
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _State();
}

class _State extends State<NavigationPage> {
  int currentViewIndex = 0; 

  static const List<Widget> _views = [
    HomeView(),
    SearchView(),
    MapView(),
    MoreView(),
  ];

  // método padrão para poder alterar entre views pelo menu
  void _onItemTapped(int index) {
    setState(() {
      currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views.elementAt(currentViewIndex),
      bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: const Color.fromRGBO(20,184,143, 1),
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Busca',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_sharp),
          label: 'Unidades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Mais',
        ),
      ],
      currentIndex: currentViewIndex,
      onTap: _onItemTapped,
    ),
    );
  }
}
