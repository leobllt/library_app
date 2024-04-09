import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/pages/book_detail.dart';
import 'package:library_app/widgets/horizontal_book_item.dart';

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
                      MaterialPageRoute(builder: (context) => BookDetail(book: list[index], reservar: (id)=>{},)),
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