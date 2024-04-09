import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';

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
                      book.title,  
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        )
    );
  }
}