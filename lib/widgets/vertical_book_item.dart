import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/models/book.dart';
import 'package:provider/provider.dart';

// Classe que representa cada item de uma lista vertical, contendo uma image, dois labels e um botão
class VerticalBookItem extends StatelessWidget {
  final Book book;
  const VerticalBookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0,0,0, 0.03),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset(
                  book.imgSrc,
                  height: 100),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      book.author.join(", "),
                      style: const TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ),
            Flexible(
              //flex: 1,
              child: Center(
                child: Consumer<BooksController>(builder: (context, controller, _) {
                  return IconButton(
                    icon: const Icon(Icons.favorite), //controller.isFavorite(book.id), ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                    color: Colors.red, 
                    onPressed: () => {controller.removeFavorite(book)},
                  );
                }
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}