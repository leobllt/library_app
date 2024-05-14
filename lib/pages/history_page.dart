import 'package:flutter/material.dart';
import 'package:library_app/repositories/user_books_repository.dart';
import 'package:library_app/widgets/vertical_book_list.dart';
import 'package:provider/provider.dart';

// Classe que exibe livros favoritados pelo usuário
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<UserBooksRepository>(
        builder: (context, userData, _) {
          return VerticalBookList(list: userData.historyMap.keys.toList(), isHistoryList: true);
      }
      )
    );
  }
}