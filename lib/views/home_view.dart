import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/pages/favorite_page.dart';
import 'package:library_app/pages/qr_code_page.dart';
import 'package:library_app/widgets/horizontal_book_list.dart';
import 'package:library_app/widgets/section_heading.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// View principal, que exibe os livros emprestados e reservados
class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Olá, PESSOA!"),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrCodePage()),
              );
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            }, 
          ),
        ],
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<BooksController>(builder: (context, controller, _) {
        final reservedBooks = controller.reservedBooks;

        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(15)),
            const SectionHeading(headTitle: "Títulos emprestados", icondata: Icons.library_add_check),
            HorizontalBookList(list: controller.borrowedBooks),
            const Padding(padding: EdgeInsets.all(20)),
            const SectionHeading(headTitle: "Títulos reservados", icondata: Icons.bookmark),
            HorizontalBookList(list: reservedBooks)
          ],
        );
        }),
     );
  }
}