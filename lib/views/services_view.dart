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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CupertinoButton(
              onPressed: () {},
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Perfil de interesse",
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'jost',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
             CupertinoButton(
              onPressed: () {},
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Solicitações",
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'jost',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
             CupertinoButton(
              onPressed: () {},
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Solicitar Token",
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'jost',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        )
      ),
    );
  }
}
