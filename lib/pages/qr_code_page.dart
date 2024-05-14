import 'package:flutter/material.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:provider/provider.dart';


// Página que exibe todos os detalhes do livro selecionado, bem como permite reservá-lo
class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});
  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage>{
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
            Text(
              '${context.watch<UserDataRepository>().contaLogada?.nome} ${context.watch<UserDataRepository>().contaLogada?.sobrenome}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Text(
              context.watch<UserDataRepository>().contaLogada?.ra ?? '----',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Image.network(context.watch<UserDataRepository>().contaLogada!.qr)
          ],
        ),
      )
     );
  }
}