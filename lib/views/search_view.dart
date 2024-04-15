import 'package:flutter/material.dart';
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/widgets/vertical_book_list.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consulta acervo'),
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildSearchField(),
                ),
                const SizedBox(width: 10),
                _buildSearchButton(context),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _value,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Livro, Autor...",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Caixa de pesquisa vazia";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(vertical: 10),
      onPressed: () => _verificarForm(context),
      icon: const Icon(
        Icons.search,
        size: 35,
      ),
    );
  }

  void _verificarForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String searchTerm = _value.text;
      final booksController = context.read<BooksController>();
      booksController.searchQuery(searchTerm).then((searchResults) {
        booksController.setSearchResults(searchResults);
      });
    }
  }

  Widget _buildSearchResults() {
    return Consumer<BooksController>(
      builder: (context, controller, _) {
        final searchResults = controller.searchResults;
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return VerticalBookList(list: searchResults);
      },
    );
  }
}
