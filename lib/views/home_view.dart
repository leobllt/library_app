import 'package:flutter/material.dart';
import 'package:library_app/pages/favorite_page.dart';
import 'package:library_app/pages/qr_code_page.dart';
import 'package:library_app/repositories/user_books_repository.dart';
import 'package:library_app/repositories/user_data_repository.dart';
import 'package:library_app/widgets/horizontal_book_list.dart';
import 'package:library_app/widgets/section_heading.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// View principal, que exibe os livros emprestados e reservados
class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${context.watch<UserDataRepository>().contaLogada?.nome ?? ''}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrCodePage()),
              );
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            }, 
          ),
        ],
        backgroundColor: const Color.fromRGBO(0, 255, 191, 1),
      ),
      body: Consumer<UserBooksRepository>(
              builder: (context, userBooks, _) {
                return (userBooks.isLoading) ? 
                        const Center(child: SizedBox(width: 40, height: 40,child: CircularProgressIndicator()),)
                        : Column(
                          children: [          
                            const Padding(padding: EdgeInsets.all(15)),
                            const SectionHeading(headTitle: "Títulos emprestados", icondata: Icons.library_add_check),
                            HorizontalBookList(list: userBooks.borrowedMap.keys.toList()),
                            const Padding(padding: EdgeInsets.all(20)),
                            const SectionHeading(headTitle: "Títulos reservados", icondata: Icons.bookmark),
                           HorizontalBookList(list: userBooks.reservedList)
                    ]);   
                  }
            )
     );
  }

}