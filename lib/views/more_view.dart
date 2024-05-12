import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Opções'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Option(text: "Meus dados"),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Débitos"),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Histórico"),
              const Divider(
                color: Colors.black,
              ),
              const _Option(text: "Declaração de nada consta"),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => context.read<AuthService>().logout(),
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 233, 126, 126))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Sair da conta', style: TextStyle(color: Colors.black, fontSize: 16),)
                        )
                      ],
                    ),
                  ),
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
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
  }