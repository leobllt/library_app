import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/widgets/vertical_book_list.dart';
import 'package:provider/provider.dart';

// Classe que exibe livros favoritados pelo usuário
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<BooksController>(builder: (context, controller, _) {
        final favoriteBooks = controller.favoriteBooks;

        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return VerticalBookList(list: favoriteBooks);
            
      }
      )
    );
  }
}