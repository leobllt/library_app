import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/favorite_repository.dart';
import 'package:library_app/repositories/user_books_repository.dart';
import 'package:provider/provider.dart';

// Classe que representa cada item de uma lista vertical, contendo uma image, dois labels e um botão
class VerticalBookItem extends StatelessWidget {
  final Book book;
  final bool isHistoryItem;
  const VerticalBookItem({super.key, required this.book, required this.isHistoryItem});

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
              child: Image.network(
                  book.url,
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
                      book.titulo.split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).toList().join(' '),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      book.autores.map((e) => e.split(', ').map((e) => e[0].toUpperCase() + e.substring(1)).toList().join(', ')).toList().join(', '),
                      style: const TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    (isHistoryItem) ? Padding(
                                        padding: const EdgeInsets.fromLTRB(0,5,0,0),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                const TextSpan(text: 'Entregue em ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                TextSpan(text: '${context.watch<UserBooksRepository>().historyMap[book]!.day.toString()}'
                                                      +'/${context.watch<UserBooksRepository>().historyMap[book]!.month.toString()}'
                                                      +'/${context.watch<UserBooksRepository>().historyMap[book]!.year.toString()}'
                                                ),
                                              ],
                                            ),
                                          ),
                                      )
                                    : const SizedBox.shrink()
                  ],
                ),
              )
            ),
            (!isHistoryItem) ? Flexible(
                                child: Center(
                                  child: Consumer<FavoriteRepository>(
                                      builder: (context, favorite, _){
                                        return IconButton(
                                          icon: (favorite.lista.contains(book)) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                                          color: Colors.red, 
                                          onPressed: () => {(favorite.lista.contains(book)) ? favorite.remove(book) : favorite.save(book)},
                                        );
                                      }
                                  )
                                )
                              )
                            : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}