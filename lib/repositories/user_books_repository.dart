import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/services/auth_services.dart';

class UserBooksRepository extends ChangeNotifier{
  final List<Book> _reservedBooks = [];
  final Map<Book,DateTime> _borrowedBooks = {};
  late FirebaseFirestore db;
  late AuthService auth;
  bool isLoading = true;

  UserBooksRepository({required this.auth}){
    _startRepository();
  }

  Future<void> _startRepository() async{
    await _startFirebase();
    await _readBorrowed();
    await _readReserved();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _startFirebase() async{
    db = DBFirestore.get();
  }

  Future<void> _readReserved() async{
    if(auth.usuario != null && _reservedBooks.isEmpty){
      final snapshot = await db.collection('usuarios')
                            .doc(auth.usuario!.uid)
                            .get();
      final List<dynamic> reservados = snapshot.get('reservados') ?? [];

      reservados.forEach((element) async{
        final book = await db.collection('livros')
                          .doc(element.toString())
                          .get()
                          .then((value) => value.data());
        if(book != null){
          _reservedBooks.add(
            Book(
              id: element,
              imgSrc: 'assets/imgs/$element.jpg',
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
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

  Future<void> _readBorrowed() async{
    if(auth.usuario != null && _borrowedBooks.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/emprestimos').get();
      
      if(snapshot.docs.isEmpty) return;

      snapshot.docs.forEach((doc) async {
        final book = await db.collection('livros')
                          .doc(doc.get('livro'))
                          .get()
                          .then((value) => value.data());
        
        Timestamp t = doc.get('dataEntrega');

        if(book != null){
          _borrowedBooks.addAll({
            Book(
              id: doc.get('livro'),
              imgSrc: 'assets/imgs/${doc.get('livro')}.jpg',
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel']
            ) :
            t.toDate()
          }
          );
          notifyListeners();
        }
      });

    }
  }

  UnmodifiableListView<Book> get reservedList => UnmodifiableListView(_reservedBooks);
  UnmodifiableMapView<Book,DateTime> get borrowedList => UnmodifiableMapView(_borrowedBooks);

  void saveReserved(Book book) async {
    if(auth.usuario == null) return;

    if(!_reservedBooks.contains(book)){
      _reservedBooks.add(book);
      notifyListeners();
      await db.collection('usuarios')
            .doc(auth.usuario!.uid)
            .update({
              'reservados': FieldValue.arrayUnion([book.id]),
            });
    }
  }

  void removeReserved(Book book) async{
    if(auth.usuario == null) return;

    _reservedBooks.remove(book);
    notifyListeners();
    await db.collection('usuarios')
          .doc(auth.usuario!.uid)
          .update({
            'reservados': FieldValue.arrayRemove([book.id])
          });
    }
}