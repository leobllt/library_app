import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/services/auth_services.dart';

class UserDataRepository extends ChangeNotifier{
  final List<Book> _listaEmprestados = [];
  late FirebaseFirestore db;
  late AuthService auth;
  bool isLoading = true;

  UserDataRepository({required this.auth}){
    _startRepository();
  }

  Future<void> _startRepository() async{
    await _startFirebase();
    await _readBorrowed();
  }

  Future<void> _startFirebase() async{
    db = DBFirestore.get();
  }

  Future<void> _readBorrowed() async{
    if(auth.usuario != null && _listaEmprestados.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/emprestimos').get();
      
      if(snapshot.docs.isEmpty) return;

      snapshot.docs.forEach((doc) async {
        final book = await db.collection('livros')
                          .doc(doc.get('livro'))
                          .get()
                          .then((value) => value.data());
        if(book != null){
          _listaEmprestados.add(
            Book(
              id: doc.get('livro'),
              imgSrc: 'assets/imgs/${doc.get('livro')}.jpg',
              titulo: book['titulo'],
              autores: book['autores'],
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel']
            ) 
          );
          notifyListeners();
        }
      });

    }
  }

  UnmodifiableListView<Book> get lista => UnmodifiableListView(_listaEmprestados);
}