import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/pages/book_detail.dart';
import 'package:library_app/widgets/vertical_book_item.dart';

class VerticalBookList extends StatelessWidget {
  final List<Book> list;
  const VerticalBookList({super.key, required this.list});

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetail(book: list[index], reservar: (id)=>{},)),
                    );
                  },
                  child: VerticalBookItem(book: list[index])
                  );
              },
            ),
          ),
    );
  }
}