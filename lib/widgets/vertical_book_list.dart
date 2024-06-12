import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/widgets/vertical_book_item.dart';

// Classe que exibe os livros verticalmente
// É possível exibir os detalhes de um livro ao clicá-lo
class VerticalBookList extends StatelessWidget {
  final List<Book> list;
  final bool isHistoryList;
  const VerticalBookList({super.key, required this.list, required this.isHistoryList});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Container(
        padding: const EdgeInsets.all(8.0),
          child: list.isEmpty ? const Center(child: Text('Nenhum até o momento')) : Scrollbar(
            controller: controller,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap:  () {
                    (!isHistoryList) ? Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BookDetailPage(book: list[index])),
                                        )
                                      : {};
                  },
                  child: VerticalBookItem(book: list[index], isHistoryItem: isHistoryList)
                  );
              },
            ),
          ),
    );
  }
}