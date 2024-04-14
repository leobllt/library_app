import 'dart:convert';
import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/books_repository.dart';

// Repositório local
class MemoryBooksRepository extends BooksRepository {
  final List<Book> _allBooks = [];
  late final List<dynamic> _borrowedBooks;
  late final List<dynamic> _reservedBooks;
  late final List<dynamic> _favoriteBooks;
 
  MemoryBooksRepository(){

    //NÂO CONSEGUI CARREGAR ARQUIVO EXTERNO! Erro por razão de que, para carregar arquivo, precisa ser função assíncrona, o que não dá pra usar aqui
    //var input = File("allbooks_data.json").readAsString();

    // Dados de todos os livros cadastrados
    String input = '''[
            {
                "id": "01", 
                "imgSrc": "assets/imgs/l1.jpg", 
                "title": "Algoritmos: Teoria e Prática", 
                "author": ["Thomas H. Cormen", "Charles E. Leiserson", "Ronaldo L. Rivest", "Clifford Stein"], 
                "publicationYear": 2012, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "02", 
                "imgSrc": "assets/imgs/l2.jpg", 
                "title": "Redes de Computadores", 
                "author": ["Andrew Tanenbaum", "Nick Feamster", "David Wetherall"], 
                "publicationYear": 2021, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "03", 
                "imgSrc": "assets/imgs/l3.jpg", 
                "title": "Sistemas Operacionais Modernos", 
                "author": ["Andrew Tanenbaum", "Hebert Bos"], 
                "publicationYear": 2015, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "04", 
                "imgSrc": "assets/imgs/l4.jpg", 
                "title": "Engenharia de Software", 
                "author": ["Roger S. Pressman", "Bruce R. Maxin"], 
                "publicationYear": 2021, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "05", 
                "imgSrc": "assets/imgs/l5.jpg", 
                "title": "Java: Como Programar", 
                "author": ["Paul Deitel", "Harvey Deitel"], 
                "publicationYear": 2016, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "06", 
                "imgSrc": "assets/imgs/l6.jpg", 
                "title": "Fundamentos de HTML5 e CSS3", 
                "author": ["Maurício Samy Silva"], 
                "publicationYear": 2015, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "07", 
                "imgSrc": "assets/imgs/l7.jpg", 
                "title": "Controlando Versões com Git e Github", 
                "author": ["Alexandres Aquiles"], 
                "publicationYear": 2014, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "08", 
                "imgSrc": "assets/imgs/l8.jpg", 
                "title": "Princípios do Web Design Maravilhoso", 
                "author": ["Jason Beaird"], 
                "publicationYear": 2016, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "09", 
                "imgSrc": "assets/imgs/l9.jpg", 
                "title": "Interação Humano-Computador", 
                "author": ["David Benyon"], 
                "publicationYear": 2015, 
                "mainField": "Ciência da Computação"
            },
            {
                "id": "10", 
                "imgSrc": "assets/imgs/l10.jpg", 
                "title": "Criptografia e Segurança de Redes: princípios e práticas", 
                "author": ["William Stallings"], 
                "publicationYear": 2015, 
                "mainField": "Ciência da Computação"
            }
        ]''';

    // Lendo dados e transformando em lista no repositório
    List<dynamic> data = jsonDecode(input);

    for (var book in data) {
      _allBooks.add(
        Book(
          id: book["id"],
          imgSrc: book["imgSrc"],
          title: book["title"],
          author: book["author"],
          publicationYear: book["publicationYear"],
          mainField: book["mainField"],
        )
      );
    }

    // Demais dados do usuário: livros emprestados, reservados e favoritados
    //var input2 = File("test_data.json").readAsString();
    String input2 = '''{
      "borrowed": ["01", "02", "03", "04"],
      "reserved": [],
      "favorite": ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"]
  }''';

    var data2 = jsonDecode(input2);
    _borrowedBooks = data2["borrowed"];
    _reservedBooks = data2["reserved"];
    _favoriteBooks = data2["favorite"];
  }

  @override
  Future<List<Book>> fetchAllBooks(){
    return Future.value(_allBooks);
  }

 @override
  Future<List<Book>> fetchBorrowedBooks() async {
    return Future.value((_allBooks.where((book) => _borrowedBooks.contains(book.id))).toList());
  }

  @override
  Future<List<Book>> fetchReservedBooks() async {
    return Future.value((_allBooks.where((book) => _reservedBooks.contains(book.id))).toList());
  }

  @override
  Future<List<Book>> fetchFavoriteBooks() async {
    return Future.value((_allBooks.where((book) => _favoriteBooks.contains(book.id))).toList());
  }

  @override
  Future<List<Book>> searchQuery(String bookName) async {
    return Future.value(_allBooks.where((book) => book.title.toLowerCase().contains(bookName.toLowerCase())).toList());
  }

  @override
  Future<bool> createReserved(String id){
    if(!_reservedBooks.contains(id)){
      _reservedBooks.add(id);
      return Future.value(true);
    }
      
    return Future.value(false);
  }

  @override
  Future<bool> deleteReserved(String id){
    return Future.value(_reservedBooks.remove(id));
  }

  @override
  Future<bool> createFavorite(String id){
    if(!_favoriteBooks.contains(id)){
      _favoriteBooks.add(id);
      return Future.value(true);
    }
      
    return Future.value(false);
  }

  @override
  Future<bool> deletefavorite(String id){
    return Future.value(_favoriteBooks.remove(id));
  }

  @override
  Future<Book> findById(String id){
    return Future.value(_allBooks.firstWhere((book) => book.id == id));
  }

  @override
  bool isReserved(String id){
    return _reservedBooks.contains(id);
  }

  @override
  bool isBorrowed(String id){
    return _borrowedBooks.contains(id);
  }

  @override
  bool isFavorite(String id){
    return _favoriteBooks.contains(id);
  }

  List<dynamic> get borrowedBooks => _borrowedBooks;
  List<dynamic> get reservedBooks => _reservedBooks;
  List<dynamic> get favoriteBooks => _favoriteBooks;
}