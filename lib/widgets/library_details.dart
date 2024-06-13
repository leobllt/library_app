import 'package:flutter/material.dart';
import 'package:library_app/models/library.dart';

class LibraryDetails extends StatelessWidget {
  Library lib;
  LibraryDetails({Key? key, required this.lib}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Image.asset(lib.imgSrc,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24),
            child: Text(
              lib.nome,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 24),
            child: Text(
              lib.endereco,
            ),
          ),
        ],
      ),
    );
  }
}