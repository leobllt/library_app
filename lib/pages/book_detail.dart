import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  final Function(String) reservar;
  const BookDetail({super.key, required this.book, required this.reservar});

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
                  color: Color.fromRGBO(0,0,0, 0.03),
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
                Center(
                  child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
                          minimumSize: const Size(150, 50)
                        ),
                        onPressed: () { reservar(book.id); },
                        child: const Text('Reservar'),
                      )
                )
              ],
            ),
        ),
      );
  }
  }

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
