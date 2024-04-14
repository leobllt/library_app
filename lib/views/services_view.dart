import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Serviços'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Option(text: "Perfil de interesse"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Solicitações"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Aquisição"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Comentários"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Base de dados"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Dados pessoais"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Plano de ensino"),
              Divider(
                color: Colors.black,
              ),
              _Option(text: "Solicitar token"),
              Divider(
                color: Colors.black,
              ),
            ],
          )
        )
      ),
    );
  }
}

class _Option extends StatelessWidget{
    final String text;
    const _Option({required this.text});

    @override
    Widget build(BuildContext context) {
      return CupertinoButton(
        onPressed: () {},
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(
              Icons.arrow_forward_sharp,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
                text,
                style: const TextStyle(
                color: Colors.black,
                fontFamily: 'jost',
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
  }