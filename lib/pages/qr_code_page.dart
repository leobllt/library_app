import 'package:flutter/material.dart';

// Página que exibe todos os detalhes do livro selecionado, bem como permite reservá-lo
class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso QRCode'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            const Text(
              "Nome Sobrenome",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            const Text(
              "a1233345",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Image.asset(
              "assets/imgs/QRCode.jpg",
              height: 250,
            )
          ],
        ),
      )
     );
  }
}