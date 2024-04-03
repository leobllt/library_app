import 'package:flutter/material.dart';
import 'package:library_app/pages/notification_page.dart';

class HomeView extends StatelessWidget {
  final String username = "FULANO";
  const HomeView({super.key});

  static List<Map<String, dynamic>> livrosPendentes = [
    {"titulo": "Livro 1", "imagem": "assets/livro1.png"},
    {"titulo": "Livro 2", "imagem": "assets/livro2.png"},
    {"titulo": "Livro 3", "imagem": "assets/livro3.png"},
  ];

  static List<Map<String, dynamic>> livrosReservados = [
    {"titulo": "Livro A", "imagem": "assets/livroA.png"},
    {"titulo": "Livro B", "imagem": "assets/livroB.png"},
    {"titulo": "Livro C", "imagem": "assets/livroC.png"},
  ];

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
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          const Row(
            children:[
              Padding(padding: EdgeInsets.all(8)),
              Text(
                "Títulos pendentes",
                style: TextStyle(
                  fontFamily: 'jost',
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ],
          ),
           Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: livrosPendentes.length,
              itemBuilder: (context, index) {
                return GridTile(
                  footer: GridTileBar(
                    title: SizedBox(
                      width: double.infinity,
                      child: Text(
                        livrosPendentes[index]["titulo"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ),
                  child: Image.asset(
                    livrosPendentes[index]["imagem"],
                  ),
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          const Row(
            children:[
              Padding(padding: EdgeInsets.all(8)),
              Text(
                "Títulos reservados",
                style: TextStyle(
                  fontFamily: 'jost',
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: livrosReservados.length,
              itemBuilder: (context, index) {
                return GridTile(
                  footer: GridTileBar(
                    title: SizedBox(
                      width: double.infinity,
                      child: Text(
                        livrosReservados[index]["titulo"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ),
                  child: Image.asset(
                    livrosReservados[index]["imagem"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
