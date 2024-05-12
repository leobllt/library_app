import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/services/auth_services.dart';

class SearchException implements Exception{
  String message;
  SearchException({required this.message});
}

class SearchQuery{
  late FirebaseFirestore db;
  late AuthService auth;

  SearchQuery._();

  static Future<List<Book>> searchBooks(String keywords) async {
    FirebaseFirestore db = DBFirestore.get();
    final snapshot = await db.collection('livros').where('titulo', isGreaterThan: keywords.toLowerCase()).where('titulo', isLessThanOrEqualTo: keywords.toLowerCase() + '\uffff').get();
      
    List<Book> result = [];
    
    if(snapshot.docs.isNotEmpty){
      snapshot.docs.forEach((doc) {
        final book = doc.data();
        result.add(
            Book(
              id: doc.id,
              imgSrc: 'assets/imgs/${doc.id}.jpg',
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel']
            ) 
          );
      });
    }
                    
    return result;
  }
}