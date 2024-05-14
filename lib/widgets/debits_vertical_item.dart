import 'package:flutter/material.dart';

// Classe que representa cada item de uma lista vertical, contendo dois labels e um botão
class DebitsVerticalItem extends StatelessWidget {
  final Map<String,String> map;
  const DebitsVerticalItem({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.fromLTRB(10.0, 2, 10, 2),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0,0,0, 0.04),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
               flex: 2,
              child: RichText(
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
            ),
              Expanded(
                flex: 3,
                child: RichText(
                overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: '   Situação: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: map.values.first, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextButton(child: Text('Pagar', style: TextStyle(color: Colors.black),),onPressed: () => {}, 
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(20,184,143,1)),
                  )
                  ,)
              )
          ],
        ),
      ),
    );
  }
}