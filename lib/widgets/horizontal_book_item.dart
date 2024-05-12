import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';

// Classe que representa cada item de uma lista horizontal, contendo uma imagem e um label abaixo dela
class HorizontalBookItem extends StatelessWidget {
  final Book book;
  const HorizontalBookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.asset(
              book.imgSrc,
              width: 90,
              height: 120,
              fit: BoxFit.contain,
              ),
            SizedBox(
              width: 90,
              child: Text(
                book.titulo.split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).toList().join(' '),  
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
    );
  }
}