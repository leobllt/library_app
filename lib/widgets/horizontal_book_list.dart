import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/widgets/horizontal_book_item.dart';

// Classe que exibe os livros horizontalmente, tal como um carrousel
// É possível exibir os detalhes de um livro ao clicá-lo
class HorizontalBookList extends StatelessWidget {
  final List<Book> list;
  const HorizontalBookList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: list.isEmpty ? const Center(child: Text('Nenhum até o momento')) : Scrollbar(
            controller: controller,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetailPage(book: list[index])),
                    );
                  },
                  child: HorizontalBookItem(book: list[index])
                  );
              },
            ),
          ),
        ),
      );
  }
}