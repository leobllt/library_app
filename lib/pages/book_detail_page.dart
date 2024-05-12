import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/favorite_repository.dart';
import 'package:library_app/repositories/user_books_repository.dart';
import 'package:provider/provider.dart';

// Página que exibe todos os detalhes do livro selecionado, bem como permite reservá-lo
class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10),),
            Center(
              child: SizedBox(
                height: 200,
                child: Image.asset(book.imgSrc)
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0,0,0, 0.08),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1), // Define a largura da primeira coluna
                      1: FlexColumnWidth(2), // Define a largura da segunda coluna
                    },
                    children: [
                      _buildTableRow('Título:', book.titulo.split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).toList().join(' ')),
                      _buildTableRow('Autor(es):', book.autores.map((e) => e.split(', ').map((e) => e[0].toUpperCase() + e.substring(1)).toList().join(', ')).toList().join(', ')),
                      _buildTableRow('Ano de publicação:', book.anoPublicacao),
                      _buildTableRow('N. de páginas:', book.numeroPaginas),
                      _buildTableRow('Assunto principal:', book.areaPrincipal),
                    ],
                  ),
            ),
            Consumer<UserBooksRepository>(builder: (context, userBooks, _) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0,0,0, 0.08),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1), // Define a largura da primeira coluna
                        1: FlexColumnWidth(2), // Define a largura da segunda coluna
                      },
                      children: [
                        (userBooks.borrowedList.keys.contains(book)) 
                        ? _buildTableRow('Data entrega:', 
                                        '${userBooks.borrowedList[book]!.day.toString()}/${userBooks.borrowedList[book]!.month.toString()}') 
                        : _buildTableRow('Status:', (book.disponivel) ? 'Disponível' : 'Indisponível')
                      ],
                    ),
                );
            })
          ],
        ),
      ),
      floatingActionButtonLocation:
        FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Verifica se já foi emprestado. Se não foi, permite reserva
            Consumer<UserBooksRepository>(
              builder: (context, userBooks, _) {
                return userBooks.borrowedList.keys.contains(book) ? const SizedBox.shrink() 
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                          child: FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: userBooks.reservedList.contains(book) ? (){userBooks.removeReserved(book);} : (){userBooks.saveReserved(book);},
                            backgroundColor: const Color.fromARGB(195, 0, 230, 172),
                            child: userBooks.reservedList.contains(book) ? const Icon(Icons.bookmark, color: Colors.white,) : const Icon(Icons.bookmark_outline, color: Colors.white,),
                          ),);
            }),
            Consumer<FavoriteRepository>(
              builder: (context, favorite, _) {
                return FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: favorite.lista.contains(book) ? (){favorite.remove(book);} : (){favorite.save(book);},
                  backgroundColor: const Color.fromRGBO(255, 0, 0, 0.5),
                  child: favorite.lista.contains(book) ? const Icon(Icons.favorite, color: Colors.white,) : const Icon(Icons.favorite_outline, color: Colors.white,),
                );
            }),
          ],  
      )
    );
  }
}

  // Definindo modelo de tabela para exibição dos dados
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
