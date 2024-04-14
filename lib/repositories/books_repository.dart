import 'package:library_app/models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> fetchAllBooks();
  Future<List<Book>> fetchBorrowedBooks();
  Future<List<Book>> fetchReservedBooks();
  Future<List<Book>> fetchFavoriteBooks();
  Future<List<Book>> searchQuery(String bookName);
  Future<bool> createReserved(String id);
  Future<bool> deleteReserved(String id);
  Future<bool> createFavorite(String id);
  Future<bool> deletefavorite(String id);
  Future<Book> findById(String id);
  bool isReserved(String id);
  bool isBorrowed(String id);
  bool isFavorite(String id);
}