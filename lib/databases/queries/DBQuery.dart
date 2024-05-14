import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_app/databases/db_firestore.dart';
import 'package:library_app/models/book.dart';

class SearchException implements Exception{
  String message;
  SearchException({required this.message});
}

// Classe para executar queries específicas no BD, sem depender de um repositório
class DBQuery{
  late FirebaseFirestore db;

  DBQuery._();

  // Retorna todos os livros que iniciem com 'keywords'
  static Future<List<Book>> searchBooks(String keywords) async {
    FirebaseFirestore db = DBFirestore.get();
    
    final snapshot = await db.collection('livros').where(
                                                      Filter.or(
                                                        Filter.and(
                                                          Filter('titulo', isGreaterThanOrEqualTo: keywords.toLowerCase()), 
                                                          Filter('titulo', isLessThanOrEqualTo: keywords.toLowerCase() + '\uffff')
                                                        ),
                                                        Filter('autores', arrayContains: keywords)
                                                      )
                                                      ).get();

    List<Book> result = [];

    if(snapshot.docs.isNotEmpty){
      snapshot.docs.forEach((doc) {
        final book = doc.data();
        result.add(
            Book(
              id: doc.id,
              titulo: book['titulo'],
              autores: List<String>.from(book['autores']),
              anoPublicacao: book['anoPublicacao'],
              numeroPaginas: book['numeroPaginas'],
              areaPrincipal: book['areaPrincipal'],
              disponivel: book['disponivel'],
              url: book['url']
            ) 
          );
      });
    }
          
    return result;
  }
  
  // Insere um novo documento na coleção 'feedbacks'
  static insertFeedback(String userId, String option, String description){
    FirebaseFirestore db = DBFirestore.get();
    final doc = db.collection('feedbacks').doc();
    doc.set({
      'usuario': userId,
      'opcao': option,
      'descricao': description
    });
  }
}