import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/models/book.dart';
import 'package:provider/provider.dart';

// Página que exibe todos os detalhes do livro selecionado, bem como permite reservá-lo
class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail({super.key, required this.book});

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
                      _buildTableRow('Título:', book.title),
                      _buildTableRow('Autor(es):', book.author.join(", ")),
                      _buildTableRow('Ano de publicação:', book.publicationYear.toString()),
                      _buildTableRow('Assunto principal:', book.mainField),
                    ],
                  ),
                ),
              ],
            ),
        ),
        floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
        floatingActionButton: Consumer<BooksController>(builder: (context, controller, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Verifica se já foi emprestado. Se não foi, permite reserva
              controller.isBorrowed(book.id) ? const SizedBox.shrink() : Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: controller.isReserved(book.id) ? (){controller.removeReserved(book);} : (){controller.saveReserved(book);},
                  backgroundColor: const Color.fromARGB(195, 0, 230, 172),
                  child: controller.isReserved(book.id) ? const Icon(Icons.bookmark, color: Colors.white,) : const Icon(Icons.bookmark_outline, color: Colors.white,),
                ),
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: controller.isFavorite(book.id) ? (){controller.removeFavorite(book);} : (){controller.saveFavorite(book);},
                backgroundColor: const Color.fromRGBO(255, 0, 0, 0.5),
                child: controller.isFavorite(book.id) ? const Icon(Icons.favorite, color: Colors.white,) : const Icon(Icons.favorite_outline, color: Colors.white,),
              )
            ],
          );
        })
      
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
