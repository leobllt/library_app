import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Classe que representa cada item de uma lista vertical, contendo dois labels e um botão
class DebitsVerticalItem extends StatelessWidget {
  final Map<String,String> map;
  const DebitsVerticalItem({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0,0,0, 0.04),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                    overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Valor: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'R\$' + map.keys.first),
                        ],
                      ),
                    ),
              
                   RichText(
                    overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: '   Situação: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: map.values.first, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
  
                  ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                        Clipboard.setData(const ClipboardData(text: "debib-pg@utfpr.edu.br")).then(
                            (value){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Chave PIX copiada para área de transferência.")));
                            }
                          ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(20,184,143,1)),
                      ),
                      child: const Text('Pagar com PIX', style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),  
              ],
            )
          ],
        ),
      ),
    );
  }
}