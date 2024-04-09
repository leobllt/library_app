import 'package:flutter/foundation.dart';

import '../models/book.dart';
import '../repositories/books_repository.dart';

class BooksController extends ChangeNotifier {
  final BooksRepository booksRepository;
  late final List<Book> borrowedBooks;
  List<Book> reservedBooks = [];
  List<Book> favoriteBooks = [];
  bool loading = true;

  BooksController(this.booksRepository) {
    loadBorrowed();
    loadReserved();
    loadFavorite();
  }

  void loadBorrowed() async {
    borrowedBooks = await booksRepository.fetchBorrowedBooks();
  }

  Future<List<Book>> loadReserved() async {
    loading = true;
    notifyListeners();
    reservedBooks = await booksRepository.fetchReservedBooks();
    loading = false;
    notifyListeners();

    return reservedBooks;
  }

  Future<bool> saveReserved(Book book) async {
    final success = await booksRepository.createReserved(book.id);

    if (success) {
      reservedBooks = await booksRepository.fetchReservedBooks();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<void> removeReserved(Book book) async {
  final success = await booksRepository.deleteReserved(book.id);

    if (success) {
      reservedBooks.remove(book);
    }
    notifyListeners();
  }

  Future<List<Book>> loadFavorite() async {
    loading = true;
    notifyListeners();
    favoriteBooks = await booksRepository.fetchFavoriteBooks();
    loading = false;
    notifyListeners();

    return reservedBooks;
  }

  Future<bool> saveFavorite(Book book) async {
    final success = await booksRepository.createFavorite(book.id);

    if (success) {
      favoriteBooks = await booksRepository.fetchFavoriteBooks();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<void> removeFavorite(Book book) async {
  final success = await booksRepository.deletefavorite(book.id);

    if (success) {
      favoriteBooks.remove(book);
    }
    notifyListeners();
  }
}