import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/services/auth_services.dart';

class UserBooksRepository extends ChangeNotifier{
  final List<Book> _reservedBooks = [];
  final Map<Book,DateTime> _borrowedBooks = {};
  final Map<Book,DateTime> _bookHistory = {};
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
    await _readHistory();
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
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel'],
              url: book['url']
            )
          );
          notifyListeners();
        }
      });
    }
  }

  Future<void> _readBorrowed() async{
    if(auth.usuario != null && _borrowedBooks.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/emprestimos').where('entregue', isEqualTo: false).get();
      
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
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel'],
              url: book['url']
            ) :
            t.toDate()
          }
          );
          notifyListeners();
        }
      });

    }
  }


Future<void> _readHistory() async{
    if(auth.usuario != null && _bookHistory.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/emprestimos').where('entregue', isEqualTo: true).get();
      
      if(snapshot.docs.isEmpty) return;

      snapshot.docs.forEach((doc) async {
        final book = await db.collection('livros')
                          .doc(doc.get('livro'))
                          .get()
                          .then((value) => value.data());
        
        Timestamp t = doc.get('dataEntrega');

        if(book != null){
          _bookHistory.addAll({
            Book(
              id: doc.get('livro'),
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel'],
              url: book['url']
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
  UnmodifiableMapView<Book,DateTime> get borrowedMap => UnmodifiableMapView(_borrowedBooks);
  UnmodifiableMapView<Book,DateTime> get historyMap => UnmodifiableMapView(_bookHistory);


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