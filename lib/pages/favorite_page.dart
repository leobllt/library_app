import 'package:flutter/material.dart';
import 'package:library_app/repositories/favorite_repository.dart';
import 'package:library_app/widgets/vertical_book_list.dart';
import 'package:provider/provider.dart';

// Classe que exibe livros favoritados pelo usuário
class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<FavoriteRepository>(
        builder: (context, favorite, _) {
        if(favorite.isLoading) 
          return const Center(child: SizedBox(width: 40, height: 40,child: CircularProgressIndicator()),);
        else
          return VerticalBookList(list: favorite.lista);
      }
      )
    );
  }
}