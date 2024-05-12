import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/services/auth_services.dart';

class FavoriteRepository extends ChangeNotifier{
  final List<Book> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;
  bool isLoading = true;

  FavoriteRepository({required this.auth}){
    _startRepository();
  }

  Future<void> _startRepository() async{
    await _startFirebase();
    await _readFavorite();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _startFirebase() async{
    db = DBFirestore.get();
  }

  Future<void> _readFavorite() async{
    if(auth.usuario != null && _lista.isEmpty){
      final snapshot = await db.collection('usuarios')
                            .doc(auth.usuario!.uid)
                            .get();
      final List<dynamic> favoritos = snapshot.get('favoritos') ?? [];

      favoritos.forEach((element) async{
        final book = await db.collection('livros')
                          .doc(element.toString())
                          .get()
                          .then((value) => value.data());
        if(book != null){
          _lista.add(
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

  UnmodifiableListView<Book> get lista => UnmodifiableListView(_lista);

  void save(Book book) async {
    if(auth.usuario == null) return;

    if(!_lista.contains(book)){
      _lista.add(book);
      notifyListeners();
      await db.collection('usuarios')
            .doc(auth.usuario!.uid)
            .update({
              'favoritos': FieldValue.arrayUnion([book.id]),
            });
    }
  }

  void remove(Book book) async{
    if(auth.usuario == null) return;

    _lista.remove(book);
    notifyListeners();
    await db.collection('usuarios')
          .doc(auth.usuario!.uid)
          .update({
            'favoritos': FieldValue.arrayRemove([book.id])
          });
    }
}